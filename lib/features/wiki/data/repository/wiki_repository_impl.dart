import 'package:freo_assignment/core/resources/data_state.dart';
import 'package:freo_assignment/features/wiki/data/data_source/local/app_database.dart';
import 'package:freo_assignment/features/wiki/data/data_source/remote/wiki_api_service.dart';
import 'package:freo_assignment/features/wiki/data/model/page_model.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';

import 'package:freo_assignment/features/wiki/domain/repository/wiki_repository.dart';

class WikiRepositoryImpl implements WikiRepository {
  final WikiRemoteDataSource _wikiRemoteDataSource;

  final AppDatabase _appDatabase;

  WikiRepositoryImpl(this._wikiRemoteDataSource, this._appDatabase);
  @override
  Future<DataState<List<PageModel>>> searchWiki(String query) {
    return _wikiRemoteDataSource.searchWiki(query);
  }

  @override
  Future<List<PageEntity>> getAllPages() {
    return _appDatabase.wikiPageDao.getAllPages();
  }

  @override
  Future<void> deleteWikiPage(PageEntity page) {
    return _appDatabase.wikiPageDao.deleteWikiPage(PageModel.fromEntity(page));
  }

  @override
  Future<void> insertWikiPage(PageEntity page) {
    return _appDatabase.wikiPageDao.insertWikiPage(PageModel.fromEntity(page));
  }
}
