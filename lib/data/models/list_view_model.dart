import 'package:counterappblocpackg/domain/entity/reason_entity.dart';

class ReasonListModel {
  bool? success;
  String? statusMessage;
  int? statusCode;
  List<ReasonModel>? data;
  bool? paginated;

  ReasonListModel(
      {this.success,
      this.statusMessage,
      this.statusCode,
      this.data,
      this.paginated});

  ReasonListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    if (json['data'] != null) {
      data = <ReasonModel>[];
      json['data'].forEach((v) {
        data!.add(ReasonModel.fromJson(v));
      });
    }
    paginated = json['paginated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_Message'] = statusMessage;
    data['status_Code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['paginated'] = paginated;
    return data;
  }

  List<ReasonEntity> toEntityList() {
    return (data ?? []).map((model) => model.toEntity()).toList();
  }
}

class ReasonModel {
  String? reasonID;
  String? reason;
  String? isActive;

  ReasonModel({this.reasonID, this.reason, this.isActive});

  ReasonModel.fromJson(Map<String, dynamic> json) {
    reasonID = json['reasonID'];
    reason = json['reason'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reasonID'] = reasonID;
    data['reason'] = reason;
    data['is_active'] = isActive;
    return data;
  }

  ReasonEntity toEntity() {
    return ReasonEntity(
      id: reasonID ?? "",
      reason: reason ?? "",
      isActive: (isActive ?? "f").toLowerCase() == 't',
    );
  }
}
