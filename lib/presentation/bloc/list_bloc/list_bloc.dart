import 'package:counterappblocpackg/data/models/list_request_model.dart';
import 'package:counterappblocpackg/domain/entity/reason_entity.dart';
import 'package:counterappblocpackg/domain/useCases/list_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<FetchDataEvent, ListState> {
  ListBloc(ListUseCase listUseCase) : super(ListInitial()) {
    on<GetListEvent>((event, emit) async {
      emit(ListInitial());
      try {
        List<ReasonEntity> reasonList = await listUseCase(
          request: event.request,
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
      GetListEvent(
        ReasonRequest(
          sessionToken: "9479e7ee1352951896963c344ae46261",
          userId: "7036266270",
          webServiceName: "getReasons",
        ),
      ),
    );
  }
}
