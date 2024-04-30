import 'package:flutter_test/flutter_test.dart';
import 'package:freo_assignment/core/constants/strings.dart';
import 'package:freo_assignment/core/error/faliure.dart';
import 'package:freo_assignment/core/resources/data_state.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/remote/remote_wiki_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/remote/remote_wiki_event.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/remote/remote_wiki_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetWikiUseCase mockGetWikiUseCase;
  late RemoteWikiBloc remoteWikiBloc;

  setUp(() {
    mockGetWikiUseCase = MockGetWikiUseCase();
    remoteWikiBloc = RemoteWikiBloc(mockGetWikiUseCase);
  });

  const testQuery = 'Sachin';
  const testWikiPage = PageEntity(
      description: 'Indian cricketer',
      index: 2,
      ns: 0,
      pageid: 57570,
      thumbnail:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Sachin-Tendulkar_%28cropped%29.jpg/50px-Sachin-Tendulkar_%28cropped%29.jpg',
      title: 'Sachin Tendulkar');

  test('initial state should be empty', () {
    expect(remoteWikiBloc.state, const RemoteWikiInitial());
  });

  blocTest<RemoteWikiBloc, RemoteWikiState>(
    'should emit [RemoteWikiLoading RemoteWikiDone] when data is there',
    build: () {
      when(mockGetWikiUseCase.execute(params: testQuery)).thenAnswer(
          (realInvocation) async => const DataSuccess([testWikiPage]));
      return remoteWikiBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(query: testQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const RemoteWikiLoading(),
      const RemoteWikiDone([testWikiPage])
    ],
  );
  blocTest<RemoteWikiBloc, RemoteWikiState>(
    'should emit [RemoteWikiLoading RemoteWikiFaliure] when data is there',
    build: () {
      when(mockGetWikiUseCase.execute(params: testQuery)).thenAnswer(
          (realInvocation) async =>
              DataFailed(NoQueryFaliure(Strings.enterQuery)));
      return remoteWikiBloc;
    },
    act: (bloc) {
      // bloc.add(const OnQueryChanged(query: 'abc'));
      bloc.add(const OnQueryChanged(query: ''));
    },
    wait: const Duration(milliseconds: 500),
    expect: () => [RemoteWikiError(NoQueryFaliure(Strings.enterQuery))],
  );
}
