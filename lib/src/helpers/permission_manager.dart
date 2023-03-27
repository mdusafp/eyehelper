import 'dart:io';

import 'package:eyehelper/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  static final String _tag = "PermissionsManager";
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
        if (Platform.isAndroid) {
          bool result = await requestPermissions(group);
          return result;
        }
        await showDialog(
          context: context,
          builder: (dialogContext) => EyeHelperAlertDialog(
            title: errorTitle ?? "Нет разрешения",
            subtitle: errorSubtitle ??
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
        return false;
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.restricted:
        return true;
      case PermissionStatus.permanentlyDenied:
        if (disabledTitle != null && disabledSubitle != null) {
          await showDialog(
            context: context,
            builder: (dialogContext) => EyeHelperAlertDialog(
              title: disabledTitle,
              subtitle: disabledSubitle,
              mainBtnTitle: "Ok",
              mainBtnCallback: () {
                Navigator.of(context).pop();
              },
            ),
          );
        }
        return false;
    }
  }

  static Future<bool> requestPermissions(Permission group) async {
    PermissionStatus permission = await group.request();
    return permission == PermissionStatus.granted;
  }
}
