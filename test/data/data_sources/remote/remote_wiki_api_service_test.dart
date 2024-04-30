import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:freo_assignment/core/constants/constants.dart';
import 'package:freo_assignment/core/error/faliure.dart';
import 'package:freo_assignment/core/resources/data_state.dart';
import 'package:freo_assignment/features/wiki/data/data_source/remote/wiki_api_service.dart';
import 'package:freo_assignment/features/wiki/data/model/page_model.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late WikiRemoteDataSourceImpl wikiRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();

    wikiRemoteDataSourceImpl = WikiRemoteDataSourceImpl(mockHttpClient);
  });

  group('get wiki page', () {
    const testQuery = 'Sachin';

    test('should return wiki pages when status code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.searchWikiByQuery(testQuery))))
          .thenAnswer(
        (_) async => http.Response(
            readJson('helpers/dummy_data/dummy_wiki_response.json'), 200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }),
      );
      // assert
      final result = await wikiRemoteDataSourceImpl.searchWiki(testQuery);

      // act
      expect(result, isA<DataState<List<PageModel>>>());
    });
    test('should return wiki pages when status code is 404', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(Urls.searchWikiByQuery(testQuery))))
          .thenAnswer(
        (_) async => http.Response('Not Found', 404, headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        }),
      );
      // assert
      final result = await wikiRemoteDataSourceImpl.searchWiki(testQuery);

      // act
      expect(result.exception, isA<ServerFaliure>());
    });
  });
}
