part of 'list_bloc.dart';

@immutable
sealed class ListState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ListInitial extends ListState {}

final class ListDataLoaded extends ListState {
  final List<ListItemResponseModel> list;
  ListDataLoaded(this.list);
  @override
  List<Object> get props => [list];
}

final class ListDataError extends ListState {
  final String message;
  ListDataError(this.message);
  @override
  List<Object> get props => [message];
}
