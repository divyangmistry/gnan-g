import 'dart:io';
import 'dart:typed_data';

import 'package:GnanG/common.dart';
import 'package:GnanG/constans/sharedpref_constant.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppSharedPrefUtil {
  /*SharedPreferences pref;
  static final AppSharedPrefUtil _singleton = new AppSharedPrefUtil._internal();

  factory AppSharedPrefUtil() {
    SharedPreferences.getInstance().then((onValue) => this.pref = onValue);
    return _singleton;
  }

  AppSharedPrefUtil._internal();*/

  static Future<bool> isMuteEnabled() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefConstant.b_muteSound) == null
        ? false
        : pref.getBool(SharedPrefConstant.b_muteSound);
  }

  static void saveMuteEnabled(bool isMuteEnabled) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(SharedPrefConstant.b_muteSound, isMuteEnabled);
  }
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefConstant.b_isUserLoggedIn) == null
        ? false
        : pref.getBool(SharedPrefConstant.b_isUserLoggedIn);
  }

  static Future<UserInfo> getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(json.decode(pref.getString('user_info'))['data']);
    return UserInfo.fromJson(json.decode(pref.getString('user_info'))['data']);
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  static Future<bool> saveProfileImage(String base64Image) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(SharedPrefConstant.s_profileImage, base64Image);
    return true;
  }

  static Future<Image> getProfileImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return CommonFunction.getImageFromBase64Img(base64Img: pref.getString(SharedPrefConstant.s_profileImage));
  }
}
