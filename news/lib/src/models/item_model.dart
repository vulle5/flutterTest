import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson) 
  // Initializer list sets values before the constructor runs
    : id = parsedJson['id'],
      // if parsedJson['deleted'] has no value set it to false
      deleted = parsedJson['deleted'] ?? false,
      type = parsedJson['type'],
      by = parsedJson['by'] ?? '',
      time = parsedJson['time'],
      // if null set to empty String
      text = parsedJson['text'] ?? '',
      dead = parsedJson['dead'] ?? false,
      parent = parsedJson['parent'],
      kids = parsedJson['kids'] ?? [],
      url = parsedJson['url'],
      score = parsedJson['score'],
      title = parsedJson['title'],
      descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> dbData)
  // Initializer list sets values before the constructor runs
    : id = dbData['id'],
  // Because 'deleted' is a bool it will return true if data coming from db is 1
      deleted = dbData['deleted'] == 1,
      type = dbData['type'],
      by = dbData['by'],
      time = dbData['time'],
      text = dbData['text'],
      dead = dbData['dead'] == 1,
      parent = dbData['parent'],
  // jsonDecode is able to decode a BLOB
      kids = jsonDecode(dbData['kids']),
      url = dbData['url'],
      score = dbData['score'],
      title = dbData['title'],
      descendants = dbData['descendants'];

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic> {
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
