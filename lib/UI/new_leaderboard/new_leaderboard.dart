import 'dart:math';

import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/UI/new_leaderboard/new_monthly.dart';
import 'package:GnanG/UI/new_leaderboard/new_overall.dart';
import 'package:GnanG/UI/widgets/hero_image.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/model/leaders.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

final colors = [
  Colors.red,
  Colors.amber,
  Colors.purple,
  Colors.blue,
  Colors.green,
  Colors.deepOrange,
  Colors.teal
];

// ignore: non_constant_identifier_names
Widget build_users_row(String name, String rank, String points, img) {
  final Random _random = Random();
  return Column(
    children: <Widget>[
      ListTile(
        title: Text(name),
        trailing: Text(
          rank,
          textAlign: TextAlign.right,
          textScaleFactor: 1.5,
        ),
        leading: CircleAvatar(
          child: img != ''
              ? HeroImage(image: img)
              : Text(
                  name[0].toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
          backgroundColor: colors[_random.nextInt(colors.length)],
        ),
        subtitle: Text('Points : ' + (points == 'null' ? '0' : points)),
      ),
      Divider(),
    ],
  );
}

class Rank extends StatelessWidget {
  Rank({Key key, this.rank: 0}) : super(key: key);

  final int rank;

  Widget build(BuildContext context) {
    return Text(
      rank.toString(),
      textScaleFactor: 1,
      style: TextStyle(fontSize: 32, color: Colors.white),
    );
  }
}

class NewLeaderBoard extends StatefulWidget {
  @override
  _NewLeaderBoardState createState() => _NewLeaderBoardState();
}

class _NewLeaderBoardState extends State<NewLeaderBoard> {
  ApiService _api = new ApiService();
  int _currentIndex = 0;
  List<Leaders> leaderList;
  List<Leaders> leaderListMonth;
  int _userRank = 0;
  int _userRankMonth = 0;
  Image _userImage;
  Leaders pujyashree = new Leaders.fromJson({
    "lives": 3,
    "isactive": true,
    "user_group": "MBA",
    "totalscore_month": 0,
    "totalscore_week": 0,
    "mobile": "9924343401",
    "name": "Pujyashree",
    "email": "pujyashree@dadabhagwan.org",
    "mht_id": 1,
    "center": "Sim-City",
    "bonus": 30,
    "totalscore": 4000,
    "fb_token": null,
    "onesignal_token": "7f97262d-f4ca-4cd1-be8c-600687895a69",
    "question_id": 507
  });

  _getLeaderList() async {
    try {
      Response res = await _api.getApi(url: '/leaders');
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        LeaderList leaders = LeaderList.fromJson(appResponse.data);
        _userImage = await CommonFunction.getUserProfileImg(context: context);
        setState(() {
          leaderList = leaders.leaders;
          leaderList.insert(0, pujyashree);
          _userRank = leaders.userRank;
        });
      }
    } catch (err) {
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
  }

  _getLeaderListByMonth() async {
    try {
      Response res = await _api.getApi(url: '/leaders_month');
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        LeaderList leaders = LeaderList.fromJson(appResponse.data);
        _userImage = await CommonFunction.getUserProfileImg(context: context);
        setState(() {
          leaderListMonth = leaders.leaders;
          leaderListMonth.insert(0, pujyashree);
          print(leaderListMonth);
          _userRankMonth = leaders.userRank;
        });
      }
    } catch (err) {
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
  }

  @override
  void initState() {
    _getLeaderList();
    _getLeaderListByMonth();
    super.initState();
  }

  String getOrdinalOfNumber(int n) {
    int j = n % 10;
    int k = n % 100;
    if (j == 1 && k != 11) {
      return "st";
    }
    if (j == 2 && k != 12) {
      return "nd";
    }
    if (j == 3 && k != 13) {
      return "rd";
    }
    return "th";
  }

  @override
  Widget build(BuildContext context) {
    Widget myRank = Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Rank(rank: _currentIndex == 0 ? _userRank : _userRankMonth),
                Text(
                  getOrdinalOfNumber(
                      _currentIndex == 0 ? _userRank : _userRankMonth),
                  textScaleFactor: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          CircleAvatar(
            child: HeroImage(
              image: _userImage,
              maxRadius: 32,
            ),
            minRadius: 35,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _currentIndex == 0
                      ? CacheData.userState.totalscore.toString()
                      : CacheData.userState.totalscore_month.toString(),
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'pts',
                  textScaleFactor: 1,
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

    Widget topSection = Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            _currentIndex == 0 ? 'Overall Leaderboard' : 'Monthly Leaderboard',
            textScaleFactor: 1,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
        myRank
      ],
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          child: topSection,
          preferredSize: Size(100, 110),
        ),
      ),
      body: SafeArea(
        child: _currentIndex == 0
            ? NewOverAllLeaderBoard(leaderList)
            : NewMonthlyLeaderBoard(leaderListMonth),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.all_inclusive),
            title: new Text('Overall'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.today),
            title: new Text('Monthly'),
          ),
        ],
      ),
    );
  }
}

class LeaderRow extends StatefulWidget {
  int rank, points, mhtId;
  String name;
  IconData icon;

  LeaderRow(this.rank, this.name, this.points, this.icon, this.mhtId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LeaderRowState();
  }
}

class LeaderRowState extends State<LeaderRow>
    with AutomaticKeepAliveClientMixin<LeaderRow> {
  Image image = CacheData.getUserDefaultImg();

  @override
  void initState() {
    super.initState();
    CacheData.getUserProfileImages(context, widget.mhtId).then((userImage) {
      if (mounted && widget.mhtId != 1) {
        setState(() {
          image = userImage;
        });
      } else {
        setState(() {
          image = CommonFunction.getImageFromBase64Img(
            base64Img: CacheData.pujyashreeImg,
            returnDefault: true,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Random _random = Random();
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.name),
          subtitle: Text(
              widget.mhtId != 1 ? 'Points : ' + widget.points.toString() : ""),
          trailing: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Text(
              widget.rank.toString(),
              textAlign: TextAlign.right,
              textScaleFactor: 1.5,
            ),
          ),
          leading: CircleAvatar(
            radius: 28,
            child: HeroImage(image: image, maxRadius: 30, heroTag: widget.name + widget.rank.toString()),
            backgroundColor: colors[_random.nextInt(colors.length)],
          ),
        ),
//        Row(
//          children: <Widget>[
//            Container(
//              child: Title(
//                child: Text(widget.rank.toString()),
//                color: Colors.blue,
//              ),
//              width: 60.0,
//            ),
//
//          ],
//        ),
        Divider(),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
