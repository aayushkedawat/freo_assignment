import 'package:floor/floor.dart';
import 'package:freo_assignment/features/wiki/data/model/page_model.dart';

@dao
abstract class WikiPageDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWikiPage(PageModel pageModel);

  @delete
  Future<void> deleteWikiPage(PageModel pageModel);

  @Query('select * from page')
  Future<List<PageModel>> getAllPages();
}
