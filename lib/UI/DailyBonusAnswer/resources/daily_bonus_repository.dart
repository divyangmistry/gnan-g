import 'dart:async';
import 'dart:convert';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import '../../../model/daily_bonus_answer.dart';

class DailyBonusAnswerProvider {
  Client client = Client();
  Map<String, String> headers = {'content-type': 'application/json'};
  // final String apiUrl = 'http://192.168.43.23:3000';
  final String apiUrl = 'http://3.16.51.94:3000';
  // final _apiUrl = 'http://gnang.purecelibacy.org:3000';

  checkLogin() async {
    if (await AppSharedPrefUtil.isUserLoggedIn()) {
      appendTokenToHeader(await AppSharedPrefUtil.getToken());
    }
  }

  /// Call after login done successfully
  /// Append token to header
  ///
  /// * [token] - For authenticate api
  appendTokenToHeader(token) {
    headers['x-access-token'] = token;
    if (CacheData.userInfo != null && CacheData.userInfo.mhtId != null)
      headers['mht_id'] = CacheData.userInfo.mhtId.toString();
    print(headers);
  }

  Future<DailyBonusAnswer> getDailyBonusAnswer({@required DateTime date}) async {
    try {
      Future.delayed(const Duration(seconds: 10), () {
        return DailyBonusAnswer(
          question: 'Question',
          answer: 'Answer'
        );
      });
      // Map<String, dynamic> reqData = {'date': date.toIso8601String()};
      // final response = await client.post('$apiUrl/getQuestion', headers: headers, body: json.encode(reqData));
      // print('Response Answers ');
      // print(response.body);
      // switch (response.statusCode) {
      //   case 200:
      //     return DailyBonusAnswer.fromJson(json.decode(response.body)['data']);
      //     break;
      //   default:
      //     return throw Exception(json.decode(response.body)['message']);
      // }
    } catch (e) {
      print('Error in API ::: ');
      print(e);
    }
  }
}
