import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:geo_analyzer_app/data/device_info_model.dart';

class DeviceStateUtil {
  Future<DeviceInfoModel> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return DeviceInfoModel(androidInfo.serialNumber, androidInfo.model);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return DeviceInfoModel(iosInfo.identifierForVendor!, iosInfo.model);
    }

    throw Exception('Platform is not avaible');
  }
}
