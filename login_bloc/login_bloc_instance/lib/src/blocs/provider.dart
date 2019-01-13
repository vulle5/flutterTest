import 'package:flutter/material.dart';
import 'bloc.dart';

// This class provides bloc class to Widgets that need it
class Provider extends InheritedWidget {
  // Instance of bloc that is going to be called
  // after instance of Provider is created
  // So we are going to create new inctance for every parent
  // widget that needs it. This is called a scoped instance
  final bloc = Bloc();

  // In this constructor we are fowarding key and child
  // to the Super class of this class 'InheritedWidget'
  Provider({Key key, Widget child})
    : super(key: key, child: child);

  // Set this to true
  bool updateShouldNotify(_) => true;

  // We create static method called 'of' so we don't accidently call this method
  // from the inctance of the provider.
  // Context contains info about Widgets location in the tree
  static Bloc of(BuildContext context) {
    // Look up the context tree until you find Widget of type Provider
    // and treat it 'as' of type Provider and out of that returned Widget 
    // we only want the 'bloc' property then return it
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
