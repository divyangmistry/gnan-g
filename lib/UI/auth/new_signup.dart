// Package import
import 'package:GnanG/UI/auth/new_otp.dart';
import 'package:GnanG/UI/widgets/base_state.dart';
import 'package:GnanG/constans/message_constant.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/model/signupsession.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../Service/apiservice.dart';
import '../../colors.dart';
import '../../common.dart';
// File import

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SignUpPageState();
}

class SignUpPageState extends BaseState<SignUpPage> {
  final _formIndiaKey = GlobalKey<FormState>();
  final _formOtherKey = GlobalKey<FormState>();
  final _tabs = <Tab>[Tab(text: 'India'), Tab(text: 'Rest of World')];
  bool _autoValidate = false;
  ApiService _api = new ApiService();
  String _mhtId;
  String _mobile;
  String _emailId;

  @override
  Widget pageToDisplay() {
    return DefaultTabController(
      length: _tabs.length,
      child: new Scaffold(
        backgroundColor: kQuizSurfaceWhite,
        body: new BackgroundGredient(
          child: TabBarView(
            children: <Widget>[_indiaSignupPage(), _otherSignupPage()],
          ),
        ),
      ),
    );
  }

  Widget _indiaSignupPage() {
    return new Form(
      key: _formIndiaKey,
      autovalidate: _autoValidate,
      child: SafeArea(
        child: new ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            _titleAndLogo(),
            _indiaLoginFields(),
            new SizedBox(height: 50.0),
            _loginBox(),
            /*new SizedBox(height: 15.0),
            _termsAndCondition(),*/
          ],
        ),
      ),
    );
  }

  Widget _otherSignupPage() {
    return new Form(
      key: _formOtherKey,
      autovalidate: _autoValidate,
      child: SafeArea(
        child: new ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          children: <Widget>[
            _titleAndLogo(),
            _otherLoginFields(),
            new SizedBox(height: 50.0),
            _loginBox(),
            new SizedBox(height: 15.0),
            _termsAndCondition(),
          ],
        ),
      ),
    );
  }

  Widget _titleAndLogo() {
    return Column(
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
              'SIGN UP',
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
        new SizedBox(
          height: 25.0,
        ),
        new Container(
//          child: TabBar(tabs: _tabs),
          decoration: BoxDecoration(
            //This is for background color
              color: Colors.white.withOpacity(0.0),
              //This is for bottom border that is needed
              border: Border(bottom: BorderSide(color: Colors.red, width: 0.8),),),
          child: TabBar(tabs: _tabs, indicatorColor: kQuizMain400),
//          color: Colors.red.shade50,
        ),
        new SizedBox(
          height: 25.0,
        ),
      ],
    );
  }

  Widget _indiaLoginFields() {
    return Column(
      children: <Widget>[
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
        new AccentColorOverride(
          color: kQuizBrown900,
          child: new TextFormField(
            validator: CommonFunction.mobileValidation,
            decoration: InputDecoration(
              labelText: 'Mobile no.',
              hintText: 'Enter 10 digit Mobile no.',
              prefixIcon: Icon(
                Icons.call,
                color: kQuizBrown900,
              ),
              filled: true,
            ),
            onSaved: (String value) {
              _mobile = value;
            },
            keyboardType: TextInputType.numberWithOptions(),
          ),
        ),
        new SizedBox(height: 20.0),
        new Container(
          width: MediaQuery.of(context).size.width,
          child: new RaisedButton(
            child: Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 4.0,
            padding: EdgeInsets.all(20.0),
            onPressed: _submitMobile,
          ),
        )
      ],
    );
  }

  Widget _otherLoginFields() {
    return Column(
      children: <Widget>[
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
        new AccentColorOverride(
          color: kQuizBrown900,
          child: new TextFormField(
            validator: CommonFunction.emailValidation,
            decoration: InputDecoration(
              labelText: 'Email-ID',
              hintText: 'Enter Email id.',
              prefixIcon: Icon(
                Icons.email,
                color: kQuizBrown900,
              ),
              filled: true,
            ),
            onSaved: (String value) {
              _emailId = value;
            },
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        new SizedBox(height: 20.0),
        new Container(
          width: MediaQuery.of(context).size.width,
          child: new RaisedButton(
            child: Text(
              'SIGN UP',
              style: TextStyle(color: Colors.white),
            ),
            elevation: 4.0,
            padding: EdgeInsets.all(20.0),
            onPressed: _submitEmail,
          ),
        )
      ],
    );
  }

  Widget _loginBox() {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            'Already have an account?',
            style: TextStyle(color: Colors.grey),
          ),
          new FlatButton(
            child: new Text(
              'LOGIN NOW',
              style: TextStyle(
                color: kQuizBrown900,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _termsAndCondition() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FlatButton(
            child: new Text(
              'Terms and Conditions',
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/t&c');
            },
          ),
        ],
      ),
    );
  }

  void _submitMobile() async {
    if (_formIndiaKey.currentState.validate()) {
      _formIndiaKey.currentState.save();
      _validateUser(mht_id: _mhtId, mobile: _mobile);
    } else {
      _autoValidate = true;
    }
  }

  void _submitEmail() async {
    if (_formOtherKey.currentState.validate()) {
      _formOtherKey.currentState.save();
      _validateUser(mht_id: _mhtId, emailId: _emailId, validateByEmail: true);
    } else {
      _autoValidate = true;
    }
  }

  void _validateUser({
    @required String mht_id,
    bool validateByEmail = false,
    String mobile,
    String emailId,
  }) async {
    setState(() {
      isOverlay = true;
    });
    try {
      Response res;
      if (validateByEmail) {
        res = await _api.validateUserOther(mhtId: mht_id, emailId: emailId);
      } else {
        res = await _api.validateUserIndia(mhtId: mht_id, mobileNo: mobile);
      }
      AppResponse appResponse = ResponseParser.parseResponse(context: context, res: res, showDialog: false);
      if (appResponse.status == 200) {
        SignUpSession signUpSession = SignUpSession.fromJson(appResponse.data);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => new OtpVerifyPage(
                  otp: signUpSession.otp,
                  userData: signUpSession.userData,
                  fromForgotPassword: false,
                ),
          ),
        );
      } else if (appResponse.status == 400) {
        CommonFunction.alertDialog(
          context: context,
          title: 'Data Not Found',
          msg: 'Your MHT ID & Mobile No. is not registred with us, Kindly click below to enter registration detail.',
          doneButtonText: 'Register',
          doneButtonFn: () {
            Navigator.pushReplacementNamed(context, '/registrationrequest');
          },
          showCancelButton: true
        );
      } else {
        CommonFunction.alertDialog(
          context: context,
          title: 'Error - ' + appResponse.status.toString(),
          msg: appResponse.message != null
              ? appResponse.message
              : MessageConstant.COMMON_ERROR_MSG,
          doneButtonText: 'Okay',
        );
      }
    } catch (err) {
      print('CATCH :: ');
      print(err);
      CommonFunction.displayErrorDialog(
        context: context,
        msg: err.toString(),
      );
    }
    setState(() {
      isOverlay = false;
    });
  }

}
