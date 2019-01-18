import 'package:flutter/material.dart';
import 'package:kon_banega_mokshadhipati/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return new Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: new Scaffold(
        body: SafeArea(
          child: new ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              new SizedBox(
                height: 80.0,
              ),
              new Column(
                children: <Widget>[
                  new Image.asset('images/logo.png',height: 70,),
                  // new SizedBox(height: 16.0),
                  // new Text('SAMPLE')
                ],
              ),
              new SizedBox(
                height: 120.0,
              ),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  validator: _mhtIdValidation,
                  decoration: InputDecoration(
                    labelText: 'Mobile no.',
                    hintText: 'Enter Mobile no.',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                ),
              ),
              new SizedBox(height: 12.0),
              new AccentColorOverride(
                color: kQuizBrown900,
                child: new TextFormField(
                  validator: _passwordValidation,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
              ),
              new ButtonBar(
                children: <Widget>[
                  new FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      _formKey.currentState.reset();
                      _autoValidate = false;
                    },
                  ),
                  new RaisedButton(
                    child: Text('Login'),
                    elevation: 8.0,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.pop(context);
                      } else {
                        _autoValidate = true;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: Image.asset(
        'images/logo.png',
        height: 70.0,
      ),
    );
  }

  String _mhtIdValidation(value) {
    if (value.isEmpty) {
      return 'Mht ID is required';
    } else if (value.length != 10) {
      return 'Mht ID must have 10 digit';
    }
    return "";
  }

  String _passwordValidation(value) {
    Pattern pattern =
        r'(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Passwords must contain at least six characters';
    } else if (!regex.hasMatch(value)) {
      return 'Passwords must contain uppercase, lowercase letters and numbers';
    }
    return "";
  }
}


class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context)
          .copyWith(accentColor: color, brightness: Brightness.dark),
    );
  }
}