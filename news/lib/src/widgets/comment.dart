import 'package:flutter/material.dart';
import 'dart:async';

import '../models/item_model.dart';
import '../widgets/loading_container.dart';

class Comment extends StatelessWidget {
  // Comment we want to show on the screen
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item), 
            subtitle: item.by == '' ? Text('Comment does not exist anymore') : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
          ),
          Divider(),
        ];
        // Looks what comments are under the specific comment
        snapshot.data.kids.forEach((kidId) {
          children.add(
            Comment(itemId: kidId, itemMap: itemMap, depth: depth + 1,)
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }

  // Replaces html tags with simple text
  Widget buildText(ItemModel item) {
    final text = item.text
      .replaceAll('&#x27;', "'")
      .replaceAll('<p>', '\n\n')
      .replaceAll('</p>', '')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#x2F;', '/');
    
    return Text(text);
  }
}
