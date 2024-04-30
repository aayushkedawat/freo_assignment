import 'package:freo_assignment/features/wiki/domain/entity/page.dart';

import '../../../../core/resources/data_state.dart';

abstract class WikiRepository {
  Future<DataState<List<PageEntity>>> searchWiki(String query);
  Future<void> insertWikiPage(PageEntity page);
  Future<void> deleteWikiPage(PageEntity page);
  Future<List<PageEntity>> getAllPages();
}
