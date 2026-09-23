/// App Store identifier for `com.fluttergods.eyehelperapp`.
const String iosAppId = '1559208484';

/// Public store link shared with other people.
///
/// Android is intentionally absent: the old Play listing is gone and the
/// rewrite will ship under a new application id.
String getAppUrl() => 'https://apps.apple.com/app/id$iosAppId';

/// Where "what don't you like" feedback is mailed. Empty disables the mail
/// step; the analytics event still records that it happened.
// TODO: set the support address.
const String kFeedbackEmail = '';
