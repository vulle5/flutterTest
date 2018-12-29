import 'package:flutter/material.dart';

// Importing validationMixin
import '../mixins/validations_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

// Using with keyword to add methods from validationMixin
// to LoginScreenState class
class LoginScreenState extends State<LoginScreen> with ValidationMixin{
  // Making a GlobalKey for the Form so we can
  // track widgets inside the Form
  // GlobalKey is created with FormState
  // that's because we want to track the Form's state not form itself
  // to validate and reset Form fields
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
    Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          // Here the GlobalKey is assigned to the Form
          key: formKey,
          child: Column(
            children: <Widget>[
              // Method calls that return a Widget
              emailField(),
              passwordField(),
              Container(margin: EdgeInsets.only(top: 8.0)),
              submitButton(),
            ],
          ),
        ),
      );
    }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email address',
        hintText: 'you@example.com',
      ),
      // Notice that no need to reference validationMixin class
      // because methods from that class were included into this class
      // and we only want to reference the function not invoke it no () needed
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter a password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () {
        // If validate returns true then call the onSaved
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          // If Scaffold is created in the same build method as the Scaffold.of
          // it must be wrapped with Builder Widget
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('You entered email: $email and password: $password'),
          ));
        }
      },
      color: Colors.blue,
    );
  }

  handelSubmit () {

  }
}