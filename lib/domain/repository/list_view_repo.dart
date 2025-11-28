import 'package:counterappblocpackg/data/models/list_request_model.dart';
import 'package:counterappblocpackg/domain/entity/reason_entity.dart';

abstract class ListViewRepo {
  Future<List<ReasonEntity>> getListData({required ReasonRequest request});
}
