import 'package:equatable/equatable.dart';

import '../../../../domain/entity/page.dart';

abstract class LocalPageState extends Equatable {
  final List<PageEntity>? pages;

  const LocalPageState({this.pages});

  @override
  List<Object?> get props => [pages];
}

class LocalPagesLoading extends LocalPageState {
  const LocalPagesLoading();
}

class LocalPagesDone extends LocalPageState {
  const LocalPagesDone(List<PageEntity> pages) : super(pages: pages);
}
