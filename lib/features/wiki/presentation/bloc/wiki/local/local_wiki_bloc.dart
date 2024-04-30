// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/get_saved_wiki.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/remove_page.dart';
import 'package:freo_assignment/features/wiki/domain/usecases/save_page.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/local/local_wiki_event.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/local/local_wiki_state.dart';
import 'package:rxdart/rxdart.dart';

class LocalPageBloc extends Bloc<LocalPageEvent, LocalPageState> {
  final GetSavedWikiUseCase _getSavedWikiEvent;
  final SaveWikiUseCase _saveWikiEvent;
  final RemoveWikiUseCase _removeWikiUseCase;
  LocalPageBloc(
      this._getSavedWikiEvent, this._removeWikiUseCase, this._saveWikiEvent)
      : super(const LocalPagesLoading()) {
    on<GetSavedWikiEvent>(
      (event, emit) async {
        final pages = await _getSavedWikiEvent.execute();
        emit(LocalPagesDone(pages));
      },
    );
    on<RemoveWikiEvent>(
      (event, emit) async {
        await _removeWikiUseCase.execute(params: event.page);

        final pages = await _getSavedWikiEvent.execute();
        emit(LocalPagesDone(pages));
      },
    );
    on<SaveWikiEvent>(
      (event, emit) async {
        await _saveWikiEvent.execute(params: event.page);

        final pages = await _getSavedWikiEvent.execute();
        emit(LocalPagesDone(pages));
      },
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
