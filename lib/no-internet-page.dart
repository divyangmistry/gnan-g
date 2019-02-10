import 'package:flutter/material.dart';

class NoInternetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoInternetPageState();
  }
}

class NoInternetPageState extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text("NO INTERNET CONNECTION DECTED !"),
    );
  }
}
