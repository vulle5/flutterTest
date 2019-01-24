import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    final newsApi = NewsApiProvider();

    // Mocking get request *has to be async*
    // Overriding the client with our mock version
    newsApi.client = MockClient((request) async {
      // Must return Response with body and statusCode
      // Encoding into json because NewsApiProvider decodes it
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    // Mocking that we have to wait for the request
    final ids = await newsApi.fetchTopIds();

    // Expect this pattern of ids
    expect(ids, [1, 2, 3, 4]);
  });
  
  test('FetchItem returns a ItemModel', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);
    
    expect(item.id, 123);
  });
}
