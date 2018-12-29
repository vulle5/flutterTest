import 'dart:async';
// Validators is a mixin
import 'validators.dart';

// We cannot use "with" keyword without "extends"
// because Validators methods need to be connected to
// extended class. In this case we use the most root
// class that exists in called Object to circumvent the issue
class Bloc extends Object with Validators{
  // Controllers contain sink and stream properties
  //    V  Private field  V
  final _email = new StreamController<String>();
  final _password = new StreamController<String>();

  // We make getters to make our code more concise
  // Now we can reference stream by just writing "email"

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  // Change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Dispose is just a conventional name for a function
  // that gets rid of things that are not needed any more
  // In our case we never close the sinks, but we create dispose
  // method to get rid of warnings that Dart gives
  dispose() {
    _email.close();
    _password.close();
  }
}