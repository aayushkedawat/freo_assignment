import 'package:equatable/equatable.dart';

abstract class RemoteWikiEvent extends Equatable {
  const RemoteWikiEvent();

  @override
  List<Object?> get props => [];
}

class OnQueryChanged extends RemoteWikiEvent {
  final String query;
  const OnQueryChanged({required this.query});

  @override
  List<Object?> get props => [query];
}
