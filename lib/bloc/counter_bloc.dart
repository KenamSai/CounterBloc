import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

sealed class CounterEvent {}

final class IncrementPressed extends CounterEvent {}

final class DecrementPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    //Event handler
    on<IncrementPressed>((event, emit) {
      // addError("Error Occured bro-----");
      emit(state + 1);
    }, 
    // transformer: (events, mapper) {
    //   return events
    //       .doOnData((event) => print("Event: $mapper"))
    //       .debounceTime(const Duration(seconds: 1))
    //       .flatMap(mapper);
    // }
    );

    on<DecrementPressed>((event, emit) {
      emit(state - 1);
    });
  }
  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print("$transition");
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print("Locall********");
    super.onError(error, stackTrace);
  }
}
