import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/UI/widgets/base_state.dart';
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

import '../colors.dart';

class LeaderBoard extends StatefulWidget {
  @override
  LeaderBoardState createState() => new LeaderBoardState();
}

class LeaderBoardState extends BaseState<LeaderBoard> {
  
  ApiService _api = new ApiService();

  List<Leaders> leaderList;
  int _userRank = 0;
  Image _userImage;

  @override
  void initState() {
    super.initState();
    _loadLeadersAndRank();
  }

  _loadLeadersAndRank() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response res = await _api.getApi(url: '/leaders');
      AppResponse appResponse =
          ResponseParser.parseResponse(context: context, res: res);
      if (appResponse.status == WSConstant.SUCCESS_CODE) {
        LeaderList leaders = LeaderList.fromJson(appResponse.data);
        _userImage = await CommonFunction.getUserProfileImg(context: context);
        setState(() {
          leaderList = leaders.leaders;
          print(leaderList);
          _userRank = leaders.userRank;
        });
      }
    } catch (err) {
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
    setState(() {
      isLoading = false;
    });

  }

  Widget _buildLeaderRow(int rank, String name, int points, IconData icon,
      Image image, int mhtId) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Container(
                  width: 25,
                  child:Text(
                  rank.toString(),
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                )
              ),
              SizedBox(width: 9,)
              ,CircleAvatar(
                  maxRadius: 25,
                  child: HeroImage(image: image,maxRadius: 23,heroTag: name,),
                  backgroundColor: CacheData.userInfo.mhtId == mhtId ? kQuizBrown900 : kQuizMain50,
              ),
              SizedBox(width: 9,),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                child: Text(
                  points.toString(),
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        new Divider(),
      ],
    );
  }

  Widget _buildUserRow(int rank, int points) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 33,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Rank(rank: _userRank),
                  Text(
                    getOrdinalOfNumber(_userRank),
                    style: TextStyle(
                      color: kQuizSurfaceWhite,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: CircleAvatar(
              maxRadius: 34,
              child: HeroImage(image: _userImage,maxRadius: 32,),
              backgroundColor: kQuizBrown900,
            ),
          ),
          Expanded(
            flex: 33,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    points.toString(),
                    style: TextStyle(
                      fontSize: 32,
                      color: kQuizSurfaceWhite,
                    ),
                  ),
                  Text(
                    'pts',
                    style: TextStyle(
                      textBaseline: TextBaseline.alphabetic,
                      color: kQuizSurfaceWhite,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
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
  Widget pageToDisplay() {
    Widget topSection = Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: 25,
                color: kQuizSurfaceWhite,
              ),
            ),
          ),
          _buildUserRow(1, CacheData.userState.totalscore)
        ],
      ),
    );


    return leaderList != null
        ? new Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  child: topSection, preferredSize: Size(100, 100)),
              backgroundColor: kQuizMain400,
            ),
            body: ListView.builder(
              itemCount: leaderList.length,
              itemBuilder: (BuildContext context, int index) {
                Image leaderImage = CommonFunction.getImageFromBase64Img(base64Img:leaderList[index].img, returnDefault: true);
                return _buildLeaderRow(
                  index + 1,
                  leaderList[index].name,
                  leaderList[index].totalscore,
                  Icons.face,
                  leaderImage,
                  leaderList[index].mhtId,
                );
              },
            ),
          )
        : new Scaffold(
            body: new Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class Rank extends StatelessWidget {
  Rank({Key key, this.rank: 0}) : super(key: key);

  final int rank;

  Widget build(BuildContext context) {
    return Text(
      rank.toString(),
      style: TextStyle(fontSize: 32, color: Colors.white),
    );
  }
}
