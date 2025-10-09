import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<CounterIncrementPressed>((event, emit) {
      final currentCount =
          state is CounterLoaded ? (state as CounterLoaded).count : 0;
      emit(CounterLoaded(currentCount + 1));
    });
    on<CounterDecrementPressed>((event, emit) {
      final currentCount =
          state is CounterLoaded ? (state as CounterLoaded).count : 0;
      if (currentCount > 0) {
        emit(CounterLoaded(currentCount - 1));
      } else {
        emit(CounterError("Hey Number cannot be less than zero!!!"));
      }
    });
  }
}
