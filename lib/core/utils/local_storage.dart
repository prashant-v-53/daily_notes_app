import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import 'app_prefs.dart';

class LocalStorage {
  static String deviceId = "";
  static String deviceToken = "";
  static String deviceType = "";
  static String userId = "";
  static String userEmail = "";
  static String password = "";
  static String fullName = "";
  static String userMobile = "";
  static String userProfile = "";
  static String supportnumber = "";

  static getAuthToken() async {
    final prefs = GetStorage();
    return prefs.read(Prefs.token);
  }

  static void storeDataInfo(json) async {
    final prefs = GetStorage();

    //* Store UserId
    prefs.write(Prefs.userId, json['user_uid']);
    //* Store name
    prefs.write(Prefs.fullName, json['full_name']);
    //* Store email
    prefs.write(Prefs.email, json['email'] ?? "");
    //* Store password
    prefs.write(Prefs.password, json['password']);
    //* Store mobile
    prefs.write(Prefs.mobile, json['phone_number'].toString());
    //* Store User Profile Image
    if (json['user_profile'] != null) {
      prefs.write(Prefs.profileImage, json['user_profile']);
    }
    //* set data
    userId = prefs.read(Prefs.userId);
    userEmail = prefs.read(Prefs.email);
    password = prefs.read(Prefs.password);
    fullName = prefs.read(Prefs.fullName);
    userMobile = prefs.read(Prefs.mobile);
    userProfile = prefs.read(Prefs.profileImage) ?? "" as dynamic;

    loadLocalData();
  }

  static void storeProfileInfo(json) async {
    final prefs = GetStorage();
    // //* Store fullName
    prefs.write(Prefs.fullName, json['full_name']);
    // //* Store email
    prefs.write(Prefs.email, json['email'] ?? "");
    // //* Store mobile
    prefs.write(Prefs.mobile, json['phone_number'].toString());
    //* Store User Profile Image
    if (json['user_profile'] != null) {
      prefs.write(Prefs.profileImage, json['user_profile']);
    }
    //* set data
    userEmail = prefs.read(Prefs.email);
    fullName = prefs.read(Prefs.fullName);
    userMobile = prefs.read(Prefs.mobile);
    userProfile = prefs.read(Prefs.profileImage) ?? "" as dynamic;

    loadLocalData();
  }

  static void storeDeviceInfo(
    String deviceID,
    String deviceTOKEN,
    String deviceTYPE,
    String supportNUMBER,
  ) async {
    final prefs = GetStorage();
    try {
      const url = 'https://api.ipify.org';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        prefs.write(Prefs.deviceIP, response.body);
      } else {
        // print(response.body);
      }
    } catch (exception) {
      // print(exception);
    }
    //* Store device id
    prefs.write(Prefs.deviceID, deviceID);
    //* Store device token
    prefs.write(Prefs.deviceFCMtoken, deviceTOKEN);
    //* Store device type
    prefs.write(Prefs.deviceType, deviceTYPE);
    prefs.write(Prefs.supportnumber, supportNUMBER);

    //* set data
    deviceId = prefs.read(Prefs.deviceID);
    deviceToken = prefs.read(Prefs.deviceFCMtoken);
    deviceType = prefs.read(Prefs.deviceType);
    supportnumber = prefs.read(Prefs.supportnumber);
    loadLocalData();
  }

  static void loadLocalData() {
    final prefs = GetStorage();

    deviceId = prefs.read(Prefs.deviceID) ?? "";
    userId = prefs.read(Prefs.userId) ?? "";
    userEmail = prefs.read(Prefs.email) ?? "";
    fullName = prefs.read(Prefs.fullName) ?? "";
    userProfile = prefs.read(Prefs.profileImage) ?? "";
    userMobile = prefs.read(Prefs.mobile) ?? "";
    password = prefs.read(Prefs.password) ?? "";
  }

  static void clearLocalData() {
    GetStorage().erase();
    loadLocalData();
  }
}
