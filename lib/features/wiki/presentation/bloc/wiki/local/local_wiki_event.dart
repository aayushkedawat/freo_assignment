import 'package:equatable/equatable.dart';
import 'package:freo_assignment/features/wiki/domain/entity/page.dart';

abstract class LocalPageEvent extends Equatable {
  final PageEntity? page;
  const LocalPageEvent({this.page});

  @override
  List<Object?> get props => [page];
}

class GetSavedWikiEvent extends LocalPageEvent {
  const GetSavedWikiEvent();
}

class RemoveWikiEvent extends LocalPageEvent {
  const RemoveWikiEvent(PageEntity pageEntity) : super(page: pageEntity);
}

class SaveWikiEvent extends LocalPageEvent {
  const SaveWikiEvent(PageEntity pageEntity) : super(page: pageEntity);
}
