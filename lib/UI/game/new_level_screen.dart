
import 'package:GnanG/UI/game/fake_levels_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';

class NewLevelScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewLevelScreenState();
  }
}

class NewLevelScreenState extends State<NewLevelScreen> {
  int cardHeight;
  bool smallCardHeight = false;
  int numberOfLevel = 0;
  // int numberOfSelectedLevel

  List<LevelNameList> allLevelsData = allLevels;
  List<NewCardView> allLevelCards;

  PageController ctrl = PageController(viewportFraction: 0.7);
  PageController nameCtrl = PageController(viewportFraction: 0.7);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allLevelCards = allLevelsData[0].levelCards;
      allLevelCards[0].selectedLevel = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('New Level Screen !'),
      // ),
      body: _bodyView(),
    );
  }

  _bodyView() {
    return Container(
      padding: EdgeInsets.only(top: 30),
      color: kBackgroundGrediant1,
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 5,
            child: PageView(
              controller: nameCtrl,
              onPageChanged: (int) {
                setState(() {
                  allLevelCards = allLevelsData[int].levelCards;
                  numberOfLevel = int;
                  getSelectedCard(1);
                });
              },
              scrollDirection: Axis.horizontal,
              children: List.generate(
                allLevelsData.length,
                (index) {
                  return
                      // ClipPath(
                      //   clipper: BottomWaveClipper(),
                      //   child:
                      Container(
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
                    // ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: PageView(
                controller: ctrl,
                onPageChanged: (int) => getSelectedCard(int),
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                dragStartBehavior: DragStartBehavior.down,
                pageSnapping: smallCardHeight ? false : true,
                children: List.generate(
                  allLevelCards.length,
                  (index) {
                    return GestureDetector(
                      child: Center(
                        // child: ClipPath(
                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        //   clipper: TopWaveClipper(),
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
                                        allLevelCards[index]
                                            .levelNumber
                                            .toString(),
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: allLevelCards[index]
                                                    .selectedLevel
                                                ? 250
                                                : 150,
                                            fontWeight: FontWeight.w800,
                                            color: kQuizBrown900),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      allLevelCards[index]
                                          .levelScore
                                          .toString(),
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
                      ),
                      // ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
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

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
