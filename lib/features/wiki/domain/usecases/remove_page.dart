import 'package:freo_assignment/core/usecase/usecase.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';
import 'package:freo_assignment/features/wiki/domain/repository/wiki_repository.dart';

class RemoveWikiUseCase implements UseCase<void, PageEntity?> {
  final WikiRepository _wikiRepository;

  RemoveWikiUseCase(this._wikiRepository);

  @override
  Future<void> execute({PageEntity? params}) {
    return _wikiRepository.deleteWikiPage(params!);
  }
}
