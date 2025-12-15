import 'package:counterappblocpackg/core/network/base_api_client.dart';
import 'package:counterappblocpackg/data/models/list_item_request_model.dart';
import 'package:counterappblocpackg/data/models/list_item_response_model.dart';
import 'package:flutter/foundation.dart';

/// Top-level function to parse the 'data' list
List<ListItemResponseModel> parseReasonList(List<dynamic> data) {
  return data.map((e) => ListItemResponseModel.fromJson(e)).toList();
}

class ListDataSource {
  final BaseApiClient dio;
  ListDataSource(this.dio);

  /// Makes API call and parses the response
  Future<List<ListItemResponseModel>> getData({
    required String endURL,
    required ListItemRequestModel body,
  }) async {
    final response = await dio.getCall(
      endURL: endURL,
      body: body.toJson(),
    );
    final list = response as List<dynamic>;
    // Offload heavy list parsing to background isolate
    final parsedList =
        await compute<List<dynamic>, List<ListItemResponseModel>>(
      parseReasonList,
      list,
    );
    return parsedList;
  }
}
