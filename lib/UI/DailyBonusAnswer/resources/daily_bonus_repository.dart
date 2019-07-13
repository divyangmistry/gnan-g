import 'dart:async';
import 'dart:convert';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/question.dart';
import 'package:GnanG/utils/appsharedpref.dart';
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

  Future<List<Question>> getDailyBonusAnswer() async {
    try {
      await checkLogin();
      final response = await client.get('$apiUrl/get_pre_bonus', headers: headers);
      print('Response Answers ');
      print(response.body);
      switch (response.statusCode) {
        case 200:
          return Question.fromJsonArray(json.decode(response.body)['data']);
          break;
        default:
          return throw Exception(json.decode(response.body)['message']);
      }
    } catch (e) {
      print('Error in API ::: ');
      print(e);
    }
  }
}
