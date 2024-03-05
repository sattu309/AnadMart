class SingleAddressModel {
  bool? status;
  String? message;
  Data? data;

  SingleAddressModel({this.status, this.message, this.data});

  SingleAddressModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? address1;
  String? address2;
  String? city;
  String? state;
  int? zipCode;
  String? addressType;
  String? otherInstruction;

  Data(
      {this.id,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zipCode,
        this.addressType,
        this.otherInstruction});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    addressType = json['address_type'];
    otherInstruction = json['other_instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['address_type'] = this.addressType;
    data['other_instruction'] = this.otherInstruction;
    return data;
  }
}
