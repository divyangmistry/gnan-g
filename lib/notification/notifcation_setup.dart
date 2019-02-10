import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/model/userinfo.dart';
import 'package:kon_banega_mokshadhipati/notification/firebase_notification.dart';
import 'package:kon_banega_mokshadhipati/notification/onesignal_notification.dart';

class NotificationSetup {
  static void setupNotification({BuildContext context, UserInfo userInfo}) {
    FirebaseNotification.setupFBNotification(context: context);
    OneSignalNotification.setupOneSignalNotification(context: context, userInfo: userInfo);
  }
}
