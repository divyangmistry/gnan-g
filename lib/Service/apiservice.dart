import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:GnanG/constans/sharedpref_constant.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/signupsession.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:GnanG/utils/audio_utilsdart.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //final _apiUrl = 'http://192.168.43.23:3000';
  // final _apiUrl = 'http://192.168.1.103:3000';
  final _apiUrl = 'http://gnang.purecelibacy.org:3000'; // live API


  Map<String, String> headers = {'content-type': 'application/json'};
  bool enableMock = false;

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (await AppSharedPrefUtil.isUserLoggedIn()) {
      appendTokenToHeader(await AppSharedPrefUtil.getToken());
    }
  }

  /// Common HTTP Requests

  /// HTTP Get request
  ///
  /// * [url] - API endpoint url e.g. : '/login'
  Future<http.Response> getApi({@required String url}) async {
    await checkLogin();
    print('Get Url:' + url);
    http.Response res = await http.get(_apiUrl + url, headers: headers);
    print('Response:' + res.body);
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
    print('Response:' + res.body);
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

  Future<http.Response> validateUserIndia(
      {@required String mhtId, @required String mobileNo}) async {
    Map<String, dynamic> data = {'mht_id': mhtId, 'mobile': mobileNo};
    Response res = await postApi(url: '/validate_user', data: data);
    return res;
  }

  Future<http.Response> validateUserOther(
      {@required String mhtId, @required String emailId}) async {
    Map<String, dynamic> data = {'mht_id': mhtId, 'emailId': emailId};
    Response res = await postApi(url: '/validate_user', data: data);
    return res;
  }

  // Register
  Future<http.Response> register({@required UserData userData}) async {
    Map<String, dynamic> data = userData.toJson();
    Response res = await postApi(url: '/register', data: data);
    return res;
  }

  Future<http.Response> requestRegistration({@required UserData userData}) async {
    Map<String, dynamic> data = userData.toJson();
    data['new_mobile'] = userData.mobile;
    Response res = await postApi(url: '/request_registration', data: data);
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
    Response res = await postApi(url: '/forgot_password', data: data);
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

  Future<http.Response> feedback(
      {@required String contact, @required String message}) async {
    Map<String, dynamic> data = {'contact': contact, 'message': message};
    http.Response res = await postApi(url: '/feedback', data: data);
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

  // Bonus Question
  Future<http.Response> getBonusQuestion(
      {@required int mhtId}) async {
    Map<String, dynamic> data = {
      'mht_id': mhtId
    };
    http.Response res = await postApi(url: '/bonus_question', data: data);
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

  Future<http.Response> uploadProfilePicture(
      {@required int mhtId,
        @required File file,
      }) async {
    String base64Image = base64Encode(file.readAsBytesSync());
    Map<String, dynamic> data = {
      'mht_id': mhtId,
      'image' : base64Image
    };
    http.Response res = await postApi(url: '/upload_photo', data: data);
    return res;
  }

  Future<http.Response> getProfilePicture(
      {@required int mhtId
      }) async {
    Map<String, dynamic> data = {
      'mht_id': mhtId,
    };
    http.Response res = await postApi(url: '/get_photo', data: data);
    return res;
  }

  Future<http.Response> getAppSetting() async {
    http.Response res = await getApi(url: '/app_getversion');
    return res;
  }

  Future<http.Response> updateNotificationToken(
      {@required int mhtId,
        @required String fbToken,
        @required String oneSignalToken}) async {
    Map<String, dynamic> data = {
      'mht_id': mhtId,
      'fb_token': fbToken,
      'onesignal_token': oneSignalToken
    };
    http.Response res = await postApi(url: '/update_notification_token', data: data);
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

  Future<http.Response> fiftyFifty({
    @required int mht_id,
    @required int level,
  }) async {
    Map<String, dynamic> data = {"mht_id": mht_id, "level": level};
    http.Response res = await postApi(url: '/use_fifty_fifty', data: data);
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
      "level": level
    };
    http.Response res = await postApi(url: '/validate_answer', data: data);
    return res;
  }

  // Logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    AppAudioUtils.stopBackgroundMusic();
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

  Future<http.Response> getRules() async {
    http.Response res = await getApi(url: '/rules');
    return res;
  }
}
