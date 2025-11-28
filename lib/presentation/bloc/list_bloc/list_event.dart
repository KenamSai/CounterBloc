part of 'list_bloc.dart';

sealed class FetchDataEvent {}

final class GetListEvent extends FetchDataEvent {
  ReasonRequest request;
  GetListEvent(this.request);
}
