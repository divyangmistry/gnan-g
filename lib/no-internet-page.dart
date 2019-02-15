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
    return new Scaffold(
      body: Center(
        child: Text("NO INTERNET CONNECTION DECTED !"),
      ),
    );
  }
}
