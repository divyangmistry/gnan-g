import 'dart:convert';

import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/message_constant.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ResponseParser {
  static AppResponse parseResponse(
      {BuildContext context,
      @required Response res,
      bool showDialog = true}) {
    ApiService _api = new ApiService();
    AppResponse appResponse = AppResponse.fromJson(json.decode(res.body));
    if (appResponse.status == 0 || appResponse.status == null)
      appResponse.status = res.statusCode;
    if (showDialog && appResponse.status != WSConstant.SUCCESS_CODE) {
      if(context != null) {
        CommonFunction.alertDialog(
          context: context,
          title: 'Error - ' + appResponse.status.toString(),
          msg: appResponse.message != null
              ? appResponse.message
              : MessageConstant.COMMON_ERROR_MSG,
          doneButtonText: 'Okay',
        );
      }
    }
    if(appResponse.status == 227) {
      _api.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login_new', (_) => false);
      //Navigator.popUntil(context, ModalRoute.withName('/login_new'));
    }
    return appResponse;
  }
}

// _loadUserState(int mhtId) async {
//     try {
//       Response res = await _api.getUserState(mhtId: mhtId);
//       AppResponse appResponse =
//           ResponseParser.parseResponse(context: context, res: res);
//       if (appResponse.status == WSConstant.SUCCESS_CODE) {
//         print('IN LOGIN ::: userstateStr :::');
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         pref.setString('userState', res.body);
//         UserState userState = UserState.fromJson(appResponse.data['results']);
//         CacheData.userState = userState;
//         Navigator.pushReplacementNamed(context, '/level_new');
//       }
//     } catch (err) {
//       print('CATCH 2 :: ');
//       print(err);
//       CommonFunction.displayErrorDialog(context: context, msg: err.toString());
//     }
//   }
