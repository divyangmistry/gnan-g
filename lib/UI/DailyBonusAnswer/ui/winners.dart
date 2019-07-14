import 'package:GnanG/UI/DailyBonusAnswer/bloc/winners_bloc.dart';
import 'package:GnanG/UI/widgets/hero_image.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/constans/appconstant.dart';
import 'package:GnanG/model/leaders.dart';
import 'package:flutter/material.dart';

class Winners extends StatefulWidget {
  @override
  _WinnersState createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  @override
  void initState() {
    bloc.getWinnerList();
    super.initState();
  }

  // @override
  // void dispose() {
  //   bloc.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Widget mainUI(LeaderList data) {
      return ListView.builder(
        itemCount: data.leaders.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(3),
            child: Card(
              child: ListTile(
                title: Text(
                  '${data.leaders[index].name}',
                ),
                leading: CircleAvatar(
                  child: HeroImage(
                    image: Image(
                      image: data.leaders[index].profilePic != null &&
                              data.leaders[index].profilePic.isNotEmpty
                          ? NetworkImage(data.leaders[index].profilePic)
                          : AssetImage(AppConstant.DEFAULT_USER_IMG_PATH),
                    ),
                    maxRadius: 25,
                  ),
                  maxRadius: 25,
                ),
                subtitle: Text(
                  'Points: ${data.leaders[index].totalscore}',
                ),
                trailing: Text(
                  '${index + 1}',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          );
        },
      );
    }

    Widget winnerUI(Leaders leader, int rank) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$rank',
            textScaleFactor: 4,
            style: TextStyle(color: kQuizBrown900),
          ),
          CircleAvatar(
            foregroundColor: kQuizMain400,
            child: HeroImage(
              maxRadius: rank == 1 ? 50 : 30,
              image: Image(
                image: leader.profilePic != null && leader.profilePic.isNotEmpty
                    ? NetworkImage(leader.profilePic)
                    : AssetImage(AppConstant.DEFAULT_USER_IMG_PATH),
              ),
              heroTag: rank.toString(),
            ),
            maxRadius: rank == 1 ? 55 : 35,
            backgroundColor: rank == 1 ? Colors.teal : kBackgroundGrediant4,
          ),
          SizedBox(height: 10),
          Text('${leader.name}', textScaleFactor: rank == 1 ? 1.3 : 1),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/coin.png', height: 20),
              SizedBox(width: 5),
              Text('${leader.totalscore}', textScaleFactor: rank == 1 ? 1.1 : 1)
            ],
          )
        ],
      );
    }

    Widget newUI(LeaderList leaders) {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            winnerUI(leaders.leaders[1], 2),
            winnerUI(leaders.leaders[0], 1),
            winnerUI(leaders.leaders[2], 3)
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundGrediant1,
      appBar: AppBar(
        title: Text('Winners of Last Month'),
        backgroundColor: kQuizMain400,
      ),
      body: SafeArea(
        child: StreamBuilder<LeaderList>(
            stream: bloc.winnerList,
            builder:
                (BuildContext context, AsyncSnapshot<LeaderList> snapshot) {
              if (snapshot.hasData) {
                print('************');
                print(snapshot.data);
                if (snapshot.data.leaders.length == 0) {
                  return Center(
                    child: Text(
                      'No Winners Available',
                      textScaleFactor: 1.5,
                    ),
                  );
                }
                // return mainUI(snapshot.data);
                return newUI(snapshot.data);
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Error to get Winners',
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kQuizErrorRed,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {
                          bloc.getWinnerList();
                        },
                        child: Text(
                          'Try Again',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}