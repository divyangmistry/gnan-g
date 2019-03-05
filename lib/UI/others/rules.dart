import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:GnanG/colors.dart';

class RulesPagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RulesPagePageState();
}

class RulesPagePageState extends State<RulesPagePage> {
  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: "https://akonnect.org/i-card/",
      appBar: AppBar(
        backgroundColor: kBackgroundGrediant1,
        title: Text('Rules')
      ),
    );
  }
}