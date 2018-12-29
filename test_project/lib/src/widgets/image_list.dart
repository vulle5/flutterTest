import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  // Instances in Stateless widgets can not be mutated so List has to be final
  final List<ImageModel> images;

  // Constructor for ImageList class that expects images
  ImageList(this.images);
  
  @override
  Widget build(BuildContext context) {
    // ListView.builder creates ListView that is going to load more images
    // as user scrolls down
    return ListView.builder(
      itemCount: images.length,
      // itemBuilder makes a new Text widget every time it's called
      // and increments index by one
      itemBuilder: (context, int index) {
        return buildImage(images[index], index);
      },
    );
  }

  // Method of type Container that returns a Container
  // Cleaner way to do things than writing everything
  // inside build method
  Container buildImage(ImageModel image, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 7.0, color: Colors.grey)
      ),
      padding: EdgeInsets.all(20.0),
      // Top margin only on first image so we do not get double
      // margin on subsequent images 
      margin: EdgeInsets.only(
        bottom: 20.0, 
        top: index == 0 ? 20.0 : 0, 
        left: 20.0, 
        right: 20.0
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.network(image.url),
          ),
          Text(image.title),
        ],
      ),
    );
  }
}