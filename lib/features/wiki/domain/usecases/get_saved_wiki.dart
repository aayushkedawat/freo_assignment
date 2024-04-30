import 'package:freo_assignment/core/usecase/usecase.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';
import 'package:freo_assignment/features/wiki/domain/repository/wiki_repository.dart';

class GetSavedWikiUseCase implements UseCase<List<PageEntity>, void> {
  final WikiRepository _wikiRepository;

  GetSavedWikiUseCase(this._wikiRepository);

  @override
  Future<List<PageEntity>> execute({void params}) {
    return _wikiRepository.getAllPages();
  }
}
