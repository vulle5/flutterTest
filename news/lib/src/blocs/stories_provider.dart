import 'package:flutter/material.dart';
import 'stories_bloc.dart';

// This export also exports stories_bloc.dart when provider is imported
// So no need to separately import them
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child})
    : bloc = StoriesBloc(),
    super(key: key, child: child);

  updateShouldNotify(_) => true;

  static StoriesBloc of(BuildContext context) {
  
    return (context.inheritFromWidgetOfExactType(StoriesProvider) as StoriesProvider).bloc;
  }
}
