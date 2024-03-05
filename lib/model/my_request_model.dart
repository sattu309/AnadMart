class MyRequestModel {
  bool? status;
  String? message;
  Data? data;

  MyRequestModel({this.status, this.message, this.data});

  MyRequestModel.fromJson(Map<String, dynamic> json) {
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
  List<SupportTicketData>? supportTicketData;

  Data({this.supportTicketData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['support_ticket_data'] != null) {
      supportTicketData = <SupportTicketData>[];
      json['support_ticket_data'].forEach((v) {
        supportTicketData!.add(new SupportTicketData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supportTicketData != null) {
      data['support_ticket_data'] =
          this.supportTicketData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportTicketData {
  int? id;
  int? contactReasonId;
  String? contactReason;
  String? status;
  String? createdAt;

  SupportTicketData(
      {this.id,
        this.contactReasonId,
        this.contactReason,
        this.status,
        this.createdAt});

  SupportTicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactReasonId = json['contact_reason_id'];
    contactReason = json['contact_reason'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_reason_id'] = this.contactReasonId;
    data['contact_reason'] = this.contactReason;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}
