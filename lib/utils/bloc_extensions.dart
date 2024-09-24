import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocSafety<Event, State> on Bloc<Event, State> {
  void emitSafely(State state) {
    if (!isClosed) {
      emit(state);
    }
  }
}

extension CubitSafety<State> on Cubit<State> {
  void emitSafely(Emitter<State> emit) {
    if (!isClosed) {
      emit(state);
    }
  }
}
