import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit({required int initialState}) : super(initialState);
  void increment() {
    addError(Exception("Error----"),StackTrace.current);
    emit(state + 1);
  }

  void decrement() {
    if (state >= 1) {
      emit(state - 1);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("error ---$error, ---- $stackTrace");
  }
  // @override
  // void onChange(Change<int> change) {
  //   super.onChange(change);
  //   print(change);
  // }
}
