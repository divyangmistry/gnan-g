import 'package:GnanG/UI/game/fab_animated_button.dart';
import 'package:GnanG/UI/game/mainGame.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/utils/appsharedpref.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/model/cacheData.dart';
import '../../common.dart';

class GameMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GameMainPageState();
  }
}

class GameMainPageState extends State<GameMainPage> {
  ApiService _api = new ApiService();
  bool isMuteEnabled = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: BackgroundGredient(
        child: _bodyView(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kQuizMain300,
        child: FabAnimatedButton(),
      ),
    );
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
          height: 15.0,
        ),
      ],
    );
  }

  Widget _profile() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/gameStart');
      },
      child: _gameMenu(
          Colors.lime.shade500,
          Container(
            height: 180,
            width: 150,
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
        Navigator.pushNamed(context, '/leaderboard');
      },
      child: _gameMenu(
          Colors.green.shade400,
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            height: 100,
            width: 150,
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
          Colors.pinkAccent.shade100,
          Container(
            height: 150,
            width: 150,
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
            width: 150,
            child: FlareActor(
              'assets/animation/bonus.flr',
              animation: 'Notification Loop',
            ),
          ),
          "Bonus"),
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
            width: 150,
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
      height: MediaQuery.of(context).size.height / 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade900, blurRadius: 10.0, spreadRadius: 1.0)
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          imageContainer,
          Container(
            alignment: Alignment(0.5, 0.0),
            child: Text(
              menu,
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget titleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: kQuizSurfaceWhite,
            ),
            onPressed: () {},
          ),
        ),
        new Container(
          child: Center(
            child: Center(
              child: Image.asset(
                'images/logo1.png',
                height: 70.0,
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
        color: kQuizSurfaceWhite,
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
      });
    });
  }
}
