import 'dart:async';
import 'dart:convert';
import 'package:kon_banega_mokshadhipati/constans/sharedpref_constant.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // final _apiUrl = 'http://192.168.43.23:3000';
  // final _apiUrl = 'http://192.168.1.103:3000';
  final _apiUrl = 'http://104.211.88.75:3000'; // live API

  Map<String, String> headers = {'content-type': 'application/json'};

  bool enableMock = false;

  ApiService() {
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('b_isUserLoggedIn') != null && pref.getBool('b_isUserLoggedIn')) {
      appendTokenToHeader(pref.getString('token'));
    }
  }

  /// Common HTTP Requests

  /// HTTP Get request
  ///
  /// * [url] - API endpoint url e.g. : '/login'
  Future<http.Response> getApi({@required String url}) async {
    http.Response res = await http.get(_apiUrl + url, headers: headers);
    return res;
  }

  /// HTTP Post request
  ///
  /// * [url] - API endpoint url e.g. : '/login'
  /// * [data] - API body
  Future<http.Response> postApi(
      {@required String url, @required Map<String, dynamic> data}) async {
    print(_apiUrl + url);
    print(data);
    http.Response res = await http.post(_apiUrl + url,
        body: json.encode(data), headers: headers);
    return res;
  }

  /// Call after login done successfully
  /// Append token to header
  ///
  /// * [token] - For authenticate api
  appendTokenToHeader(token) {
    headers['x-access-token'] = token;
    print(headers);
  }

  // Login
  Future<http.Response> login(data) async {
    http.Response res =
        await http.post(_apiUrl + '/login', body: data, headers: headers);
    return res;
  }

  Future<http.Response> validateUser(String mhtId, String mobileNo) async {
    var data = {'mht_id': mhtId, 'modile': mobileNo};
    if (enableMock) {
      String validateUserRes =
          "{\r\n    \"status\": 200,\r\n    \"message\": \"\",\r\n    \"data\": {\r\n        \"otp\": 311437,\r\n        \"msg\": \"OTP is send to your Contact number.\",\r\n        \"data\": {\r\n            \"_id\": \"5c460544153e0fa09b0783be\",\r\n            \"mobile\": \"8153922317\",\r\n            \"name\": \"tEST:\",\r\n            \"email\": \"ttttt@ttt.com\",\r\n            \"mht_id\": 454545,\r\n            \"center\": \"terre\"\r\n        }\r\n    }\r\n}";
      return http.Response(validateUserRes, 200);
    }
    http.Response res = await http.post(_apiUrl + '/generate_otp',
        body: json.encode(data), headers: headers);
    return res;
  }

  // Register
  Future<http.Response> register(data) async {
    http.Response res =
        await http.post(_apiUrl + '/register', body: data, headers: headers);
    return res;
  }

  // Edit Profile
  Future<http.Response> profileUpdate(data) async {
    http.Response res = await http.post(_apiUrl + '/profileUpdate',
        body: data, headers: headers);
    return res;
  }

  Future<http.Response> getUserState(data) async {
    if (enableMock) {
      String userStateRes =
          "{\r\n    \"status\": 200,\r\n    \"message\": \"\",\r\n    \"data\": {\r\n        \"results\": {\r\n            \"quiz_levels\": [\r\n                {\r\n                    \"_id\": \"5c4606839a8ec823d093b722\",\r\n                    \"level_index\": 1,\r\n                    \"name\": \"test33\",\r\n                    \"level_type\": \"REGULAR\",\r\n                    \"total_questions\": 10,\r\n                    \"categorys\": [\r\n                        {\r\n                            \"_id\": \"5c4606839a8ec823d093b723\",\r\n                            \"category_number\": 1,\r\n                            \"category\": \"1\"\r\n                        }\r\n                    ],\r\n                    \"start_date\": \"2019-01-18T00:00:00.000Z\",\r\n                    \"end_date\": \"3019-01-18T00:00:00.000Z\",\r\n                    \"description\": \"Avo Game ramva\",\r\n                    \"imagepath\": \"\",\r\n                    \"totalscores\": 30\r\n                },\r\n                {\r\n                    \"_id\": \"5c46069c9a8ec823d093b724\",\r\n                    \"level_index\": 2,\r\n                    \"name\": \"Biji Var\",\r\n                    \"level_type\": \"REGULAR\",\r\n                    \"total_questions\": 10,\r\n                    \"categorys\": [\r\n                        {\r\n                            \"_id\": \"5c46069c9a8ec823d093b725\",\r\n                            \"category_number\": 1,\r\n                            \"category\": \"1\"\r\n                        }\r\n                    ],\r\n                    \"start_date\": \"2019-01-18T00:00:00.000Z\",\r\n                    \"end_date\": \"3019-01-18T00:00:00.000Z\",\r\n                    \"description\": \"Avo Game ramva\",\r\n                    \"imagepath\": \"\",\r\n                    \"totalscores\": 30\r\n                },\r\n                {\r\n                    \"_id\": \"5c4606a69a8ec823d093b726\",\r\n                    \"level_index\": 3,\r\n                    \"name\": \"Triji Var\",\r\n                    \"level_type\": \"REGULAR\",\r\n                    \"total_questions\": 10,\r\n                    \"categorys\": [\r\n                        {\r\n                            \"_id\": \"5c4606a69a8ec823d093b727\",\r\n                            \"category_number\": 1,\r\n                            \"category\": \"1\"\r\n                        }\r\n                    ],\r\n                    \"start_date\": \"2019-01-18T00:00:00.000Z\",\r\n                    \"end_date\": \"3019-01-18T00:00:00.000Z\",\r\n                    \"description\": \"Avo Game ramva\",\r\n                    \"imagepath\": \"\",\r\n                    \"totalscores\": 0\r\n                }\r\n            ],\r\n            \"completed\": [],\r\n            \"current\": {\r\n                \"question_st\": 1,\r\n                \"level\": 1,\r\n                \"score\": 0,\r\n                \"completed\": false,\r\n                \"_id\": \"5c4894bb8f45cc208ccfb0a7\",\r\n                \"mht_id\": 454545,\r\n                \"total_questions\": 10,\r\n                \"updatedAt\": \"2019-01-23T16:22:19.788Z\",\r\n                \"createdAt\": \"2019-01-23T16:22:19.788Z\",\r\n                \"__v\": 0\r\n            },\r\n            \"totalscore\": 0\r\n        }\r\n    }\r\n}";
      return http.Response(userStateRes, 200);
    }
    http.Response res =
        await http.post(_apiUrl + '/quiz_level', body: data, headers: headers);
    return res;
  }

  // Get Question Detail
  Future<http.Response> getQuestions(int level, int from, int to) async {
    var data;
    data = {'level': level, 'QuestionFrom': from};
    http.Response res = await http.post(_apiUrl + '/questions',
        body: json.encode(data), headers: headers);
    //String questionList =
    //    "[\r\n   {\r\n       \"question_st\": 1,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   },\r\n   {\r\n       \"question_st\": 2,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   },\r\n   {\r\n       \"question_st\": 3,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   },\r\n   {\r\n       \"question_st\": 4,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   }\r\n]";
    //return http.Response(questionList, 200);
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

  // Get GAME Levels Details
  Future<http.Response> getLevels(data) async {
    http.Response res =
        await http.post(_apiUrl + '/quiz_level', body: data, headers: headers);
    return res;
  }

  // Get Qustion Details
  Future<http.Response> qustionDetails(data) async {
    http.Response res = await http.post(_apiUrl + '/questionDetails',
        body: data, headers: headers);
    return res;
  }

  // Save User Data
  Future<http.Response> saveUserData(data) async {
    http.Response res = await http.post(_apiUrl + '/saveUserData',
        body: data, headers: headers);
    return res;
  }

  // Get User Tickets
  Future<http.Response> getUserTickets(data) async {
    http.Response res = await http.post(_apiUrl + '/getUserTickets',
        body: data, headers: headers);
    return res;
  }

  // Map User Tickets
  Future<http.Response> mapTickets(data) async {
    http.Response res =
        await http.post(_apiUrl + '/mapTicket', body: data, headers: headers);
    return res;
  }

  // Send OTP
  Future<http.Response> sendOtp(data) async {
    http.Response res =
        await http.post(_apiUrl + '/otp', body: data, headers: headers);
    return res;
  }

  // Forgot Password
  Future<http.Response> forgotPassword(data) async {
    http.Response res = await http.post(_apiUrl + '/forgotPassword',
        body: data, headers: headers);
    return res;
  }

  // Generate Ticket
  Future<http.Response> generateTicket(data) async {
    http.Response res = await http.post(_apiUrl + '/generateTicket',
        body: data, headers: headers);
    return res;
  }

  // Generate Ticket
  Future<http.Response> generateTicketForAK(data) async {
    http.Response res = await http.post(_apiUrl + '/generateTicketForAK',
        body: data, headers: headers);
    return res;
  }

  // Get AK User state Detail
  Future<http.Response> getAKUserState(data) async {
    http.Response res = await http.post(_apiUrl + '/getAKUserState',
        body: data, headers: headers);
    return res;
  }

  // Get AK User state Detail
  Future<http.Response> saveAKUserWords(data) async {
    http.Response res = await http.post(_apiUrl + '/save_user_answers',
        body: data, headers: headers);
    return res;
  }

  // Get AK User state Detail
  Future<http.Response> getWinnerList() async {
    http.Response res =
        await http.post(_apiUrl + '/winnerlist', headers: headers);
    return res;
  }
}
