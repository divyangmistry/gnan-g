import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/common.dart';
import 'package:kon_banega_mokshadhipati/constans/appconstant.dart';
import 'package:kon_banega_mokshadhipati/constans/message_constant.dart';
import 'package:kon_banega_mokshadhipati/constans/wsconstants.dart';
import 'package:kon_banega_mokshadhipati/model/appresponse.dart';

class ResponseParser {
  static AppResponse parseResponse(
      {@required BuildContext context,
      @required Response res,
      bool showDialog = true}) {
    AppResponse appResponse;
    if (res.statusCode == 200) {
      appResponse = AppResponse.fromJson(json.decode(res.body));
    } else {
      appResponse = AppResponse(status: res.statusCode);
    }
    if (showDialog && appResponse.status != WSConstant.SUCCESS_CODE) {
      CommonFunction.alertDialog(
        context: context,
        title: 'Error - ' + appResponse.status.toString(),
        msg: appResponse.message != null ? appResponse.message : MessageConstant.COMMON_ERROR_MSG,
        doneButtonText: 'Okay',
      );
    }
    return appResponse;
  }
}
