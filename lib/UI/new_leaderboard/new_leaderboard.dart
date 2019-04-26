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
import 'dart:math';

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
  Image _userImage;

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
          print(leaderList);
          List<Widget> tempList = [];
          int i = 1;
          leaderList.forEach((leader) {
            tempList.add(build_users_row(
                leader.name, i.toString(), leader.totalscore.toString(), ''));
            tempList.add(Divider());
            i += 1;
          });
          _children[0] = ListView(children: tempList);
          _userRank = leaders.userRank;
//          loadPersonsImg();
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
          print(leaderListMonth);
          List<Widget> tempList = [];
          int i = 1;
          leaderListMonth.forEach((leader) {
            tempList.add(build_users_row(leader.name, i.toString(),
                leader.totalscoreMonth.toString(), ''));
            tempList.add(Divider());
            i += 1;
          });
          _children[1] = ListView(children: tempList);
          _userRank = leaders.userRank;
//          loadPersonsImgMonth();
        });
      }
    } catch (err) {
      CommonFunction.displayErrorDialog(context: context, msg: err.toString());
    }
  }

  void loadPersonsImg() async {
    leaderList.forEach((leader) {
      CommonFunction.getProfilePictureFromServer(context, leader.mhtId)
          .then((base64Img) {
        setState(() {
          leader.img = base64Img;
        });
      });
    });
  }
  void loadPersonsImgMonth() async {
    leaderListMonth.forEach((leader) {
      CommonFunction.getProfilePictureFromServer(context, leader.mhtId)
          .then((base64Img) {
        setState(() {
          leader.img = base64Img;
        });
      });
    });
  }

  List<Widget> _children = [
    Center(
      child: CircularProgressIndicator(),
    ),
    Center(
      child: CircularProgressIndicator(),
    )
  ];

  @override
  void initState() {
    _getLeaderList();
    _getLeaderListByMonth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
//      body: SafeArea(child: _children[_currentIndex]),
      body: SafeArea(
        child: _children.length > _currentIndex
            ? _currentIndex == 0 && leaderList != null
                ? ListView.builder(
                    itemCount: leaderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      CommonFunction.getImageFromBase64Img(
                          base64Img: leaderList[index].img,
                          returnDefault: true);
                      return LeaderRow(
                        index + 1,
                        leaderList[index].name,
                        leaderList[index].totalscore,
                        null,
                        leaderList[index].mhtId,
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : _currentIndex == 1 && leaderListMonth != null
                ? ListView.builder(
                    itemCount: leaderListMonth.length,
                    itemBuilder: (BuildContext context, int index) {
                      CommonFunction.getImageFromBase64Img(
                          base64Img: leaderListMonth[index].img,
                          returnDefault: true);
                      return LeaderRow(
                        index + 1,
                        leaderListMonth[index].name,
                        leaderListMonth[index].totalscore,
                        null,
                        leaderListMonth[index].mhtId,
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
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

  final int rank, points, mhtId;
  final String name;
  Image image;

  LeaderRow(this.rank, this.name, this.points, this.image, this.mhtId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LeaderRowState();
  }
}

class LeaderRowState extends State<LeaderRow> {

  Image cachedImage;

  @override
  void initState() {
    super.initState();
    CommonFunction.getProfilePictureFromServer(context, widget.mhtId).then((base64Img) {
      if (mounted) {
        setState(() {
          widget.image = CommonFunction.getImageFromBase64Img(
              base64Img: base64Img, returnDefault: true);
          cachedImage = widget.image;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Random _random = Random();
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.name),
          trailing: Text(
            widget.rank.toString(),
            textAlign: TextAlign.right,
            textScaleFactor: 1.5,
          ),
          leading: CircleAvatar(
            child: HeroImage(image: cachedImage, maxRadius: 23, heroTag: widget.name),
            backgroundColor: colors[_random.nextInt(colors.length)],
          ),
          subtitle: Text('Points : ' + (widget.points == null ? '0' : widget.points.toString())),
        ),
        Divider(),
      ],
    );
  }
}