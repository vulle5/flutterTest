// This is how you make a custom class in dart
class ImageModel {
  int id;
  String url;
  String title;

  // Constructor
  ImageModel(this.id, this.url, this.title);

  // Named Constructor that can be called with 'new ImageModel.fromJSON'
  // with parsedJSON data that is a map with keys that are strings and
  // values that are dynamic
  ImageModel.fromJSON(Map<String, dynamic> parsedJSON) {
    id = parsedJSON['id'];
    url = parsedJSON['url'];
    title = parsedJSON['title'];
  }

  /* Alternative syntax to make constructors

  ImageModel.fromJSON(Map<String, dynamic> parsedJSON)
    : id = parsedJSON['id'],
      url = parsedJSON['url'],
      title = parsedJSON['title'];

  */
}