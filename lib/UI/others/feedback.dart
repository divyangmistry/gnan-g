import 'package:GnanG/Service/apiservice.dart';
import 'package:GnanG/colors.dart';
import 'package:GnanG/common.dart';
import 'package:GnanG/constans/wsconstants.dart';
import 'package:GnanG/model/appresponse.dart';
import 'package:GnanG/utils/response_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _autoValidate = false;
  ApiService _api = new ApiService();
  String _contact;
  String _message;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Report Issue',
          style: TextStyle(color: kQuizSurfaceWhite),
        ),
      ),
      body: new SafeArea(
        child: CustomLoading(
          isLoading: _isLoading,
          isOverlay: true,
          child: SafeArea(
            child: new Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: new ListView(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                children: <Widget>[
                  new SizedBox(height: 40.0),
                  new AccentColorOverride(
                    color: kQuizBrown900,
                    child: new TextFormField(
                      validator: CommonFunction.contactValidation,
                      decoration: InputDecoration(
                        labelText: 'Contact no. / Email-Id',
                        hintText: 'Enter Mobile no. / Email Id',
                        prefixIcon: Icon(
                          Icons.contact_mail,
                          color: kQuizBrown900,
                        ),
                        filled: true,
                      ),
                      onSaved: (String value) {
                        _contact = value;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  new SizedBox(height: 20.0),
                  new AccentColorOverride(
                    color: kQuizBrown900,
                    child: new TextFormField(
                      maxLines: null,
                      validator: CommonFunction.messageValidation,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        hintText:
                            'Type here issue that you are facing ... \nYou can also feedback here.',
                        prefixIcon: Icon(
                          Icons.message,
                          color: kQuizBrown900,
                        ),
                        filled: true,
                      ),
                      onSaved: (String value) {
                        _message = value;
                      },
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  new SizedBox(height: 20.0),
                  new RaisedButton(
                    child: Text(
                      'SEND',
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
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      print('Feedback DATA');
      print('_contact : ${this._contact}');
      print('_message : ${this._message}');
      try {
        Response res =
            await _api.feedback(contact: this._contact, message: this._message);
        AppResponse appResponse =
            ResponseParser.parseResponse(context: context, res: res);
        if (appResponse.status == WSConstant.SUCCESS_CODE) {
          CommonFunction.alertDialog(
            context: context,
            msg: 'Feedback send successfully',
            type: 'success',
            barrierDismissible: false,
            doneButtonFn: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } catch (err) {
        print('CATCH Feedback :: ');
        print(err);
        setState(() {
          _isLoading = false;
        });
        CommonFunction.displayErrorDialog(
          context: context,
          msg: err.toString(),
        );
      }
    } else {
      _autoValidate = true;
    }
  }
}
