import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    debugPrint("Before---------->> $state");
    emit(state + 1);
    debugPrint("After---------->> $state");
  }

  void decrement() {
    debugPrint("Before---------->> $state");
    if (state == 0) {
      return;
    }
    //emit() called only in cubit class
    emit(state - 1);
    debugPrint("After---------->> $state");
  }
}
