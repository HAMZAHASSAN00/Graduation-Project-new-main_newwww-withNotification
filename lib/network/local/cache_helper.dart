import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/Signup/components/choose_tank_photo/sliderTank/models.dart';
import '../../model/UserModel.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async
  {
    return await sharedPreferences!.setBool(key, value);
  }
  static Future<bool> saveBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences!.getBool(key);
  }
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> saveUserData({
    required String key,
    required UserModel userData,
  }) async {
    // Convert UserModel to a map before saving
    Map<String, dynamic> userDataMap = {
      'name': userData.name,
      'email': userData.email,
      'tank': userData.tank != null ? userData.tank!.toJson() : null,
      'isTurnedOnTank': userData.isTurnedOnTank,
      'isTurnedOnSolar': userData.isTurnedOnSolar,
      'isAutomaticMode': userData.isAutomaticMode,
      'tankName':userData.tankName,
      'height':userData.height,
      'width':userData.width,
      'length':userData.length,
      'waterTemp':userData.waterTemp,
      'CurrentBills':userData.CurrentBills,
      'isAutomaticModeSolar':userData.isAutomaticModeSolar,

    };

    // Save the map in SharedPreferences
    return await sharedPreferences!.setString(key, json.encode(userDataMap));
  }


  static UserModel? getUserData({
    required String key,
  }) {
    String? userDataString = sharedPreferences!.getString(key);
    if (userDataString != null) {
      // If data exists, convert it back to UserModel
      Map<String, dynamic> userDataMap = json.decode(userDataString);
      return UserModel(
        name: userDataMap['name'],
        email: userDataMap['email'],
        isAutomaticMode:userDataMap['isAutomaticMode'],
        isTurnedOnTank: userDataMap['isTurnedOnTank'],
        isTurnedOnSolar: userDataMap['isTurnedOnSolar'],
        tank: userDataMap['tank'],
        tankName: userDataMap['tankName'],
        height: userDataMap['height'],
        width: userDataMap['width'],
        length: userDataMap['length'],
        waterTemp: userDataMap['waterTemp'],
        CurrentBills: userDataMap['CurrentBills'],
        isAutomaticModeSolar: userDataMap['isAutomaticModeSolar'],
      );
    }
    return null;
  }
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);

    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async
  {
    return await sharedPreferences!.remove(key);
  }



  static Future<bool> saveTankModel({
    required String key,
    required TankModel tankModel,
  }) async {
    // Convert TankModel to a map before saving
    Map<String, dynamic> tankModelMap = {
      'tankName': tankModel.tankName,
      'height': tankModel.height,
      'width': tankModel.width,
      'length': tankModel.length,
    };

    // Save the map in SharedPreferences
    return await sharedPreferences!.setString(key, json.encode(tankModelMap));
  }

  static TankModel? getTankModel({
    required String key,
  }) {
    String? tankModelString = sharedPreferences!.getString(key);
    if (tankModelString != null) {
      // If data exists, convert it back to TankModel
      Map<String, dynamic> tankModelMap = json.decode(tankModelString);
      return TankModel(
        tankName: tankModelMap['tankName'],
        height: tankModelMap['height'],
        width: tankModelMap['width'],
        length: tankModelMap['length']
      );
    }
    return null;
  }
  static List<String> getAllNotificationsKeys() {
    // Get all keys stored in SharedPreferences
    Set<String>? keys = sharedPreferences!.getKeys();

    // Filter keys that match the pattern used for notifications
    List<String> notificationKeys = keys?.where((key) => key.startsWith('notification_')).toList() ?? [];

    return notificationKeys;
  }
  static Future<bool> saveNotification({
    required String key,
    required String notificationMessage,
  }) async {
    // Save the notification message in SharedPreferences
    return await sharedPreferences!.setString(key, notificationMessage);
  }

  static String? getNotification({
    required String key,
  }) {
    return sharedPreferences!.getString(key);
  }

  static Future<bool> removeNotification({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
  static List<String> getAllNotifications() {
    List<String> notificationKeys = getAllNotificationsKeys();

    // Retrieve notifications for each key
    List<String> notifications = [];
    for (String key in notificationKeys) {
      String? notification = getNotification(key: key);
      if (notification != null) {
        notifications.add(notification);
      }
    }

    return notifications;
  }
}