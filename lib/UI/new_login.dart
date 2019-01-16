import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bkg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: new SafeArea(
          child: new ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              new SizedBox(
                height: 50,
              ),
              _logo(),
              new SizedBox(
                height: 50,
              ),
              _loginView(),
              new SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginView() {
    return new Opacity(
      opacity: 0.9,
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10.0,
        child: new Padding(
          padding: EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new Container(
                child: new Center(
                  child: new Text(
                    'Login',
                    textScaleFactor: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.pink
                    ),
                  ),
                ),
              ),
              new SizedBox(
                height: 50.0,
              ),
              _loginForm(),
              new SizedBox(
                height: 40.0,
              ),
              _loginButton(),
              new SizedBox(
                height: 20.0,
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

  Widget _loginForm() {
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new TextFormField(
            validator: _mobileValidation,
            keyboardType: TextInputType.numberWithOptions(),
            decoration: const InputDecoration(
              labelText: 'Mht ID:',
              hintText: 'Enter your Mht ID',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.person_outline),
            ),
            // onSaved: (String value) {
            //   this._data.mobile = value;
            // },
          ),
          new SizedBox(
            height: 20.0,
          ),
          new TextFormField(
            validator: _passwordValidation,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password:',
              hintText: 'Enter your Password',
              border: OutlineInputBorder(),
              suffixIcon: Icon(
                Icons.lock_outline,
              ),
            ),
            // onSaved: (String value) {
            //   this._data.password = value;
            // },
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      color: Colors.purple[300],
      elevation: 10.0,
      padding: EdgeInsets.all(12.0),
      onPressed: () {
        Navigator.pushNamed(context, '/gameStart');
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.vpn_key),
          SizedBox(width: 10),
          Text('Login')
        ],
      ),
    );
  }

  String _mobileValidation(value) {
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
    // Pattern pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).*$';
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
