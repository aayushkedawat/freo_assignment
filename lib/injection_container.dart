import 'package:freo_assignment/features/wiki/data/repository/wiki_repository_impl.dart';
import 'package:freo_assignment/features/wiki/domain/repository/wiki_repository.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/get_wiki.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/remove_page.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/save_page.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/local/local_wiki_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/remote/remote_wiki_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/wiki/data/data_source/local/app_database.dart';
import 'features/wiki/data/data_source/remote/wiki_api_service.dart';
import 'package:http/http.dart' as http;

import 'features/wiki/domain/usecases/get_saved_wiki.dart';
import 'features/wiki/presentation/bloc/wiki/web/web_bloc.dart';

final sl = GetIt.instance;

Future<void> initialiseDependencies() async {
  // local database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton(database);
  // Http client
  sl.registerSingleton<http.Client>(http.Client());
  // Dependencies
  sl.registerSingleton<WikiRemoteDataSource>(WikiRemoteDataSourceImpl(sl()));

  sl.registerSingleton<WikiRepository>(WikiRepositoryImpl(sl(), sl()));

  // Usecase
  sl.registerSingleton<GetWikiUseCase>(GetWikiUseCase(sl()));
  sl.registerSingleton<GetSavedWikiUseCase>(GetSavedWikiUseCase(sl()));
  sl.registerSingleton<RemoveWikiUseCase>(RemoveWikiUseCase(sl()));
  sl.registerSingleton<SaveWikiUseCase>(SaveWikiUseCase(sl()));

  sl.registerFactory<RemoteWikiBloc>(() => RemoteWikiBloc(sl()));
  sl.registerFactory<LocalPageBloc>(() => LocalPageBloc(sl(), sl(), sl()));
  sl.registerFactory<WebBloc>(() => WebBloc());
}
