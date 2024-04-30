import 'package:freo_assignment/core/resources/data_state.dart';
import 'package:freo_assignment/core/usecase/usecase.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';
import 'package:freo_assignment/features/wiki/domain/repository/wiki_repository.dart';

class GetWikiUseCase implements UseCase<DataState<List<PageEntity>>, String?> {
  final WikiRepository _wikiRepository;

  GetWikiUseCase(this._wikiRepository);
  @override
  Future<DataState<List<PageEntity>>> execute({String? params}) {
    return _wikiRepository.searchWiki(params!);
  }
}
