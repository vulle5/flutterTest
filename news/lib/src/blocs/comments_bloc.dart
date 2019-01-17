import 'package:rxdart/rxdart.dart';
import 'dart:async';

import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _repository = Repository();

  // Streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  // Sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  _commentsTransformer() {
    // Recursively fetching comments that are nested
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, _) {
        // Fetch given id
        cache[id] = _repository.fetchItem(id);
        // When fetched then forEach kid property call the stream again
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>> {}
    ); 
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
