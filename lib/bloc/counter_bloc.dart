import 'package:flutter_bloc/flutter_bloc.dart';
part 'counter_event.dart'; // so that final child classes like increment which are final can be extended

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrement>((event, emit) {
      emit(state + 1);
    });
    on<CounterDecrement>((event, emit) {
      if (state == 0) {
        return;
      }

      emit(state - 1);
    });
  }
}
