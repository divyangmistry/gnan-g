import 'package:GnanG/UI/game/fake_levels_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';
import 'package:animated_background/animated_background.dart';

class NewLevelScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewLevelScreenState();
  }
}

class NewLevelScreenState extends State<NewLevelScreen>
    with TickerProviderStateMixin {
  int cardHeight;
  bool smallCardHeight = false;
  int numberOfLevel = 0;
  double foo = 80;
  int currentLevel = 0;

  List<LevelNameList> allLevelsData = allLevels;
  List<NewCardView> allLevelCards;

  PageController ctrl = PageController(viewportFraction: 0.7, keepPage: false);
  PageController nameCtrl = PageController(viewportFraction: 0.7);

  @override
  void initState() {
    super.initState();
    setState(() {
      allLevelCards = allLevelsData[0].levelCards;
      allLevelCards[0].selectedLevel = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  _bodyView() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Container(
                child: allLevelsData[this.numberOfLevel].levelColor ==
                        Colors.orange.shade400
                    ? animatedWall(Color.fromRGBO(31, 169, 224, 1.0))
                    // backgroundFullImage(
                    //     'images/toy-plane-clouds-blue-background_23-2148109217.jpg')
                    : allLevelsData[this.numberOfLevel].levelColor ==
                            Colors.green
                        ? animatedWall(Color.fromRGBO(232, 216, 46, 1.0))
                        // backgroundFullImage(
                        //     'images/pattern-daysies-yellow-background-with-space-left_24972-210.jpg')
                        : allLevelsData[this.numberOfLevel].levelColor ==
                                Colors.blue
                            ? animatedWall(Color.fromRGBO(232, 140, 48, 1.0))
                            // backgroundFullImage(
                            //     'images/circle-with-hiking-camping-symbols_9202-898.png')
                            : animatedWall(Color.fromRGBO(32, 200, 51, 1.0))
                // backgroundFullImage(
                //     'images/realistic-beautiful-sea-view-summer-vacation-concept_1262-11902.jpg'),
                ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: PageView(
                    controller: nameCtrl,
                    onPageChanged: (int) {
                      setState(() {
                        foo = 80;
                        allLevelCards = [];
                        allLevelCards = allLevelsData[int].levelCards;
                        ctrl.jumpTo(1);
                        allLevelCards[0].selectedLevel = true;
                        numberOfLevel = int;
                        currentLevel = 0;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      allLevelsData.length,
                      (index) {
                        return levelTitleCard(index);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: PageView(
                      controller: ctrl,
                      onPageChanged: (int) {
                        currentLevel >= int ? foo += 20 : foo -= 20;
                        currentLevel = int;
                        getSelectedCard(int);
                      },
                      scrollDirection: Axis.horizontal,
                      physics: ScrollPhysics(),
                      pageSnapping: smallCardHeight ? false : true,
                      children: List.generate(
                        allLevelCards.length,
                        (index) {
                          return levelCards(index);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  animatedWall(color) {
    return Container(
      color: color,
      child: AnimatedBackground(
        behaviour: BubblesBehaviour(
          options: BubbleOptions(
            bubbleCount: 20,
            growthRate: 10.0,
            maxTargetRadius: 50,
            minTargetRadius: 20,
            popRate: 50,
          ),
        ),
        child: Container(),
        vsync: this,
      ),
    );
  }

  backgroundFullImage(image) {
    return Transform.scale(
      scale: 2.0,
      child: Transform.translate(
        offset: new Offset(foo, 0.0),
        child: new Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  levelTitleCard(index) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      width: MediaQuery.of(context).size.width / 3,
      child: Card(
        color: allLevelsData[index].levelColor,
        margin: EdgeInsets.all(10),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Center(
            child: Text(
              allLevelsData[index].levelName,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }

  levelCards(index) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: allLevelsData[numberOfLevel].levelColor,
        elevation: 10,
        semanticContainer: true,
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        margin: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment(1, 1),
                child: Center(
                  child: Transform.rotate(
                    angle: 0.0,
                    child: Text(
                      allLevelCards[index].levelNumber.toString(),
                      softWrap: false,
                      style: TextStyle(
                          fontSize:
                              allLevelCards[index].selectedLevel ? 250 : 150,
                          fontWeight: FontWeight.w800,
                          color: kQuizBrown900),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    allLevelCards[index].levelScore.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: kQuizBrown900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getSelectedCard(val) {
    allLevelCards.forEach((f) => f.selectedLevel = false);
    setState(() {
      allLevelCards[val].levelNumber - 1 == val
          ? allLevelCards[val].selectedLevel = true
          : allLevelCards[val].selectedLevel = false;
    });
  }
}
