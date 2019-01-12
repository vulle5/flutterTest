import 'dart:async';

import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

// Repository class handles the access to database and network calls
class Repository {
  List<Source> sources = [
    // Instance of NewsDbProvider()
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = [
    newsDbProvider,
  ];

  // TODO: Iterate over sources after fetchTopIds
  // gets implemented in the news_db_provider
  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  // If not already found in database then do the network call
  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
    // Ask Source to look for Item with given id from newsdbProvider
    // if not found in database ask newsApiProvider to do a network request
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  // Clear the cache
  Future<int> clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

// Defining abstract classes that fetch items from db or network
abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}
// Defining abstract class that adds missing items to the database
abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
// With these abstract classes we can later add more data fetching sources
// or add more places were we can save items without creating unique classes
