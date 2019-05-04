import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:GnanG/colors.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart';

class RulesPagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RulesPagePageState();
}

class RulesPagePageState extends State<RulesPagePage> {
  String _rulesData;

  ApiService _api = ApiService();

  getRulesData() async {
    Response res = await _api.getRules();
    AppResponse appResponse =
        ResponseParser.parseResponse(res: res, context: context);
    if (appResponse.status == WSConstant.SUCCESS_CODE) {
      setState(() {
        _rulesData = appResponse.data['rules'];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRulesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: const Text('Rules')),
        body: _rulesData == null
            ? Center(child: CircularProgressIndicator())
            : Markdown(data: _rulesData));

    WebviewScaffold(
      url: "http://purecelibacy.org/gnang-rules.php",
      appBar:
          AppBar(backgroundColor: kBackgroundGrediant1, title: Text('Rules')),
    );
  }
}
