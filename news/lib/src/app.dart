import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrapping whole app with provider so every Widget has access to it
    return StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        // Navigation with onGenerateRoute
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) {
              return NewsList();
            }
          );
        },
      ),
    );  
  }
}