import 'package:counterappblocpackg/core/constants/api_constants.dart';
import 'package:counterappblocpackg/data/data_source/list_data_source.dart';
import 'package:counterappblocpackg/data/models/list_request_model.dart';
import 'package:counterappblocpackg/data/models/list_view_model.dart';
import 'package:counterappblocpackg/domain/entity/reason_entity.dart';
import 'package:counterappblocpackg/domain/repository/list_view_repo.dart';

//decides where data to get
class ListViewRepoImpl implements ListViewRepo {
  final ListDataSource listDataSource;
  ListViewRepoImpl(this.listDataSource);
  @override
  Future<List<ReasonEntity>> getListData({
    required ReasonRequest request,
  }) async {
    // Call datasource
    final ReasonListModel response = await listDataSource.getData(
      endURL: ApiConstants.getListData,
      body: request,
    );

    // Check API-level status
    if (response.statusCode != 200 || response.success != true) {
      final message = response.statusMessage ?? "Something went wrong";
      throw Exception("API Error: $message (code: ${response.statusCode})");
    }

    // If data is empty
    final dataList = response.data ?? [];
    if (dataList.isEmpty) {
      throw Exception("No Data found"); // Return empty list instead of throwing
    }

    // Convert to entity
    return response.toEntityList();
  }
}
