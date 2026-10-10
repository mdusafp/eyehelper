# Задача: опубликовать страницу Eye Helper на dglfactor.tech/eyehelper

Сервер уже обслуживает `dglfactor.tech` через Caddy (основной сайт лежит в `/home/deploy/apps/dglfactor-tech-site/`). Нужно добавить к нему раздел приложения Eye Helper, **не ломая существующий сайт**.

## Что уже лежит на сервере

Папка `/home/deploy/apps/eyehelper-site/`, в ней 4 статических файла:

| Файл | Что это |
|---|---|
| `index.html` | лендинг приложения, один самодостаточный файл (~2.1 МБ, все картинки и видео внутри как data URI) |
| `policy.html` | политика конфиденциальности |
| `og.jpg` | картинка превью для соцсетей (1200×630) |
| `sitemap.xml` | карта сайта раздела |

Больше файлов нет и не нужно. Никакой сборки, бэкенда и базы — только статика.

## Что должно открываться (итоговое поведение)

| URL | Ответ |
|---|---|
| `https://dglfactor.tech/eyehelper/` | `index.html`, 200, `text/html; charset=utf-8` |
| `https://dglfactor.tech/eyehelper` (без слэша) | 301/308 редирект на `/eyehelper/` |
| `https://dglfactor.tech/eyehelper/policy.html` | `policy.html`, 200, `text/html; charset=utf-8` |
| `https://dglfactor.tech/eyehelper/og.jpg` | 200, `image/jpeg` |
| `https://dglfactor.tech/eyehelper/sitemap.xml` | 200, `application/xml` (или `text/xml`) |
| `https://dglfactor.tech/eyehelper/<что угодно другое>` | 404 (не отдавать главную основного сайта) |
| Всё остальное на `dglfactor.tech` | как и раньше, без изменений |

Эти адреса уже прописаны в App Store (Marketing URL, Support URL, Privacy Policy URL) — **пути менять нельзя**, Apple проверяет их при ревью.

## Как настроить Caddy (ориентир, адаптируй под существующий Caddyfile)

В блок сайта `dglfactor.tech` добавь обработку префикса `/eyehelper` **выше** общих правил основного сайта:

```caddy
dglfactor.tech {
    # ... существующие настройки ...

    redir /eyehelper /eyehelper/ 308

    handle_path /eyehelper/* {
        root * /home/deploy/apps/eyehelper-site
        encode zstd gzip
        header {
            Cache-Control "public, max-age=3600"
            X-Content-Type-Options "nosniff"
            Referrer-Policy "strict-origin-when-cross-origin"
        }
        file_server
    }

    # ... существующий handle / file_server основного сайта ...
}
```

Важные моменты:
- `handle_path` срезает префикс `/eyehelper`, поэтому `root` указывает прямо на папку с файлами.
- Если в Caddyfile основной сайт описан через `handle { ... }`, новый `handle_path /eyehelper/*` должен идти раньше — `handle`-блоки взаимоисключающие и выбираются по порядку/специфичности.
- Если есть `www.dglfactor.tech`, он может и дальше редиректить на `dglfactor.tech` — это нормально.
- Права: пользователь, от которого работает Caddy, должен иметь право читать `/home/deploy/apps/eyehelper-site/` (проверь `namei -l /home/deploy/apps/eyehelper-site/index.html`).
- Перед перезагрузкой: `caddy validate --config /etc/caddy/Caddyfile` (путь может отличаться). Потом `sudo systemctl reload caddy` (или `caddy reload`), **не restart**.

## Проверка после применения

Все команды должны отработать как указано:

```bash
curl -sI https://dglfactor.tech/eyehelper/            | grep -iE '^(HTTP|content-type)'   # 200, text/html
curl -sI https://dglfactor.tech/eyehelper             | grep -iE '^(HTTP|location)'       # 301/308 → /eyehelper/
curl -sI https://dglfactor.tech/eyehelper/policy.html | grep -iE '^(HTTP|content-type)'   # 200, text/html
curl -sI https://dglfactor.tech/eyehelper/og.jpg      | grep -iE '^(HTTP|content-type)'   # 200, image/jpeg
curl -sI https://dglfactor.tech/eyehelper/sitemap.xml | grep -iE '^(HTTP|content-type)'   # 200, xml
curl -sI https://dglfactor.tech/eyehelper/nope        | grep -i '^HTTP'                   # 404
curl -s  https://dglfactor.tech/eyehelper/ | grep -o '<title>[^<]*</title>'               # <title>Eye Helper — Eye Exercises …
curl -sI https://dglfactor.tech/                      | grep -i '^HTTP'                   # как было до изменений
```

Если на корне `dglfactor.tech` есть `robots.txt` — добавь в него строку (если её там нет):

```
Sitemap: https://dglfactor.tech/eyehelper/sitemap.xml
```

Если `robots.txt` нет — ничего не создавай, это не обязательно.

## Позже (не сейчас): app-ads.txt

Позже в корень **основного** сайта будет добавлен файл `/home/deploy/apps/dglfactor-tech-site/app-ads.txt`. Он должен открываться по `https://dglfactor.tech/app-ads.txt` с кодом 200 и `Content-Type: text/plain`, **без редиректа на другой домен**. Проверь заранее, что текущая конфигурация основного сайта отдаст такой файл из своей папки (обычный `file_server` отдаст). Сейчас файла нет — 404 это нормально.

## Чего не делать

- Не менять и не перезапускать ничего, кроме конфигурации Caddy для этого раздела.
- Не трогать файлы в `/home/deploy/apps/dglfactor-tech-site/` (кроме необязательной строки в `robots.txt`).
- Не менять пути `/eyehelper/` и `/eyehelper/policy.html`.
- Не добавлять авторизацию, редиректы на другие домены или `noindex` — страница должна индексироваться.

В конце пришли вывод всех проверочных `curl` из раздела «Проверка».
