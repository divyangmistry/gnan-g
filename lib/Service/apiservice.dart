import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _apiUrl = 'http://192.168.43.23:3000';
  // final _apiUrl = 'http://192.168.1.103:3000';
 

  var headers = {'content-type': 'application/json'};

  // Login
  Future<http.Response> login(data) async {
    http.Response res =
        await http.post(_apiUrl + '/login', body: data, headers: headers);
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


  // Get Question Detail
  Future<http.Response> getQuestions(int level, int from, int to) async {
    var data;
    data = {'level': level, 'QuestaionFrom': from , 'QuestaionTo' : to};
    //http.Response res = await http.post(_apiUrl + '/questions',
    //    body: data, headers: headers);
    String questionList = "[\r\n   {\r\n       \"question_st\": 1,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   },\r\n   {\r\n       \"question_st\": 2,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   },\r\n   {\r\n       \"question_st\": 3,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   },\r\n   {\r\n       \"question_st\": 4,\r\n       \"question_type\": \"MCQ\",\r\n       \"question\": \"What is question?\",\r\n       \"options\": [\r\n           {\r\n               \"option_number\": 1,\r\n               \"option\": \"a\"\r\n           },\r\n           {\r\n               \"option_number\": 2,\r\n               \"option\": \"b\"\r\n           },\r\n           {\r\n               \"option_number\": 3,\r\n               \"option\": \"c\"\r\n           },\r\n           {\r\n               \"option_number\": 4,\r\n               \"option\": \"d\"\r\n           }\r\n       ],\r\n       \"score\": 1,\r\n       \"level\": 1,\r\n       \"answer\": \"d\"\r\n   }\r\n]";
    return http.Response(questionList,200);
    //return res;
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
    if (prefs.getString('userData') != null) {
      return true;
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

  // Get Qustion Details
  Future<http.Response> getNotification(data) async {
    http.Response res = await http.post(_apiUrl + '/getNotifications',
        body: data, headers: headers);
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
