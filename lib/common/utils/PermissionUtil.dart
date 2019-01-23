import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
export 'package:permission_handler/permission_handler.dart';


class PermissionUtil {
  static Future<bool> deal(List<PermissionGroup> permissions) async {
    Map<PermissionGroup, PermissionStatus> statusMap = await PermissionHandler()
        .requestPermissions(permissions);
    print('statusMap');
    print(statusMap);

    String tipContent = ' ';

    bool result = true;
    statusMap.forEach((permissionGroup, permissionStatus) {
      if (permissionStatus != PermissionStatus.granted) {
        tipContent += configMap[permissionGroup] + ' ';
        result = false;
      }
    });

    if (!result) {
      ConfirmUtil.showConfirm(
          ConfirmParam(
              type: 2,
              title: '权限未开',
              content: '请前往设置打开 [ ${tipContent}]权限',
              sureText: '前往设置',
              surePress: () {
                PermissionHandler().openAppSettings();
              }
          )
      );
    }
    return result;

  }


  static Map<PermissionGroup, String> configMap = {
    PermissionGroup.photos: '相册',
    PermissionGroup.camera: '相机',
    PermissionGroup.contacts: '联系人',
    PermissionGroup.location: '位置',
    PermissionGroup.microphone: '麦克风',
    PermissionGroup.storage: '存储',
    PermissionGroup.speech: '讲话',
  };
}

