class ReasonRequest {
  String? sessionToken;
  String? userId;
  String? webServiceName;

  ReasonRequest({this.sessionToken, this.userId, this.webServiceName});

  ReasonRequest.fromJson(Map<String, dynamic> json) {
    sessionToken = json['sessionToken'];
    userId = json['userId'];
    webServiceName = json['webServiceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sessionToken'] = sessionToken;
    data['userId'] = userId;
    data['webServiceName'] = webServiceName;
    return data;
  }
}
