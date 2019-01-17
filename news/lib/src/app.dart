import 'package:flutter/material.dart';

import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrapping whole app with provider so every Widget has access to it
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
        // Navigation with onGenerateRoute
          onGenerateRoute: routes
        ),
      ),
    );  
  }

  Route routes(RouteSettings settings) {
    // Use switch case in more complicated navigation
    // settings contains all the needed variables for navigation
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);

          storiesBloc.fetchTopIds();

          return NewsList();
        }
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          // Turn route name into itemId
          final int itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(itemId: itemId);
        }
      );
    } 
  }
}