import 'dart:async';
// Validators is a mixin
import 'validators.dart';
// Adding rxdart 3rd party libary for additional
// functionality for the streams
import 'package:rxdart/rxdart.dart';

// We cannot use "with" keyword without "extends"
// because Validators methods need to be connected to
// extended class. In this case we use the most root
// class that exists in called Object to circumvent the issue
class Bloc extends Object with Validators{
  // BehaviorSubject is a special StreamController that captures the last
  // item that has been added to the stream and treats that value as a
  // first value to the stream
  // Also BehaviorSubject can be listened by multiple listeners
  //    V  Private field  V
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // We make getters to make our code more concise
  // Now we can reference stream by just writing "email"

  // Add data to stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  // When both streams return values the 'combiner' returns true
  Stream<bool> get submitValid =>
    Observable.combineLatest2(email, password, (String e, String p) {
      if (e == _email.value && p == _password.value) {
        return true;
      }
      return false;
    });

  // Change data             V  Both _email.sink.add and _email.add work   V
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() {
    final validEmail = _email.value;
    final validPassword = _password.value;

    print('Email is $validEmail and Password is $validPassword');
  }

  // Dispose is just a conventional name for a function
  // that gets rid of things that are not needed any more
  // In our case we never close the sinks, but we create dispose
  // method to get rid of warnings that Dart gives
  dispose() {
    _email.close();
    _password.close();
  }
}
