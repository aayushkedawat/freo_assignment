import 'package:equatable/equatable.dart';

import '../../../../../../core/error/faliure.dart';
import '../../../../domain/entity/page.dart';

abstract class RemoteWikiState extends Equatable {
  final List<PageEntity>? pages;
  final Faliure? error;

  const RemoteWikiState({this.error, this.pages});

  @override
  List<Object?> get props => [pages, error];
}

class RemoteWikiInitial extends RemoteWikiState {
  const RemoteWikiInitial();
}

class RemoteWikiLoading extends RemoteWikiState {
  const RemoteWikiLoading();
}

class RemoteWikiDone extends RemoteWikiState {
  const RemoteWikiDone(List<PageEntity> pages) : super(pages: pages);
}

class RemoteWikiError extends RemoteWikiState {
  const RemoteWikiError(Faliure exception) : super(error: exception);
}
