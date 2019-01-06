import 'package:flutter/material.dart';

class SimpleGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SimpleGameState();
  }
}

class SimpleGameState extends State<SimpleGame> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: _appBarView(),
      body: _bodyView(),
    );
  }

  _appBarView() {
    return new AppBar(
      title: new Text('Score here!'),
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
      child: new Card(
        margin: EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(top: 50.0),
            ),
            new Center(
              child: new Text(
                'QUESTION 01',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 70.0),
            ),
            new Expanded(
              child: new Center(
                child: new Text(
                  'Are you ready to role ?',
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            new Container(
              alignment: Alignment.bottomCenter,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    height: 50.0,
                    width: 120.0,
                    child: new RaisedButton(
                      elevation: 3.0,
                      color: Colors.orange.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () => _showDialogeBox(),
                      child: new Text(
                        'Option 01',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  new Container(
                    height: 50.0,
                    width: 120.0,
                    child: new RaisedButton(
                      elevation: 3.0,
                      color: Colors.orange.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () => _showDialogeBox(),
                      child: new Text(
                        'Option 02',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            new Container(
              alignment: Alignment.bottomCenter,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    height: 50.0,
                    width: 120.0,
                    child: new RaisedButton(
                      elevation: 3.0,
                      color: Colors.orange.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () => _showDialogeBox(),
                      child: new Text(
                        'Option 03',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  new Container(
                    height: 50.0,
                    width: 120.0,
                    child: new RaisedButton(
                      elevation: 3.0,
                      color: Colors.orange.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () => _showDialogeBox(),
                      child: new Text(
                        'Option 04',
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(bottom: 50.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showDialogeBox() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text(
              "You just pressed something .. which is in WIP !",
              style: TextStyle(
                color: Colors.grey,
                // fontWeight: FontWeight.w600
              ),
            ),
            title: new Center(
              child: new Text('Warning !'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            actions: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new OutlineButton.icon(
                        icon: Icon(Icons.cancel),
                        label: new Text('Cancle'),
                        textColor: Colors.blue,
                        onPressed: () => Navigator.of(context).pop(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      new OutlineButton.icon(
                        icon: Icon(Icons.done),
                        label: new Text('Clear'),
                        textColor: Colors.blue,
                        onPressed: () => Navigator.of(context).pop(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      )
                    ],
                  )
                ],
              )
            ],
            titlePadding: EdgeInsets.all(20.0),
          );
        });
  }
}
