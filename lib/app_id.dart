/// App Store identifier for `com.fluttergods.eyehelperapp`.
const String iosAppId = '1559208484';

/// Public store link shared with other people.
///
/// Android is intentionally absent: the old Play listing is gone and the
/// rewrite will ship under a new application id.
String getAppUrl() => 'https://apps.apple.com/app/id$iosAppId';
