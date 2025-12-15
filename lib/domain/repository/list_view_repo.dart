import 'package:counterappblocpackg/data/models/list_item_request_model.dart';
import 'package:counterappblocpackg/data/models/list_item_response_model.dart';

abstract class ListViewRepo {
  Future<List<ListItemResponseModel>> getListData({required ListItemRequestModel request});
}
