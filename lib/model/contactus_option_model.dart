class ContactUsOptionModel {
  bool? status;
  String? message;
  Data? data;

  ContactUsOptionModel({this.status, this.message, this.data});

  ContactUsOptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Reasons>? reasons;

  Data({this.reasons});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['reasons'] != null) {
      reasons = <Reasons>[];
      json['reasons'].forEach((v) {
        reasons!.add(new Reasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reasons != null) {
      data['reasons'] = this.reasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reasons {
  int? id;
  String? title;

  Reasons({this.id, this.title});

  Reasons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
