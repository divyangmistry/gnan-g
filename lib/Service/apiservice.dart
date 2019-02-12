import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:SheelQuotient/constans/sharedpref_constant.dart';
import 'package:SheelQuotient/model/cacheData.dart';
import 'package:SheelQuotient/model/signupsession.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // final _apiUrl = 'http://192.168.43.23:3000';
  // final _apiUrl = 'http://192.168.1.103:3000';
  final _apiUrl = 'http://104.211.88.75:3000'; // live API

  Map<String, String> headers = {'content-type': 'application/json'};
  bool enableMock = false;

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('b_isUserLoggedIn') != null &&
        pref.getBool('b_isUserLoggedIn')) {
      appendTokenToHeader(pref.getString('token'));
    }
  }

  /// Common HTTP Requests

  /// HTTP Get request
  ///
  /// * [url] - API endpoint url e.g. : '/login'
  Future<http.Response> getApi({@required String url}) async {
    await checkLogin();
    http.Response res = await http.get(_apiUrl + url, headers: headers);
    return res;
  }

  /// HTTP Post request
  ///
  /// * [url] - API endpoint url e.g. : '/login'
  /// * [data] - API body
  Future<http.Response> postApi(
      {@required String url, @required Map<String, dynamic> data}) async {
    await checkLogin();
    String postUrl = _apiUrl + url;
    print('Post Url:' + postUrl + '\tReq:' + data.toString());
    http.Response res = await http.post(_apiUrl + url,
        body: json.encode(data), headers: headers);
    print('Response' + res.body);
    return res;
  }

  /// Call after login done successfully
  /// Append token to header
  ///
  /// * [token] - For authenticate api
  appendTokenToHeader(token) {
    headers['x-access-token'] = token;
    if(CacheData.userInfo != null && CacheData.userInfo.mhtId != null)
      headers['mht_id'] = CacheData.userInfo.mhtId.toString();
    print(headers);
  }

  Future<http.Response> validateUser(
      {@required String mhtId, @required String mobileNo}) async {
    Map<String, dynamic> data = {'mht_id': mhtId, 'mobile': mobileNo};
    Response res = await postApi(url: '/validate_user', data: data);
    return res;
  }

  // Register
  Future<http.Response> register({@required UserData userData}) async {
    Map<String, dynamic> data = userData.toJson();
    Response res = await postApi(url: '/register', data: data);
    return res;
  }

  Future<http.Response> updatePassword(
      {@required int mhtId, @required String password}) async {
    Map<String, dynamic> data = {'mht_id': mhtId, 'password': password};
    Response res = await postApi(url: '/update_password', data: data);
    return res;
  }

  Future<http.Response> forgotPassword({@required String mhtId}) async {
    Map<String, dynamic> data = {'mht_id': mhtId};
    Response res = await postApi(url: '/update_password', data: data);
    return res;
  }

  // Edit Profile
  Future<http.Response> profileUpdate(data) async {
    http.Response res = await http.post(_apiUrl + '/profileUpdate',
        body: data, headers: headers);
    return res;
  }

  Future<http.Response> getUserState({@required int mhtId}) async {
    var data = {'mht_id': mhtId};
    http.Response res = await postApi(url: '/user_state', data: data);
    return res;
  }

  Future<http.Response> login(
      {@required String mhtId, @required String password}) async {
    Map<String, dynamic> data = {'mht_id': mhtId, 'password': password};
    http.Response res = await postApi(url: '/login', data: data);
    return res;
  }

  // Get Question Detail
  Future<http.Response> getQuestions(
      {@required int level, int from, int to}) async {
    var data;
    data = {'level': level, 'QuestionFrom': from};
    http.Response res = await postApi(url: '/questions', data: data);
    return res;
  }

  Future<http.Response> requestLife({@required int mhtId}) async {
    Map<String, dynamic> data = {'mht_id': mhtId};
    http.Response res = await postApi(url: '/req_life', data: data);
    return res;
  }

  // Puzzle Completed
  Future<http.Response> puzzleCompleted(
      {@required int mhtId,
      @required String puzzle_type,
      @required String puzzle_name}) async {
    Map<String, dynamic> data = {
      'mht_id': mhtId,
      'puzzle_type': puzzle_type,
      'puzzle_name': puzzle_name
    };
    http.Response res = await postApi(url: '/puzzle_completed', data: data);
    return res;
  }

  Future<http.Response> hintTaken({
    @required int questionId,
    @required int mhtId,
  }) async {
    Map<String, dynamic> data = {"question_id": questionId, "mht_id": mhtId};
    http.Response res = await postApi(url: '/hint_question', data: data);
    return res;
  }

  Future<http.Response> validateAnswer({
    @required int questionId,
    @required int mhtId,
    @required answer,
    @required int level,
  }) async {
    Map<String, dynamic> data = {
      "question_id": questionId,
      "mht_id": mhtId,
      "answer": answer,
      "level": 1
    };
    http.Response res = await postApi(url: '/validate_answer', data: data);
    return res;
  }

  // Logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // go to login
  }

  // Check Login Status
  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(SharedPrefConstant.b_isUserLoggedIn) != null) {
      if (prefs.getBool(SharedPrefConstant.b_isUserLoggedIn)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  // Check Theme
  Future<bool> checkIsIntoVisited() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isIntroSeen') != null) {
      return prefs.getBool('isIntroSeen');
    } else {
      return false;
    }
  }

  // Check Theme
  Future<bool> checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isDarkTheme') != null) {
      return prefs.getBool('isDarkTheme');
    } else {
      return false;
    }
  }
}
