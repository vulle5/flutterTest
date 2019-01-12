import 'package:flutter/material.dart';

// This class creates loading grey boxes
class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(height: 8.0,)
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      decoration: ShapeDecoration(
        color: Colors.grey[300],
        // Adding radius to the container
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        )
      ),
    );
  }
}