part of 'counter_bloc.dart';

@immutable
sealed class CounterState extends Equatable {
  @override
  List<Object> get props => [];
}

final class CounterInitial extends CounterState {}

final class CounterLoaded extends CounterState {
  final int count;
  CounterLoaded(this.count);
  @override
  List<Object> get props => [count];
}

final class CounterError extends CounterState {
  final String message;
  CounterError(this.message);
}
