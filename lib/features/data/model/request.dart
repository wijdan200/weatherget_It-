class Request {
  String? query;
  String? type;

  Request({this.query, this.type});

  Request.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['type'] = type;
    return data;
  }
}