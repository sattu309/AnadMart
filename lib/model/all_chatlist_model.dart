class AllChatLIstModel {
  bool? status;
  String? message;
  List<Data>? data;

  AllChatLIstModel({this.status, this.message, this.data});

  AllChatLIstModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic message;
  dynamic userId;
  dynamic time;

  Data({this.id, this.message, this.userId, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    userId = json['user_id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['time'] = this.time;
    return data;
  }
}
