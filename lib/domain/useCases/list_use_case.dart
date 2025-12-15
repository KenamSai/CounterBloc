import 'package:counterappblocpackg/data/models/list_item_request_model.dart';
import 'package:counterappblocpackg/data/models/list_item_response_model.dart';
import 'package:counterappblocpackg/domain/repository/list_view_repo.dart';

class ListUseCase {
  ListViewRepo repo;
  ListUseCase(this.repo);
  // call method with parameters if needed
  Future<List<ListItemResponseModel>> call({required ListItemRequestModel request}) async {
    return await repo.getListData(request: request);
  }
}
