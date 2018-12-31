import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This does not create instance of the provider
    // it only calls 'of' constructor inside the Provider class
    // with LoginScreens context.
    // 'of' constructor is 'static' so it cannot be called from the instance
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          // Passing bloc to the functions
          emailField(bloc),
          passwordField(bloc),
          Container(margin: EdgeInsets.only(top: 10.0),),
          submitButton(bloc),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
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

  Widget passwordField(Bloc bloc) {
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

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Log In'),
          color: Colors.blue,
          // If streams last returned value is true enable button
          onPressed: snapshot.data == true ? bloc.submit : null,
        );
      },
    );
  }
}