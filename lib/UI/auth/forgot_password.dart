import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/model/signupsession.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../Service/apiservice.dart';
import '../../UI/auth/new_otp.dart';
import '../../colors.dart';
import '../../common.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  CommonFunction cf = new CommonFunction();
  final _formKey = GlobalKey<FormState>();
  ApiService _api = new ApiService();
  bool _autoValidate = false;
  String _mhtId;

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: new Scaffold(
        backgroundColor: kQuizSurfaceWhite,
        body: SafeArea(
          child: new ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              new SizedBox(height: 20.0),
              new Column(
                children: <Widget>[
                  new Image.asset(
                    'images/logo1.png',
                    height: 200,
                  ),
                  new SizedBox(height: 5.0),
                  new Text(
                    'FORGOT PASSWORD',
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              new SizedBox(
                height: 50.0,
              ),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  validator: CommonFunction.mhtIdValidation,
                  decoration: InputDecoration(
                    labelText: 'Mht Id',
                    hintText: 'Enter Mht Id no.',
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: kQuizBrown900,
                    ),
                    filled: true,
                  ),
                  onSaved: (String value) {
                    _mhtId = value;
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ),
              new SizedBox(height: 20.0),
              new RaisedButton(
                child: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 4.0,
                padding: EdgeInsets.all(20.0),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      try {
        _formKey.currentState.save();
        Response res = await _api.forgotPassword(mhtId: _mhtId);
        AppResponse appResponse = ResponseParser.parseResponse(context: context, res: res);
        if (appResponse.status == 200) {
          SignUpSession signUpSession = SignUpSession.fromJson(appResponse.data);
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  new OtpVerifyPage(otp: signUpSession.otp, userData: signUpSession.userData, fromForgotPassword: true,),
            ),
          );
        }
      } catch (err) {
        print('CATCH :: ');
        print(err);
        CommonFunction.displayErrorDialog(context: context, msg: err.toString());
      }
    } else {
      _autoValidate = true;
    }
  }
}
