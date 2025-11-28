import 'package:counterappblocpackg/data/models/list_request_model.dart';
import 'package:counterappblocpackg/domain/entity/reason_entity.dart';
import 'package:counterappblocpackg/domain/repository/list_view_repo.dart';

class ListUseCase {
  ListViewRepo repo;
  ListUseCase(this.repo);
  // call method with parameters if needed
  Future<List<ReasonEntity>> call({required ReasonRequest request}) async {
    return await repo.getListData(request: request);
  }
}
