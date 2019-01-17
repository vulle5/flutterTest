import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  // Constructor takes news story itemId from the parent class
  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          // Loads grey boxes
          return LoadingContainer();
        }

        return FutureBuilder(
          // Going to build with specific itemId
          future: snapshot.data[itemId],
          // When Future is resolved build our specific news story
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            // Return only the title from ItemModel
            // Passing context to buildTile
            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    String numberOfComments = '${item.descendants}';
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.url}<url>');
          },
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              // If no comments allowed show no icon or text
              IconButton(
                icon: Icon(item.descendants == null ? null : Icons.comment),
                onPressed: () {
                  // onTap go to named route with given item.id
                  Navigator.pushNamed(context, '/${item.id}');
                },
              ),
              Text(numberOfComments.contains('null') ? '' : numberOfComments),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}