import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  String _userMail = '';
  String _userName = '';
  String _userPassword = '';
  bool isLogin = true;

  void _trySubmit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState.save();
      print(_userMail);
      print(_userName);
      print(_userPassword);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    validator: (value){
                      if(value.isEmpty|| !value.contains('@')){
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userMail = value;
                    },
                  ),
                  if(isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(
                      labelText: 'User Name',
                    ),
                    validator: (value){
                      if(value.isEmpty|| value.length < 5){
                        return 'User name must be at least 5 characters long';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userName = value;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value){
                      if(value.isEmpty|| value.length < 7){
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userPassword = value;
                    },
                  ),
                  RaisedButton(
                    child: Text(isLogin ? 'Login' : 'Signup',),
                    onPressed: _trySubmit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin ? 'Create an account' : 'Already have an account?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
