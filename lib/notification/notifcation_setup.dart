import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:GnanG/notification/firebase_notification.dart';
import 'package:GnanG/notification/onesignal_notification.dart';
import 'package:flutter/material.dart';

class NotificationSetup {
  static ApiService _apiService = ApiService();
  static void setupNotification({BuildContext context, UserInfo userInfo}) async {
    try {
//      String fbToken = await FirebaseNotification.setupFBNotification(context: context);
      String fbToken = null;
      String oneSiganlPlayerId = await OneSignalNotification.setupOneSignalNotification(context: context, userInfo: userInfo);
      await _apiService.updateNotificationToken(mhtId: userInfo.mhtId, fbToken: fbToken, oneSignalToken: oneSiganlPlayerId);
    } catch(error) {
      print("Error while Notification Setup:" + error);
    }
  }
}
