import 'dart:io';
import 'dart:math';

import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/Service/profile_pic.dart';
import 'package:GnanG/UI/DailyBonusAnswer/ui/winners.dart';
import 'package:GnanG/UI/new_leaderboard/new_monthly.dart';
import 'package:GnanG/UI/widgets/hero_image.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/appconstant.dart';
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
  ProfilePic profilePicService = new ProfilePic();
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
    "question_id": 507,
    // "img_dropbox_url":
    //     "https://dl.dropboxusercontent.com/s/gk8gc8ydhdls20j/profile_1.0.png?dl=0"
  });

  _updateMyMonthScoreFromList() {
    if (leaderList != null) {
      leaderListMonth.forEach((leader) {
        if (leader != null && leader.mhtId == CacheData.userInfo.mhtId) {
          if (leader.totalscoreMonth != null)
            CacheData.userState.totalscore_month = leader.totalscoreMonth;
        }
      });
    }
  }

  _getLeaderListByMonth() async {
    try {
      Response res = await _api.getApi(url: '/leaders_month');
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        File userPhoto = await profilePicService.getCurruntUserProfilePic();
        LeaderList leaders = LeaderList.fromJson(appResponse.data);
        print('********** ====> <==== ***********');
        print(userPhoto.path);
        print(CacheData.userInfo.profilePic);
        print('********** ====> <==== ***********');
        _userImage = Image(
          image: userPhoto != null && userPhoto.existsSync()
              ? FileImage(userPhoto)
              : AssetImage(AppConstant.DEFAULT_USER_IMG_PATH),
        );
        _userImage = Image.file(userPhoto);
        setState(() {
          leaderListMonth = leaders.leaders;
          leaderListMonth.insert(0, pujyashree);
          _updateMyMonthScoreFromList();
          print(leaderListMonth);
          _userRankMonth = leaders.userRank + 1;
        });
      }
    } catch (err) {
      if (mounted)
        CommonFunction.displayErrorDialog(
            context: context, msg: err.toString());
    }
  }

  @override
  void initState() {
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
                Rank(rank: _userRankMonth),
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
                  CacheData.userState.totalscore_month.toString(),
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
        // Container(
        //   padding: EdgeInsets.all(16),
        //   child: Text(
        //     'Monthly Leaderboard',
        //     textScaleFactor: 1,
        //     style: TextStyle(
        //       fontSize: 25,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        myRank
      ],
    );

    Widget monthlyLeaderboardUI() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: kQuizMain500,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            child: topSection,
            preferredSize: Size(50, 50),
          ),
        ),
        body: SafeArea(
          child: NewMonthlyLeaderBoard(leaderListMonth),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: kQuizMain500,
          title: TabBar(
            tabs: [
              Tab(
                child: Text('Monthly Leaderboard'),
              ),
              Tab(child: Text('Last Month Winners')),
            ],
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          // bottom: ,
        ),
        body: TabBarView(
          children: [
            monthlyLeaderboardUI(),
            Winners(),
          ],
        ),
      ),
    );
  }
}

class LeaderRow extends StatefulWidget {
  final int rank, points, mhtId, profileVersion;
  final String name;
  final IconData icon;
  final String profilePic;

  LeaderRow(this.rank, this.name, this.points, this.icon, this.mhtId,
      this.profilePic, this.profileVersion);

  @override
  State<StatefulWidget> createState() {
    print(profilePic);
    return new LeaderRowState();
  }
}

class LeaderRowState extends State<LeaderRow>
    with AutomaticKeepAliveClientMixin<LeaderRow> {
  File image;
  ProfilePic _profilePicService = new ProfilePic();

  @override
  void initState() {
    loadProfilePic();
    super.initState();
  }

  loadProfilePic() async {
    image = await _profilePicService.readProfilePic(
        widget.mhtId, widget.profileVersion);
    if (image != null &&
        !image.existsSync() &&
        widget.profilePic != null &&
        widget.profilePic.isNotEmpty) {
      image = await _profilePicService.writeProfilePic(
          widget.profilePic, widget.mhtId, widget.profileVersion);
    }
    if (mounted) {
      setState(() {});
    }
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
            child: HeroImage(
                image: Image(
                  image: image != null && image.existsSync()
                      ? FileImage(image)
                      : AssetImage(AppConstant.DEFAULT_USER_IMG_PATH),
                ),
                maxRadius: 30,
                heroTag: widget.name + widget.rank.toString()),
            backgroundColor: colors[_random.nextInt(colors.length)],
          ),
        ),
        Divider(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => false;
}
