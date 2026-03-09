import 'package:counterappblocpackg/data/models/list_item_request_model.dart';
import 'package:counterappblocpackg/data/models/list_item_response_model.dart';
import 'package:counterappblocpackg/domain/useCases/list_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<FetchDataEvent, ListState> {
  ListBloc(ListUseCase listUseCase) : super(ListInitial()) {
    int itemSize = 5;
    on<FetchNextPage>(
      (event, emit) async {
        final currentState = state;

        if (currentState is! ListDataLoaded) return;
        emit(ListDataLoaded(currentState.list));
        await Future.delayed(const Duration(seconds: 2));
        try {
          final currentList = currentState.list;
          final currentLength = currentList.length;
          List<ListItemResponseModel> reasonList = await listUseCase(
            request: ListItemRequestModel(
              iStart: currentLength,
              iLimit: itemSize,
            ),
          );
          List<ListItemResponseModel> updatedList = [
            ...currentList,
            ...reasonList
          ];
          emit(
            ListDataLoaded(updatedList),
          );
        } catch (e) {
          print("--------$e");
          emit(
            ListDataError(
              e.toString(),
            ),
          );
        }
      },
    );
    on<GetListEvent>((event, emit) async {
      emit(ListInitial());
      try {
        List<ListItemResponseModel> reasonList = await listUseCase(
          request: ListItemRequestModel(
            iStart: 0,
            iLimit: itemSize,
          ),
        );
        emit(ListDataLoaded(reasonList));
      } catch (e) {
        print("--------$e");
        emit(
          ListDataError(
            e.toString(),
          ),
        );
      }
    });
    add(
      GetListEvent(),
    );
  }
}
