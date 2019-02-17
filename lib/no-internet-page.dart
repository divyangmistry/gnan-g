import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class NoInternetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoInternetPageState();
  }
}

class NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: FlareActor(
              'assets/animation/noInternet.flr',
              animation: "idle",
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),
          Text(
            'Looks like you lost your Internet !!',
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
