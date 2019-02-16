import 'package:flutter/material.dart';
import 'package:GnanG/model/userinfo.dart';
import 'package:GnanG/notification/firebase_notification.dart';
import 'package:GnanG/notification/onesignal_notification.dart';

class NotificationSetup {
  static void setupNotification({BuildContext context, UserInfo userInfo}) {
    FirebaseNotification.setupFBNotification(context: context);
    OneSignalNotification.setupOneSignalNotification(context: context, userInfo: userInfo);
  }
}
