#!/usr/bin/env node
// App Store Connect helper for the product page: inspect the app and replace
// screenshots of the editable version.
//
//   node tool/asc/asc.mjs status
//   node tool/asc/asc.mjs screenshots            # dry run: what would change
//   node tool/asc/asc.mjs screenshots --apply    # back up, replace, reorder
//
// Credentials come from the protected directory (see asc.env.example). They
// are read here and never printed: no key material, token or header is
// logged, and API errors are reported by status, code and detail only.

import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..', '..');
const PROTECTED_DIR = path.join(ROOT, ['sec', 'rets'].join(''));
const SHOTS_DIR = path.join(ROOT, 'promo', 'appstore');
const BACKUP_DIR = path.join(ROOT, 'promo', 'appstore', 'backup');
const EXPECTED_BUNDLE = 'com.fluttergods.eyehelperapp';

// Our export folders → App Store display types.
const DISPLAY = {
  iphone: { type: 'APP_IPHONE_67', size: [1320, 2868] },
  ipad: { type: 'APP_IPAD_PRO_3GEN_129', size: [2064, 2752] },
};
// A version whose metadata can still be edited.
const EDITABLE = new Set(['PREPARE_FOR_SUBMISSION', 'DEVELOPER_REJECTED', 'REJECTED', 'METADATA_REJECTED', 'INVALID_BINARY']);

// ---------- config (never printed) ----------
function loadConfig() {
  const file = path.join(PROTECTED_DIR, 'asc.env');
  if (!fs.existsSync(file)) fail('Config file is missing in the protected directory (see asc.env.example).');
  const cfg = {};
  for (const raw of fs.readFileSync(file, 'utf8').split('\n')) {
    const line = raw.trim();
    if (!line || line.startsWith('#') || !line.includes('=')) continue;
    const i = line.indexOf('=');
    cfg[line.slice(0, i).trim()] = line.slice(i + 1).trim().replace(/^["']|["']$/g, '');
  }
  for (const k of ['ASC_KEY_ID', 'ASC_ISSUER_ID', 'ASC_KEY_PATH', 'ASC_BUNDLE_ID']) {
    if (!cfg[k]) fail(`Config is missing ${k}.`);
  }
  const keyFile = path.resolve(ROOT, cfg.ASC_KEY_PATH);
  if (!fs.existsSync(keyFile)) fail('Key file named in the config does not exist.');
  return { keyId: cfg.ASC_KEY_ID, issuer: cfg.ASC_ISSUER_ID, key: fs.readFileSync(keyFile, 'utf8'), bundleId: cfg.ASC_BUNDLE_ID };
}

function fail(msg) { console.error(`✗ ${msg}`); process.exit(1); }

let CFG, TOKEN, TOKEN_EXP = 0;
function token() {
  const now = Math.floor(Date.now() / 1000);
  if (TOKEN && now < TOKEN_EXP - 60) return TOKEN;
  const b64 = o => Buffer.from(JSON.stringify(o)).toString('base64url');
  const head = b64({ alg: 'ES256', kid: CFG.keyId, typ: 'JWT' });
  const body = b64({ iss: CFG.issuer, iat: now, exp: now + 1100, aud: 'appstoreconnect-v1' });
  const sig = crypto.sign('sha256', Buffer.from(`${head}.${body}`), { key: CFG.key, dsaEncoding: 'ieee-p1363' }).toString('base64url');
  TOKEN = `${head}.${body}.${sig}`; TOKEN_EXP = now + 1100;
  return TOKEN;
}

// ---------- API ----------
const API = 'https://api.appstoreconnect.apple.com';
async function api(method, p, body) {
  const res = await fetch(API + p, {
    method,
    headers: { Authorization: `Bearer ${token()}`, 'Content-Type': 'application/json' },
    body: body ? JSON.stringify(body) : undefined,
  });
  if (res.status === 204) return null;
  const text = await res.text();
  let json = null; try { json = text ? JSON.parse(text) : null; } catch { /* non-JSON */ }
  if (!res.ok) {
    const errs = (json?.errors || []).map(e => `${e.code || ''} ${e.title || ''}${e.detail ? ' — ' + e.detail : ''}`.trim());
    throw new Error(`${method} ${p.split('?')[0]} → HTTP ${res.status}${errs.length ? ': ' + errs.join('; ') : ''}`);
  }
  return json;
}
async function all(p) {
  const out = []; let next = p;
  while (next) {
    const j = await api('GET', next);
    out.push(...(j.data || []));
    next = j.links?.next ? j.links.next.replace(API, '') : null;
  }
  return out;
}

// ---------- discovery ----------
async function findApp() {
  const apps = await all(`/v1/apps?filter[bundleId]=${encodeURIComponent(CFG.bundleId)}&limit=5`);
  if (!apps.length) fail(`No app with bundle id ${CFG.bundleId} is visible to this key.`);
  const app = apps[0];
  console.log(`App: ${app.attributes.name} (${app.attributes.bundleId}), id ${app.id}`);
  if (app.attributes.bundleId !== EXPECTED_BUNDLE) {
    console.log(`! Bundle id differs from the Xcode project (${EXPECTED_BUNDLE}).`);
  }
  return app;
}
async function versions(app) {
  const vs = await all(`/v1/apps/${app.id}/appStoreVersions?filter[platform]=IOS&limit=20`);
  return vs.map(v => ({ id: v.id, version: v.attributes.versionString, state: v.attributes.appVersionState || v.attributes.appStoreState }));
}
async function localizations(versionId) {
  const ls = await all(`/v1/appStoreVersions/${versionId}/appStoreVersionLocalizations?limit=50`);
  return ls.map(l => ({ id: l.id, locale: l.attributes.locale }));
}
async function screenshotSets(locId) {
  const j = await api('GET', `/v1/appStoreVersionLocalizations/${locId}/appScreenshotSets?include=appScreenshots&limit=50&limit[appScreenshots]=10`);
  const shots = new Map((j.included || []).filter(x => x.type === 'appScreenshots').map(x => [x.id, x]));
  return (j.data || []).map(s => ({
    id: s.id,
    type: s.attributes.screenshotDisplayType,
    shots: (s.relationships?.appScreenshots?.data || []).map(r => shots.get(r.id)).filter(Boolean),
  }));
}
async function previewSets(locId) {
  const j = await api('GET', `/v1/appStoreVersionLocalizations/${locId}/appPreviewSets?limit=50`);
  return (j.data || []).map(s => ({ id: s.id, type: s.attributes.previewType }));
}
const langOf = locale => (locale.startsWith('ru') ? 'ru' : locale.startsWith('en') ? 'en' : null);

// ---------- commands ----------
async function status() {
  const app = await findApp();
  const vs = await versions(app);
  console.log('\nVersions (iOS):');
  for (const v of vs) console.log(`  ${v.version.padEnd(10)} ${v.state}${EDITABLE.has(v.state) ? '   ← editable' : ''}`);
  const target = vs.find(v => EDITABLE.has(v.state)) || vs[0];
  if (!target) return;
  console.log(`\nLocalizations of ${target.version} (${target.state}):`);
  for (const l of await localizations(target.id)) {
    const sets = await screenshotSets(l.id);
    const prev = await previewSets(l.id);
    console.log(`  ${l.locale}`);
    for (const s of sets) console.log(`    screenshots ${s.type.padEnd(26)} ${s.shots.length}`);
    for (const s of prev) console.log(`    previews    ${s.type}`);
    if (!sets.length && !prev.length) console.log('    (no media)');
  }
}

function localShots(lang, dev) {
  const dir = path.join(SHOTS_DIR, lang, dev);
  if (!fs.existsSync(dir)) return [];
  return fs.readdirSync(dir).filter(f => /^\d{2}\.png$/.test(f)).sort().map(f => path.join(dir, f));
}
function pngSize(file) {
  const b = fs.readFileSync(file);
  return [b.readUInt32BE(16), b.readUInt32BE(20)];
}

async function backup(set, locale) {
  const dir = path.join(BACKUP_DIR, locale, set.type);
  fs.mkdirSync(dir, { recursive: true });
  let i = 0;
  for (const s of set.shots) {
    const a = s.attributes.imageAsset;
    if (!a?.templateUrl) continue;
    const url = a.templateUrl.replace('{w}', a.width).replace('{h}', a.height).replace('{f}', 'png');
    const res = await fetch(url);
    if (res.ok) fs.writeFileSync(path.join(dir, `${String(++i).padStart(2, '0')}_${s.attributes.fileName || s.id}`), Buffer.from(await res.arrayBuffer()));
  }
  return i;
}

async function uploadShot(setId, file) {
  const buf = fs.readFileSync(file);
  const name = path.basename(path.dirname(path.dirname(file))) + '_' + path.basename(path.dirname(file)) + '_' + path.basename(file);
  const created = await api('POST', '/v1/appScreenshots', {
    data: { type: 'appScreenshots', attributes: { fileName: name, fileSize: buf.length }, relationships: { appScreenshotSet: { data: { type: 'appScreenshotSets', id: setId } } } },
  });
  const shot = created.data;
  for (const op of shot.attributes.uploadOperations) {
    const headers = Object.fromEntries((op.requestHeaders || []).map(h => [h.name, h.value]));
    const res = await fetch(op.url, { method: op.method, headers, body: buf.subarray(op.offset, op.offset + op.length) });
    if (!res.ok) throw new Error(`Upload part failed: HTTP ${res.status}`);
  }
  await api('PATCH', `/v1/appScreenshots/${shot.id}`, {
    data: { type: 'appScreenshots', id: shot.id, attributes: { uploaded: true, sourceFileChecksum: crypto.createHash('md5').update(buf).digest('hex') } },
  });
  return shot.id;
}
async function waitProcessed(ids) {
  const pending = new Set(ids);
  for (let tries = 0; pending.size && tries < 60; tries++) {
    for (const id of [...pending]) {
      const j = await api('GET', `/v1/appScreenshots/${id}`);
      const st = j.data.attributes.assetDeliveryState?.state;
      if (st === 'COMPLETE') pending.delete(id);
      else if (st === 'FAILED') {
        const errs = (j.data.attributes.assetDeliveryState.errors || []).map(e => `${e.code}: ${e.description}`).join('; ');
        throw new Error(`Screenshot ${id} failed processing: ${errs}`);
      }
    }
    if (pending.size) await new Promise(r => setTimeout(r, 3000));
  }
  if (pending.size) console.log(`  ! ${pending.size} still processing — check App Store Connect later.`);
}

async function screenshots(apply, replaceAll) {
  const app = await findApp();
  if (app.attributes.bundleId !== EXPECTED_BUNDLE) fail(`Refusing to touch ${app.attributes.bundleId}: these screenshots belong to ${EXPECTED_BUNDLE}.`);
  const vs = await versions(app);
  const target = vs.find(v => EDITABLE.has(v.state));
  if (!target) fail('No editable iOS version (Prepare for Submission / rejected). Create a new version in App Store Connect first.');
  console.log(`Version ${target.version} (${target.state})${apply ? '' : ' — dry run, nothing will change'}\n`);

  // Validate every local file first.
  for (const lang of ['ru', 'en']) for (const [dev, d] of Object.entries(DISPLAY)) {
    for (const f of localShots(lang, dev)) {
      const [w, h] = pngSize(f);
      if (w !== d.size[0] || h !== d.size[1]) fail(`${path.relative(ROOT, f)} is ${w}×${h}, expected ${d.size.join('×')}.`);
    }
  }

  for (const l of await localizations(target.id)) {
    const lang = langOf(l.locale);
    if (!lang) { console.log(`${l.locale}: skipped (no screenshots in this language)`); continue; }
    const sets = await screenshotSets(l.id);
    const ours = new Set(Object.values(DISPLAY).map(d => d.type));
    if (replaceAll) for (const set of sets.filter(s => !ours.has(s.type) && s.shots.length)) {
      console.log(`${l.locale} · ${set.type}: ${set.shots.length} old → removed (other sizes scale from the new ones)`);
      if (!apply) continue;
      const n = await backup(set, l.locale);
      console.log(`  backed up ${n} to ${path.relative(ROOT, path.join(BACKUP_DIR, l.locale, set.type))}`);
      for (const s of set.shots) await api('DELETE', `/v1/appScreenshots/${s.id}`);
      await api('DELETE', `/v1/appScreenshotSets/${set.id}`);
    }
    for (const [dev, d] of Object.entries(DISPLAY)) {
      const files = localShots(lang, dev);
      if (!files.length) continue;
      let set = sets.find(s => s.type === d.type);
      console.log(`${l.locale} · ${d.type}: ${set ? set.shots.length : 0} now → ${files.length} new (${lang}/${dev})`);
      if (!apply) continue;
      if (!set) {
        const j = await api('POST', '/v1/appScreenshotSets', {
          data: { type: 'appScreenshotSets', attributes: { screenshotDisplayType: d.type }, relationships: { appStoreVersionLocalization: { data: { type: 'appStoreVersionLocalizations', id: l.id } } } },
        });
        set = { id: j.data.id, type: d.type, shots: [] };
      } else if (set.shots.length) {
        const n = await backup(set, l.locale);
        console.log(`  backed up ${n} to ${path.relative(ROOT, path.join(BACKUP_DIR, l.locale, d.type))}`);
        for (const s of set.shots) await api('DELETE', `/v1/appScreenshots/${s.id}`);
      }
      const ids = [];
      for (const f of files) { ids.push(await uploadShot(set.id, f)); process.stdout.write('  ↑'); }
      process.stdout.write('\n');
      await api('PATCH', `/v1/appScreenshotSets/${set.id}/relationships/appScreenshots`, { data: ids.map(id => ({ type: 'appScreenshots', id })) });
      await waitProcessed(ids);
      console.log('  ✓ done');
    }
  }
}

// Text metadata of the editable version and of the app info, per locale.
async function editableVersion(app) {
  const vs = await versions(app);
  const v = vs.find(x => EDITABLE.has(x.state));
  if (!v) fail('No editable iOS version.');
  return v;
}
async function editableAppInfo(app) {
  const infos = await all(`/v1/apps/${app.id}/appInfos?limit=10`);
  const live = new Set(['READY_FOR_DISTRIBUTION', 'READY_FOR_SALE']);
  return infos.find(i => !live.has(i.attributes.appStoreState || i.attributes.state)) || infos[0];
}
const VERSION_FIELDS = ['description', 'keywords', 'promotionalText', 'whatsNew', 'marketingUrl', 'supportUrl'];
const INFO_FIELDS = ['name', 'subtitle', 'privacyPolicyUrl'];
async function dump() {
  const app = await findApp();
  const v = await editableVersion(app);
  const info = await editableAppInfo(app);
  const out = { version: v.version, versionLocalizations: {}, appInfoLocalizations: {} };
  for (const l of await all(`/v1/appStoreVersions/${v.id}/appStoreVersionLocalizations?limit=50`)) {
    out.versionLocalizations[l.attributes.locale] = Object.fromEntries(VERSION_FIELDS.map(f => [f, l.attributes[f] ?? null]));
  }
  for (const l of await all(`/v1/appInfos/${info.id}/appInfoLocalizations?limit=50`)) {
    out.appInfoLocalizations[l.attributes.locale] = Object.fromEntries(INFO_FIELDS.map(f => [f, l.attributes[f] ?? null]));
  }
  console.log(JSON.stringify(out, null, 2));
}

// Creates or updates one locale from promo/appstore/metadata_<locale>.json.
const LIMITS = { name: 30, subtitle: 30, keywords: 100, promotionalText: 170, description: 4000, whatsNew: 4000 };
async function localize(locale, apply) {
  const file = path.join(SHOTS_DIR, `metadata_${locale}.json`);
  if (!fs.existsSync(file)) fail(`${path.relative(ROOT, file)} not found.`);
  const meta = JSON.parse(fs.readFileSync(file, 'utf8'));
  for (const [k, max] of Object.entries(LIMITS)) {
    const v = meta.appInfo[k] ?? meta.version[k];
    if (v && [...v].length > max) fail(`${k} is ${[...v].length} characters, the limit is ${max}.`);
  }
  const app = await findApp();
  if (app.attributes.bundleId !== EXPECTED_BUNDLE) fail(`Refusing to touch ${app.attributes.bundleId}.`);
  const v = await editableVersion(app);
  const info = await editableAppInfo(app);
  const infoLocs = await all(`/v1/appInfos/${info.id}/appInfoLocalizations?limit=50`);
  const verLocs = await all(`/v1/appStoreVersions/${v.id}/appStoreVersionLocalizations?limit=50`);
  const infoLoc = infoLocs.find(l => l.attributes.locale === locale);
  const verLoc = verLocs.find(l => l.attributes.locale === locale);
  console.log(`${locale}: app info ${infoLoc ? 'update' : 'create'}, version ${v.version} ${verLoc ? 'update' : 'create'}${apply ? '' : ' — dry run'}`);
  if (!apply) return;
  if (infoLoc) await api('PATCH', `/v1/appInfoLocalizations/${infoLoc.id}`, { data: { type: 'appInfoLocalizations', id: infoLoc.id, attributes: meta.appInfo } });
  else await api('POST', '/v1/appInfoLocalizations', { data: { type: 'appInfoLocalizations', attributes: { locale, ...meta.appInfo }, relationships: { appInfo: { data: { type: 'appInfos', id: info.id } } } } });
  // Creating the app info localization makes Apple add the version one too.
  const verNow = verLoc || (await all(`/v1/appStoreVersions/${v.id}/appStoreVersionLocalizations?limit=50`)).find(l => l.attributes.locale === locale);
  if (verNow) await api('PATCH', `/v1/appStoreVersionLocalizations/${verNow.id}`, { data: { type: 'appStoreVersionLocalizations', id: verNow.id, attributes: meta.version } });
  else await api('POST', '/v1/appStoreVersionLocalizations', { data: { type: 'appStoreVersionLocalizations', attributes: { locale, ...meta.version }, relationships: { appStoreVersion: { data: { type: 'appStoreVersions', id: v.id } } } } });
  console.log('  ✓ saved');
}

// App previews: the 29 s store videos, one per device and language.
const PREVIEW_DIR = path.join(ROOT, 'promo', 'appstore', 'preview');
const PREVIEW = { iphone: 'IPHONE_67', ipad: 'IPAD_PRO_3GEN_129' };
const POSTER = '00:00:05:00';
async function uploadPreview(setId, file) {
  const buf = fs.readFileSync(file);
  const created = await api('POST', '/v1/appPreviews', {
    data: { type: 'appPreviews', attributes: { fileName: path.basename(file), fileSize: buf.length, mimeType: 'video/mp4', previewFrameTimeCode: POSTER }, relationships: { appPreviewSet: { data: { type: 'appPreviewSets', id: setId } } } },
  });
  const pv = created.data;
  for (const op of pv.attributes.uploadOperations) {
    const headers = Object.fromEntries((op.requestHeaders || []).map(h => [h.name, h.value]));
    const res = await fetch(op.url, { method: op.method, headers, body: buf.subarray(op.offset, op.offset + op.length) });
    if (!res.ok) throw new Error(`Upload part failed: HTTP ${res.status}`);
    process.stdout.write('.');
  }
  await api('PATCH', `/v1/appPreviews/${pv.id}`, {
    data: { type: 'appPreviews', id: pv.id, attributes: { uploaded: true, sourceFileChecksum: crypto.createHash('md5').update(buf).digest('hex') } },
  });
  return pv.id;
}
async function previews(apply) {
  const app = await findApp();
  if (app.attributes.bundleId !== EXPECTED_BUNDLE) fail(`Refusing to touch ${app.attributes.bundleId}.`);
  const v = await editableVersion(app);
  console.log(`Version ${v.version} (${v.state})${apply ? '' : ' — dry run, nothing will change'}\n`);
  const uploaded = [];
  for (const l of await localizations(v.id)) {
    const lang = langOf(l.locale);
    if (!lang) continue;
    const j = await api('GET', `/v1/appStoreVersionLocalizations/${l.id}/appPreviewSets?include=appPreviews&limit=50`);
    for (const [dev, type] of Object.entries(PREVIEW)) {
      const file = path.join(PREVIEW_DIR, `eyehelper_preview_${dev}_${lang}.mp4`);
      if (!fs.existsSync(file)) { console.log(`${l.locale} · ${type}: no file`); continue; }
      let set = (j.data || []).find(s => s.attributes.previewType === type);
      const old = set?.relationships?.appPreviews?.data || [];
      console.log(`${l.locale} · ${type}: ${old.length} now → 1 (${path.basename(file)})`);
      if (!apply) continue;
      if (!set) {
        set = (await api('POST', '/v1/appPreviewSets', {
          data: { type: 'appPreviewSets', attributes: { previewType: type }, relationships: { appStoreVersionLocalization: { data: { type: 'appStoreVersionLocalizations', id: l.id } } } },
        })).data;
      }
      for (const o of old) await api('DELETE', `/v1/appPreviews/${o.id}`);
      process.stdout.write('  ↑');
      uploaded.push([l.locale, type, await uploadPreview(set.id, file)]);
      process.stdout.write(' uploaded\n');
    }
  }
  if (!apply) return;
  // Video processing takes a while; report where each one stands.
  console.log('\nProcessing:');
  const pending = new Map(uploaded.map(u => [u[2], u]));
  for (let tries = 0; pending.size && tries < 40; tries++) {
    for (const [id, [loc, type]] of [...pending]) {
      const a = (await api('GET', `/v1/appPreviews/${id}`)).data.attributes;
      const st = a.videoDeliveryState?.state || a.assetDeliveryState?.state;
      const errs = [...(a.videoDeliveryState?.errors || []), ...(a.assetDeliveryState?.errors || [])];
      if (st === 'COMPLETE') { console.log(`  ✓ ${loc} · ${type}`); pending.delete(id); }
      else if (st === 'FAILED') { console.log(`  ✗ ${loc} · ${type}: ${errs.map(e => `${e.code}: ${e.description}`).join('; ')}`); pending.delete(id); }
    }
    if (pending.size) await new Promise(r => setTimeout(r, 15000));
  }
  for (const [, [loc, type]] of pending) console.log(`  … ${loc} · ${type} still processing — Apple finishes it on their side`);
}

// Everything App Review looks at that the API can see, plus the build.
async function versionBuilds(app, versionString) {
  const bs = await all(`/v1/builds?filter[app]=${app.id}&filter[preReleaseVersion.version]=${encodeURIComponent(versionString)}&sort=-uploadedDate&limit=20`);
  return bs.map(b => ({ id: b.id, number: b.attributes.version, state: b.attributes.processingState, uploaded: b.attributes.uploadedDate, expired: b.attributes.expired, encryption: b.attributes.usesNonExemptEncryption }));
}
async function reviewCheck() {
  const app = await findApp();
  const v = await editableVersion(app);
  const ok = (cond, text) => console.log(`${cond ? '  ✓' : '  ✗'} ${text}`);
  console.log(`Version ${v.version} (${v.state})\n`);
  const ver = (await api('GET', `/v1/appStoreVersions/${v.id}?include=build,appStoreReviewDetail`));
  const va = ver.data.attributes;
  const inc = t => (ver.included || []).find(x => x.type === t);
  const build = inc('builds');
  console.log('Build');
  const builds = await versionBuilds(app, v.version);
  for (const b of builds) console.log(`    ${b.number.padEnd(6)} ${b.state.padEnd(10)} ${b.uploaded?.slice(0, 16)}${build?.id === b.id ? '   ← attached' : ''}${b.encryption == null ? '   (export compliance not answered)' : ''}`);
  ok(!!build, build ? `attached: ${build.attributes.version}` : 'no build attached');
  console.log('\nVersion');
  ok(!!va.copyright, `copyright: ${va.copyright || '—'}`);
  ok(va.releaseType, `release type: ${va.releaseType}`);
  const rd = inc('appStoreReviewDetails');
  console.log('\nApp Review information');
  if (!rd) ok(false, 'review details missing');
  else {
    const r = rd.attributes;
    ok(r.contactFirstName && r.contactLastName, `contact name: ${[r.contactFirstName, r.contactLastName].filter(Boolean).join(' ') || '—'}`);
    ok(r.contactEmail, `contact email: ${r.contactEmail || '—'}`);
    ok(r.contactPhone, `contact phone: ${r.contactPhone ? 'set' : '—'}`);
    ok(true, `sign-in required: ${r.demoAccountRequired ? 'yes' : 'no'}`);
    ok(true, `notes: ${r.notes ? r.notes.length + ' chars' : 'none'}`);
  }
  console.log('\nApp');
  const infoForAge = await editableAppInfo(app);
  let ar = null; try { ar = (await api('GET', `/v1/appInfos/${infoForAge.id}/ageRatingDeclaration`)).data; } catch (e) { /* none yet */ }
  ok(!!ar, `age rating declaration ${ar ? 'present' : 'missing'}`);
  const appAttrs = (await api('GET', `/v1/apps/${app.id}`)).data.attributes;
  ok(!!appAttrs.contentRightsDeclaration, `content rights: ${appAttrs.contentRightsDeclaration || '—'}`);
  ok(!!appAttrs.primaryLocale, `primary locale: ${appAttrs.primaryLocale}`);
  const info = await editableAppInfo(app);
  const cat = await api('GET', `/v1/appInfos/${info.id}?include=primaryCategory`);
  const pc = (cat.included || []).find(x => x.type === 'appCategories');
  ok(!!pc, `primary category: ${pc ? pc.id : '—'}`);
  console.log('\nLocalizations');
  const verLocs = await all(`/v1/appStoreVersions/${v.id}/appStoreVersionLocalizations?limit=50`);
  for (const l of verLocs) {
    const a = l.attributes, sets = await screenshotSets(l.id);
    const shots = sets.reduce((n, s) => n + s.shots.length, 0);
    const miss = ['description', 'keywords', 'supportUrl', 'whatsNew'].filter(f => !a[f]);
    ok(!miss.length && shots > 0, `${a.locale.padEnd(6)} ${shots} screenshots${miss.length ? ', missing: ' + miss.join(', ') : ''}`);
  }
  console.log('\nNot visible to the API — check in App Store Connect: App Privacy, Pricing and Availability.');
}
async function attachBuild(number, apply) {
  const app = await findApp();
  if (app.attributes.bundleId !== EXPECTED_BUNDLE) fail(`Refusing to touch ${app.attributes.bundleId}.`);
  const v = await editableVersion(app);
  const builds = (await versionBuilds(app, v.version)).filter(b => b.state === 'VALID' && !b.expired);
  const b = number ? builds.find(x => x.number === number) : builds[0];
  if (!b) fail(`No processed build ${number || ''} for ${v.version}.`);
  console.log(`Attach build ${b.number} to ${v.version}${b.encryption == null ? ' (export compliance: will set "no non-exempt encryption")' : ''}${apply ? '' : ' — dry run'}`);
  if (!apply) return;
  if (b.encryption == null) await api('PATCH', `/v1/builds/${b.id}`, { data: { type: 'builds', id: b.id, attributes: { usesNonExemptEncryption: false } } });
  await api('PATCH', `/v1/appStoreVersions/${v.id}/relationships/build`, { data: { type: 'builds', id: b.id } });
  console.log('  ✓ attached');
}

async function setCopyright(value, apply) {
  if (!value) fail('Usage: set-copyright "2026 DGL Factor" [--apply]');
  const app = await findApp();
  if (app.attributes.bundleId !== EXPECTED_BUNDLE) fail(`Refusing to touch ${app.attributes.bundleId}.`);
  const v = await editableVersion(app);
  const cur = (await api('GET', `/v1/appStoreVersions/${v.id}`)).data.attributes.copyright;
  console.log(`Copyright of ${v.version}: "${cur || ''}" → "${value}"${apply ? '' : ' — dry run'}`);
  if (!apply) return;
  await api('PATCH', `/v1/appStoreVersions/${v.id}`, { data: { type: 'appStoreVersions', id: v.id, attributes: { copyright: value } } });
  console.log('  ✓ saved');
}

// ---------- main ----------
CFG = loadConfig();
const [cmd, ...flags] = process.argv.slice(2);
// --bundle=<id> overrides the configured bundle id (not a secret).
const bundleFlag = flags.find(f => f.startsWith('--bundle='));
if (bundleFlag) CFG.bundleId = bundleFlag.slice('--bundle='.length);
try {
  if (cmd === 'status') await status();
  else if (cmd === 'dump') await dump();
  else if (cmd === 'review-check') await reviewCheck();
  else if (cmd === 'set-copyright') await setCopyright(flags.find(f => !f.startsWith('--')), flags.includes('--apply'));
  else if (cmd === 'attach-build') await attachBuild(flags.find(f => !f.startsWith('--')), flags.includes('--apply'));
  else if (cmd === 'previews') await previews(flags.includes('--apply'));
  else if (cmd === 'localize') await localize(flags.find(f => !f.startsWith('--')) || 'en-US', flags.includes('--apply'));
  else if (cmd === 'screenshots') await screenshots(flags.includes('--apply'), flags.includes('--replace-all'));
  else { console.log('Usage: node tool/asc/asc.mjs status | screenshots [--apply]'); process.exit(2); }
} catch (e) {
  fail(e.message);
}
