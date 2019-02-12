import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:SheelQuotient/common.dart';
import 'package:SheelQuotient/constans/appconstant.dart';
import 'package:SheelQuotient/constans/message_constant.dart';
import 'package:SheelQuotient/constans/wsconstants.dart';
import 'package:SheelQuotient/model/appresponse.dart';

class ResponseParser {
  static AppResponse parseResponse(
      {@required BuildContext context,
      @required Response res,
      bool showDialog = true}) {
    AppResponse appResponse = AppResponse.fromJson(json.decode(res.body));
    if (appResponse.status == 0 || appResponse.status == null)
      appResponse.status = res.statusCode;
    if (showDialog && appResponse.status != WSConstant.SUCCESS_CODE) {
      CommonFunction.alertDialog(
        context: context,
        title: 'Error - ' + appResponse.status.toString(),
        msg: appResponse.message != null
            ? appResponse.message
            : MessageConstant.COMMON_ERROR_MSG,
        doneButtonText: 'Okay',
      );
    }
    return appResponse;
  }
}
