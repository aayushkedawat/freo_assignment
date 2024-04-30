import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/web/web_event.dart';
import 'package:freo_assignment/features/wiki/presentation/bloc/wiki/web/web_state.dart';

class WebBloc extends Bloc<WebEvent, WebState> {
  WebBloc() : super(WebLoadingState(true)) {
    on<OnPageStartLoading>(
      (event, emit) {
        emit(WebLoadingState(true));
      },
    );
    on<OnPageStopLoading>(
      (event, emit) {
        emit(WebLoadingState(false));
      },
    );
  }
}
