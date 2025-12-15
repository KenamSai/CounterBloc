class ListItemRequestModel {
  int? iStart;
  int? iLimit;

  ListItemRequestModel({this.iStart, this.iLimit});

  ListItemRequestModel.fromJson(Map<String, dynamic> json) {
    iStart = json['_start'];
    iLimit = json['_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_start'] = iStart;
    data['_limit'] = iLimit;
    return data;
  }
}
