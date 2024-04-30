// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freo_assignment/core/constants/strings.dart';
import 'package:rxdart/rxdart.dart';

import 'package:freo_assignment/core/error/faliure.dart';
import 'package:freo_assignment/core/resources/data_state.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/get_wiki.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/remote/remote_wiki_event.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/remote/remote_wiki_state.dart';

class RemoteWikiBloc extends Bloc<RemoteWikiEvent, RemoteWikiState> {
  final GetWikiUseCase _getWikiUseCase;
  RemoteWikiBloc(this._getWikiUseCase) : super(const RemoteWikiInitial()) {
    on<OnQueryChanged>((event, emit) async {
      if (event.query.isEmpty) {
        emit(RemoteWikiError(NoQueryFaliure(Strings.enterQuery)));
        return;
      }
      emit(const RemoteWikiLoading());
      final dataState = await _getWikiUseCase.execute(params: event.query);

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        emit(RemoteWikiDone(dataState.data!));
      } else if (dataState is DataFailed) {
        emit(RemoteWikiError(dataState.exception!));
      }
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
