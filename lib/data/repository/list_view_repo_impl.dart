import 'package:counterappblocpackg/core/constants/api_constants.dart';
import 'package:counterappblocpackg/data/data_source/list_data_source.dart';
import 'package:counterappblocpackg/data/models/list_item_request_model.dart';
import 'package:counterappblocpackg/data/models/list_item_response_model.dart';
import 'package:counterappblocpackg/domain/repository/list_view_repo.dart';

//decides where data to get
class ListViewRepoImpl implements ListViewRepo {
  final ListDataSource listDataSource;
  ListViewRepoImpl(this.listDataSource);
  @override
  Future<List<ListItemResponseModel>> getListData({
    required ListItemRequestModel request,
  }) async {
    // Call datasource
    List<ListItemResponseModel> response = await listDataSource.getData(
      endURL: ApiConstants.posts,
      body: request,
    );
    return response;
    // // Check API-level status
    // if (response.statusCode != 200 || response.success != true) {
    //   final message = response.statusMessage ?? "Something went wrong";
    //   throw Exception("API Error: $message (code: ${response.statusCode})");
    // }

    // // If data is empty
    // final dataList = response.data ?? [];
    // if (dataList.isEmpty) {
    //   throw Exception("No Data found"); // Return empty list instead of throwing
    // }

    // Convert to entity
    //return response.toEntityList();
  }
}
