import 'package:flutter_test/flutter_test.dart';
import 'package:freo_assignment/features/wiki/data/data_source/local/app_database.dart';

import 'package:mockito/mockito.dart';

import 'package:freo_assignment/core/error/faliure.dart';
import 'package:freo_assignment/core/resources/data_state.dart';
import 'package:freo_assignment/features/wiki/data/model/page_model.dart';
import 'package:freo_assignment/features/wiki/data/repository/wiki_repository_impl.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWikiRemoteDataSource mockWikiRemoteDataSource;
  late WikiRepositoryImpl wikiRepositoryImpl;
  late AppDatabase mockAppDatabase;

  setUp(() async {
    mockWikiRemoteDataSource = MockWikiRemoteDataSource();
    mockAppDatabase = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    wikiRepositoryImpl =
        WikiRepositoryImpl(mockWikiRemoteDataSource, mockAppDatabase);
  });
  const testQuery = 'Sachin';
  const testWikiPage = PageModel(
      description: 'Indian cricketer',
      index: 2,
      ns: 0,
      pageid: 57570,
      thumbnail:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Sachin-Tendulkar_%28cropped%29.jpg/50px-Sachin-Tendulkar_%28cropped%29.jpg',
      title: 'Sachin Tendulkar');

  group('get wiki page from remote', () {
    test('should return wiki page when a call to data source is success',
        () async {
      when(mockWikiRemoteDataSource.searchWiki(testQuery)).thenAnswer(
          (realInvocation) async => const DataSuccess([testWikiPage]));

      final result = await wikiRepositoryImpl.searchWiki(testQuery);

      expect(result, equals(const DataSuccess([testWikiPage])));
    });
    test('should return wiki page when a call to data source is faliure',
        () async {
      when(mockWikiRemoteDataSource.searchWiki(testQuery)).thenAnswer(
          (realInvocation) async => const DataFailed(ServerFaliure('Error')));

      final DataState<List<PageModel>> result =
          await wikiRepositoryImpl.searchWiki(testQuery);

      expect(result,
          equals(const DataFailed<List<PageModel>>(ServerFaliure('Error'))));
    });
  });
}
