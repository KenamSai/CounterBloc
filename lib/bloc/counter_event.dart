part of 'counter_bloc.dart';

//super class
sealed class CounterEvent {}

//event
final class CounterIncrement extends CounterEvent {}

final class CounterDecrement extends CounterEvent {}
