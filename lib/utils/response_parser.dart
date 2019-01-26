import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:kon_banega_mokshadhipati/common.dart';
import 'package:kon_banega_mokshadhipati/constans/appconstant.dart';
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
      if (showDialog && appResponse.status != WSConstant.SUCCESS_CODE) {
        CommonFunction.alertDialog(
            context: context,
            msg: appResponse.data['msg'],
            doneButtonFn: null,
            cancelButtonFn: null);
      }
    } else {
      appResponse =
          AppResponse(status: res.statusCode, message:"");
      if (showDialog) {
        CommonFunction.alertDialog(
            context: context,
            msg: "Internal Server Error, Please contact to " +
                AppConstant.MBA_MAILID.toString(),
            doneButtonFn: null,
            cancelButtonFn: null);
      }
    }
    return appResponse;
  }
}
