import 'package:eyehelper/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  static const String FIRST_TIME_ASKED = 'FIRST_TIME_ASKED';

  static Future<bool> checkPermissionsSilent(Permission group) async {
    return PermissionStatus.granted == (await group.status);
  }

  static Future<bool> checkPermissionsWithDialog({
    required BuildContext context,
    required Permission group,
    String? errorTitle,
    String? errorSubtitle,
    String? disabledTitle,
    String? disabledSubitle,
  }) async {
    PermissionStatus permission = await group.status;

    switch (permission) {
      case PermissionStatus.denied:
        // On iOS "not determined" is also reported as denied, so always ask
        // the system first instead of sending the user to app settings.
        PermissionStatus result = await group.request();
        if (result == PermissionStatus.granted ||
            result == PermissionStatus.limited ||
            result == PermissionStatus.provisional) {
          return true;
        }
        if (result == PermissionStatus.permanentlyDenied) {
          await _showOpenSettingsDialog(context, errorTitle, errorSubtitle);
        }
        return false;
      case PermissionStatus.granted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        return true;
      case PermissionStatus.restricted:
        return true;
      case PermissionStatus.permanentlyDenied:
        await _showOpenSettingsDialog(
          context,
          disabledTitle ?? errorTitle,
          disabledSubitle ?? errorSubtitle,
        );
        return false;
    }
  }

  static Future<void> _showOpenSettingsDialog(
    BuildContext context,
    String? title,
    String? subtitle,
  ) {
    return showDialog(
      context: context,
      builder: (dialogContext) => EyeHelperAlertDialog(
        title: title ?? "Нет разрешения",
        subtitle: subtitle ??
            "Мы не получили разрешение на отправку уведомлений, поэтому не можем настроить их сейчас. Вы можете настроить разрешения в настройках вашего устройства.",
        mainBtnTitle: "Открыть настройки",
        mainBtnCallback: () {
          openAppSettings();
          Navigator.of(context).pop();
        },
        secondaryBtnTitle: "Закрыть",
        secondaryBtnCallback: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static Future<bool> requestPermissions(Permission group) async {
    PermissionStatus permission = await group.request();
    return permission == PermissionStatus.granted;
  }
}
