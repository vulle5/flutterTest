import 'package:flutter/material.dart';
import '../blocs/bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 10.0),),
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    // StreamBuilder re-renders everytime there is a new value
    // coming through the stream or an error
    return StreamBuilder(
      // Reference to the stream you want to use
      stream: bloc.email,
      // What re-renders after there is a change
      // snapshot contains the data and the errors that
      // the stream produces
      builder: (context, snapshot) {
        return TextField(
//          V  Same as below  V
//          onChanged: (newValue) {
//            bloc.changeEmail(newValue);
//          },
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'you@example.com',
            labelText: 'Email Address',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'password',
            labelText: 'Password',
            errorText: snapshot.error
          ),
        );
      }
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Log In'),
      color: Colors.blue,
      onPressed: () => print('jee'),
    );
  }
}