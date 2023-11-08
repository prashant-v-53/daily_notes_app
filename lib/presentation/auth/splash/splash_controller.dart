import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:notes_app/core/app_export.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    getMessage();
    super.onInit();
  }

  getMessage() {
    FirebaseMessaging.instance.getToken().then((token) {
      storeDeviceInfo(token, "");
    });

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   final prefs = GetStorage();
    //   if (await prefs.read(Prefs.userId) != null &&
    //       await prefs.read(Prefs.userId) != "") {
    //   } else {
    //     Get.offNamed(AppRoute.home);
    //   }
    // });
  }

  void storeDeviceInfo(fcmToken, String supportNo) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      // unique ID on iOS
      LocalStorage.storeDeviceInfo(
        iosDeviceInfo.identifierForVendor.toString(),
        fcmToken,
        "ios",
        supportNo,
      );
      Get.offAllNamed(AppRoute.home);
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      // unique ID on Android
      LocalStorage.storeDeviceInfo(
        androidDeviceInfo.id.toString(),
        fcmToken,
        "android",
        supportNo,
      );
      Get.offAllNamed(AppRoute.home);
    }
  }
}
