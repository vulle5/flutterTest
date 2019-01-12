import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  // StreamController with added functionality from rxDart
  // for our TopIds
  final _topIds = PublishSubject<List<int>>();
  // StreamController for our news stories
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  // StreamController for transforming
  final _itemsFetcher = PublishSubject<int>();

  // Getter to stream so widgets can access the topIds stream
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  // Getters for the sink
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  // Constructor
  StoriesBloc() {
    // items stream or "Observable" that only creats one instance of transformer
    // CAN NOT USE GETTER BECAUSE ONLY ONE INSTANCE OF TRANSFORMER IS NEEDED
    // OTHERWISE WE LOSE OUR CACHE THAT CONTAINS OUR NEWS STORIES

    // Fowarding transformed data to _itemsOutput using rxDart .pipe func
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  // This function gets top ids from repository and adds them to the stream
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Future<int> clearCache() {
    return _repository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      // 1st: cache where new set of values is stored
      // 2nd: ids that come into our stream from fetchTopIds()
      // 3rd: how many times has this transformer been invoked "don't care"
      (Map<int, Future<ItemModel>> cache, int id, _) {
        // Add new ItemModel to the cache that contains our single news story
        print(_);
        cache[id] = _repository.fetchItem(id);
        // Return cache so it's saved for the next time this function is invoked
        // and the newly formed list of news stories is sent to the Widget that calls this
        return cache;
      },
      // Empty Map that is our cache that we are going to send to the Widget
      <int, Future<ItemModel>> {},
    );
  }

  // If you ever need to close the stream
  void dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  } 
}