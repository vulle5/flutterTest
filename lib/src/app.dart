import 'package:flutter/material.dart';
// We only import HttpClient from dart:io
import 'dart:convert';
import 'models/image_model.dart';
import 'widgets/image_list.dart';
// http package must be included in pubspec.yaml
// We only import 'get' package from http.dart
import 'package:http/http.dart' show get;

class App extends StatefulWidget {
  @override
  AppState createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  // Integer that we want to change over time
  int counter = 0;
  List<ImageModel> images = [];

  // Build method must be defined with BuildContext build also returns
  // the widget that is inside it
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          // No parenthesis after fetchImage because we want to call fetchImage
          // when button is pressed not when build method is called
          // Alternative way () => fetchImage()
          onPressed: fetchImage,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('Images'),
        ),
      ),
    );
  }

  void fetchImage() async {
    // Every time the function is called counter is increased by one to get new image
    counter++;
    // GET request to server and then make new imageModel instance from it
    final response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    final imageModel = ImageModel.fromJSON(json.decode(response.body));
    print(json.decode(response.body));
    // setState is called so AppState widget re-renders so we can show the new image
    setState(() {
      // Add new image model to the list
      images.add(imageModel);   
    });
  }
}