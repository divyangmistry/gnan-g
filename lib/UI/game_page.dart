import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/UI/drag_ans.dart';

class GamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GamePageState();
  }
}

class GamePageState extends State<GamePage> {
  Color caughtColor = Colors.grey;
  Color _chandegCaughtColor;

  _changeColors(color) {
    setState(() {
      color = _chandegCaughtColor;
    });
  }

  _appBarView() {
    return new AppBar(
      title: new Text('Questions'),
      centerTitle: true,
      leading: new BackButton(),
      actions: <Widget>[
        new PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: new Text('option 1'),
              ),
              PopupMenuItem(
                child: new Text('option 2'),
              )
            ];
          },
        )
      ],
    );
  }

  _bodyView() {
    return new Container(
      alignment: Alignment.topCenter,
      // padding: const EdgeInsets.only(top: 10.0),
      color: _changeColors(caughtColor),
      // setState(() {
      //       position = offset;
      //     });
      child: new Stack(
        children: <Widget>[
          DragBox(
            initPos: Offset(45.0, 300.0),
            label: 'Answer One',
            itemColor: Colors.lime,
          ),
          DragBox(
            initPos: Offset(220.0, 300.0),
            label: 'Answer Two',
            itemColor: Colors.orange,
          ),
          DragBox(
            initPos: Offset(45.0, 350.0),
            label: 'Answer Three',
            itemColor: Colors.green,
          ),
          DragBox(
            initPos: Offset(220.0, 350.0),
            label: 'Answer Four',
            itemColor: Colors.blue,
          ),
          Positioned(
            // left: 100.0,
            bottom: 0.0,
            child: DragTarget(
              onAccept: (Color color) {
                caughtColor = color;
                _changeColors(caughtColor);
                // _chandegCaughtColor = color;
              },
              builder: (BuildContext context, List<dynamic> accepted,
                  List<dynamic> rejected) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: accepted.isEmpty
                          ? caughtColor
                          : Colors.grey.shade200),
                  child: new Center(
                    child: new Text('Drag here!'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: _chandegCaughtColor,
      appBar: _appBarView(),
      body: _bodyView(),
    );
  }
}
