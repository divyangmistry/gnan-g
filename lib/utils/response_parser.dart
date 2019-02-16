import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:SheelQuotient/common.dart';
import 'package:SheelQuotient/constans/appconstant.dart';
import 'package:SheelQuotient/constans/wsconstants.dart';
import 'package:SheelQuotient/model/appresponse.dart';

class ResponseParser {


  static AppResponse parseResponse({
    @required BuildContext context,
    @required Response res,
    bool showDialog = true
  }) {
    CommonFunction cf = new CommonFunction();
    AppResponse appResponse;
    if (res.statusCode == 200) {
      appResponse = AppResponse.fromJson(json.decode(res.body));
      if (showDialog && appResponse.status != WSConstant.SUCCESS_CODE) {
        cf.alertDialog(context: context,
            msg: appResponse.message,
            doneButtonFn: null,
            cancelButtonFn: null);
      }
    } else {
      appResponse = AppResponse(status: res.statusCode, message: "");
      if (showDialog) {
        cf.alertDialog(context: context,
            msg: "Internal Server Error, Please contact to " +
                AppConstant.MBA_MAILID.toString(),
            doneButtonFn: null,
            cancelButtonFn: null);
      }
    }
    return appResponse;
  }

}