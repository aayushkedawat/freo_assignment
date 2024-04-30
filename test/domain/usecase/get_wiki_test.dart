import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:freo_assignment/core/resources/data_state.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/get_wiki.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  MockWikiRepository? mockWikiRepository;
  GetWikiUseCase? getWikiUseCase;

  setUp(() {
    mockWikiRepository = MockWikiRepository();
    getWikiUseCase = GetWikiUseCase(mockWikiRepository!);
  });

  const testWikiPage = PageEntity(
      description: 'Indian cricketer',
      index: 2,
      ns: 0,
      pageid: 57570,
      thumbnail:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Sachin-Tendulkar_%28cropped%29.jpg/50px-Sachin-Tendulkar_%28cropped%29.jpg',
      title: 'Sachin Tendulkar');

  const testQuery = 'Sachin';

  test('should get wiki page detail from repository', () async {
    // arrange

    when(mockWikiRepository!.searchWiki(testQuery)).thenAnswer(
        (realInvocation) async => const DataSuccess([testWikiPage]));
    final result = await getWikiUseCase!.execute(params: testQuery);

    // assert

    expect(result, const DataSuccess([testWikiPage]));
  });

  // act
}
