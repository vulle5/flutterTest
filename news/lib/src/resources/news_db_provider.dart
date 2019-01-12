import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';

import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  // Calling init in the constructor. This is a great way call methods
  // that have to be called if you want to properly use this class
  NewsDbProvider() {
    init();
  }

  // TODO: fetch top ids and store them
  Future<List<int>> fetchTopIds() {
    return null;
  }

  void init() async {
    // getApplicationDocumentsDirectory() returns the path where this app
    // is allowed to privately store data 'package:path_provider'
    // data is only deleted when app is uninstalled or data is manually cleared
    // Directory is a data type that contains a directory 'dart:io'
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // We join the path from documentsDirectory and our custom path called
    // items.db where our database is located
    final path = join(documentsDirectory.path, "items.db");
    // Creating a database
    db = await openDatabase(
      // Where we want to create the database but if db already exist
      // then it will just reopen it
      path,
      version: 1,
      // onCreate is called only if db does not already exist
      onCreate: (Database newDb, int version) {
        // execute func allows execution of SQL code
        // """your multiline String"""
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              /* Blob is just represtation of some data in binary form */
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER 
            )
        """);
      }
    );
  }
  // Fetch item from db with id
  Future<ItemModel> fetchItem(int id) async {
    // query allows to make SQL queries
    final maps = await db.query(
      // Table name
      "Items",
      // if null query will contain all columns inside the table
      columns: null,
      // '?' contains the value from whereArgs to avoid SQL Injection
      where: "id = ?",
      whereArgs: [id],
    );

    // If item with given id was found make ItemModel out of it
    // so we can use it in our app easily. If no item with given id was found
    // return null
    if(maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  // Adding an ItemModel to the database
  Future<int> addItem(ItemModel item) {
    // insert to make SQL INSERT
    return db.insert(
      "Items", 
      item.toMapForDb(),
      // Ignore any sql exceptions and move along
      // We do not really care about added items that cause errors
      // Because db acts as a cache of fetched news stories that can be
      // fetched also from the internet
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  // Clears items table
  Future<int> clear() {
    return db.delete("Items");
  }
}

// Creating new instance of the class so we do not have multiple connections to our database
// So now we only use this single instance of newsDbProvider
final NewsDbProvider newsDbProvider = NewsDbProvider();
