import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/UI/game/fab_animated_button.dart';
import 'package:GnanG/UI/game/mainGame.dart';
import 'package:GnanG/UI/widgets/appupdatecheck.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/model/cacheData.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:GnanG/utils/audio_utilsdart.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../common.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  ApiService _api = new ApiService();
  bool isMuteEnabled = false;
  Response checkBonus;
  bool _bonusLevelFinished = false;
  // bool checkBonus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkBonusLevel();
    AppUpdateCheck.startAppUpdateCheckThread(context);
  }

  checkBonusLevel() async {
    checkBonus = await _api.getBonusQuestion(mhtId: CacheData.userInfo.mhtId);
    AppResponse appResponse =
        ResponseParser.parseResponse(context: context, res: checkBonus);
    if (appResponse.status == 200) {
      setState(() {
        _bonusLevelFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      // TODO: implement build
      return new Scaffold(
        body: BackgroundGredient(
          child: _bodyView(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//      floatingActionButton: FabAnimatedButton(),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: kQuizMain300,
//         child: _buildMuteIcon(),
//         onPressed: toggleMuteSound,
//       ),
        floatingActionButton: FabAnimatedButton(),
      );
    } catch(error) {
      CommonFunction.displayErrorDialog(context: context);
    }
  }

  _bodyView() {
    return new ListView(
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        SizedBox(
          height: 25.0,
        ),
        titleBar(),
        SizedBox(
          height: 15.0,
        ),
        _playGame(),
        SizedBox(
          height: 15.0,
        ),
        _todaysChallange(),
        SizedBox(
          height: 15.0,
        ),
        _puzzle(),
        SizedBox(
          height: 15.0,
        ),
        _leaderBoard(),
        SizedBox(
          height: 15.0,
        ),
        _profile(),
        SizedBox(
          height: 55.0,
        ),
      ],
    );
  }

  Widget _profile() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile');
      },
      child: _gameMenu(
          Colors.deepPurple.shade300,
          Container(
            height: 180,
            width: 120,
            child: FlareActor(
              'assets/animation/person_floating.flr',
              animation: 'Relaxing',
            ),
          ),
          'Profile'),
    );
  }

  Widget _leaderBoard() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/tableaderboard');
      },
      child: _gameMenu(
          Colors.pinkAccent.shade100,
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            height: 100,
            width: 120,
            child: FlareActor(
              'assets/animation/leader.flr',
              animation: 'after_success',
              fit: BoxFit.fill,
            ),
          ),
          'Leader Board'),
    );
  }

  Widget _playGame() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/level_new');
      },
      child: _gameMenu(
          Colors.green.shade400,
          Container(
            height: 150,
            width: 120,
            child: FlareActor(
              'assets/animation/world.flr',
              animation: 'move',
              fit: BoxFit.cover,
            ),
          ),
          "Play Game"),
    );
  }

  Widget _todaysChallange() {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/feedback');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => new MainGamePage(
                  isBonusLevel: true,
                ),
          ),
        );
      },
      child: _gameMenu(
          Colors.orange.shade300,
          Container(
            height: 150,
            width: 120,
            child: FlareActor(
              'assets/animation/bonus.flr',
              animation:
                  _bonusLevelFinished ? 'No Notification' : 'Notification Loop',
            ),
          ),
          "Daily Bonus"),
    );
  }

  Widget _puzzle() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/gameOf15');
      },
      child: _gameMenu(
          Colors.blue.shade400,
          Container(
            height: 120,
            width: 120,
            child: FlareActor(
              'assets/animation/puzzl.flr',
              animation: 'rotating',
              fit: BoxFit.contain,
            ),
          ),
          'Puzzle'),
    );
  }

  Widget _gameMenu(Color color, Container imageContainer, String menu) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      height: MediaQuery.of(context).size.height / 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade600, blurRadius: 5.0, spreadRadius: 1.0)
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          imageContainer,
          Text(
            menu,
            textScaleFactor: 1,
            style: TextStyle(fontSize: 25.0, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget titleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: new RaisedButton(
            padding: EdgeInsets.all(1),
            shape: CircleBorder(),
            onPressed: () {},
            color: kQuizSurfaceWhite,
            child: _buildMuteIcon(),
          ),
        ),
        Expanded(
          child: new Container(
//          width: MediaQuery.of(context).size.width,
            child: Center(
              child: Center(
                child: Image.asset(
                  'images/logo1.png',
                  height: 100.0,
                ),
              ),
            ),
          ),
        ),
        Container(
          child: CommonFunction.pointsUI(
            context: context,
            point: CacheData.userState.totalscore.toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildMuteIcon() {
    AppSharedPrefUtil.isMuteEnabled().then((isMute) {
      setState(() {
        isMuteEnabled = isMute;
      });
    });
    return IconButton(
      icon: Icon(
        isMuteEnabled ? Icons.volume_off : Icons.volume_up,
        color: kQuizMain400,
      ),
      onPressed: toggleMuteSound,
    );
  }

  void toggleMuteSound() async {
    await AppSharedPrefUtil.saveMuteEnabled(
        !await AppSharedPrefUtil.isMuteEnabled());
    AppSharedPrefUtil.isMuteEnabled().then((isMute) {
      setState(() {
        isMuteEnabled = isMute;
        if (!isMuteEnabled)
          AppAudioUtils.startBackgroundMusic();
        else
          AppAudioUtils.stopBackgroundMusic();
      });
    });
  }
}
