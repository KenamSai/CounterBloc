part of 'list_bloc.dart';

sealed class FetchDataEvent {}

final class GetListEvent extends FetchDataEvent {}

final class FetchNextPage extends FetchDataEvent {}
