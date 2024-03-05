class SupportModel {
  bool? status;
  String? message;
  Data? data;

  SupportModel({this.status, this.message, this.data});

  SupportModel.fromJson(Map<String, dynamic> json) {
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
  String? mobileNumber;
  String? landlineNumber;
  String? email;
  String? whatsappNumber;

  Data(
      {this.mobileNumber,
        this.landlineNumber,
        this.email,
        this.whatsappNumber});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    landlineNumber = json['landlineNumber'];
    email = json['email'];
    whatsappNumber = json['whatsappNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['landlineNumber'] = this.landlineNumber;
    data['email'] = this.email;
    data['whatsappNumber'] = this.whatsappNumber;
    return data;
  }
}
