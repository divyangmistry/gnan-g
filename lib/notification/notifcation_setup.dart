import 'package:flutter/material.dart';
import 'package:SheelQuotient/model/userinfo.dart';
import 'package:SheelQuotient/notification/firebase_notification.dart';
import 'package:SheelQuotient/notification/onesignal_notification.dart';

class NotificationSetup {
  static void setupNotification({BuildContext context, UserInfo userInfo}) {
    FirebaseNotification.setupFBNotification(context: context);
    OneSignalNotification.setupOneSignalNotification(context: context, userInfo: userInfo);
  }
}
