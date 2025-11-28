import 'package:counterappblocpackg/core/network/base_api_client.dart';
import 'package:counterappblocpackg/data/models/list_request_model.dart';
import 'package:counterappblocpackg/data/models/list_view_model.dart';
import 'package:flutter/foundation.dart';

/// Top-level function to parse the 'data' list
List<ReasonModel> parseReasonList(List< dynamic> data) {
  //final data = json['data'] as List<dynamic>? ?? [];
  return data.map((e) => ReasonModel.fromJson(e)).toList();
}

class ListDataSource {
  final BaseApiClient dio;
  ListDataSource(this.dio);

  /// Makes API call and parses the response
  Future<ReasonListModel> getData({
    required String endURL,
    required ReasonRequest body,
  }) async {
    final response = await dio.postCall(
      endURL: endURL,
      body: body.toJson(),
    );
    // Offload heavy list parsing to background isolate
    final parsedList =
        await compute<List< dynamic>, List<ReasonModel>>(
      parseReasonList,
      response['data'],
    );
    final reasonListModel = ReasonListModel(
      data: parsedList,
      paginated: response['paginated'],
      statusCode: response['status_Code'],
      statusMessage: response['status_Message'],
      success: response['success'],
    );
    return reasonListModel;
  }
}
