import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'blocs/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here we are using the Provider class
    // Provider now creates a new instance of the bloc
    // and every Widget under MaterialApp has access to it
    return Provider(
      child: MaterialApp(
        title: 'Log me in!',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Log me in!'),
          ),
          body: LoginScreen(),
        ),
      ),
    );     
  }
}