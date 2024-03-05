class OrderDetailsModel {
  bool? status;
  String? message;
  Data? data;

  OrderDetailsModel({this.status, this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic orderId;
  dynamic itemTotal;
  dynamic surcharge;
  dynamic tax;
  dynamic tax1;
  dynamic tax2;
  dynamic deliveryCharges;
  dynamic packingFee;
  dynamic tipAmount;
  dynamic couponDiscount;
  dynamic commissionDriver;
  dynamic commissionAdmin;
  dynamic grandTotal;
  User? user;
  dynamic vendor;
  dynamic driver;
  Address? address;
  dynamic orderType;
  dynamic deliveryStatus;
  List<OrderItems>? orderItems;
  dynamic invoice;
  dynamic placedAt;

  Data(
      {this.orderId,
        this.itemTotal,
        this.surcharge,
        this.tax,
        this.tax1,
        this.tax2,
        this.deliveryCharges,
        this.packingFee,
        this.tipAmount,
        this.couponDiscount,
        this.commissionDriver,
        this.commissionAdmin,
        this.grandTotal,
        this.user,
        this.vendor,
        this.driver,
        this.address,
        this.orderType,
        this.deliveryStatus,
        this.orderItems,
        this.invoice,
        this.placedAt});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    itemTotal = json['item_total'];
    surcharge = json['surcharge'];
    tax = json['tax'];
    tax1 = json['tax_1'];
    tax2 = json['tax_2'];
    deliveryCharges = json['delivery_charges'];
    packingFee = json['packing_fee'];
    tipAmount = json['tip_amount'];
    couponDiscount = json['coupon_discount'];
    commissionDriver = json['commission_driver'];
    commissionAdmin = json['commission_admin'];
    grandTotal = json['grand_total'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    vendor = json['vendor'];
    driver = json['driver'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    orderType = json['order_type'];
    deliveryStatus = json['delivery_status'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    invoice = json['invoice'];
    placedAt = json['placed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['item_total'] = this.itemTotal;
    data['surcharge'] = this.surcharge;
    data['tax'] = this.tax;
    data['tax_1'] = this.tax1;
    data['tax_2'] = this.tax2;
    data['delivery_charges'] = this.deliveryCharges;
    data['packing_fee'] = this.packingFee;
    data['tip_amount'] = this.tipAmount;
    data['coupon_discount'] = this.couponDiscount;
    data['commission_driver'] = this.commissionDriver;
    data['commission_admin'] = this.commissionAdmin;
    data['grand_total'] = this.grandTotal;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['vendor'] = this.vendor;
    data['driver'] = this.driver;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['order_type'] = this.orderType;
    data['delivery_status'] = this.deliveryStatus;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['invoice'] = this.invoice;
    data['placed_at'] = this.placedAt;
    return data;
  }
}

class User {
  dynamic id;
  bool? isDriver;
  bool? isVendor;
  bool? isMarketingManager;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic phone;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic profileImage;
  dynamic referalCode;
  bool? isDriverOnline;
  bool? isVendorOnline;
  dynamic deliveryRange;
  bool? selfDelivery;
  bool? asDriverVerified;
  bool? asVendorVerified;
  bool? asMarketingManagerVerified;
  bool? isProfileComplete;

  User(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.isMarketingManager,
        this.latitude,
        this.longitude,
        this.location,
        this.firstName,
        this.middleName,
        this.lastName,
        this.email,
        this.phone,
        this.walletBalance,
        this.earnedBalance,
        this.profileImage,
        this.referalCode,
        this.isDriverOnline,
        this.isVendorOnline,
        this.deliveryRange,
        this.selfDelivery,
        this.asDriverVerified,
        this.asVendorVerified,
        this.asMarketingManagerVerified,
        this.isProfileComplete});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    isMarketingManager = json['is_marketing_manager'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    profileImage = json['profile_image'];
    referalCode = json['referal_code'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    asMarketingManagerVerified = json['as_marketing_manager_verified'];
    isProfileComplete = json['is_profile_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['is_marketing_manager'] = this.isMarketingManager;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['profile_image'] = this.profileImage;
    data['referal_code'] = this.referalCode;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['as_marketing_manager_verified'] = this.asMarketingManagerVerified;
    data['is_profile_complete'] = this.isProfileComplete;
    return data;
  }
}

class Address {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic flatNo;
  dynamic street;
  dynamic landmark;
  dynamic addressType;
  dynamic recipientName;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Address(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.flatNo,
        this.street,
        this.landmark,
        this.addressType,
        this.recipientName,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    flatNo = json['flat_no'];
    street = json['street'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    recipientName = json['recipient_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['flat_no'] = this.flatNo;
    data['street'] = this.street;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['recipient_name'] = this.recipientName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class OrderItems {
  dynamic id;
  dynamic productId;
  dynamic productName;
  dynamic productImage;
  dynamic variantId;
  dynamic price;
  dynamic itemQty;
  bool? feedback;
  dynamic qty;
  dynamic totalPrice;
  dynamic status;

  OrderItems(
      {this.id,
        this.productId,
        this.productName,
        this.productImage,
        this.variantId,
        this.price,
        this.feedback,
        this.itemQty,
        this.qty,
        this.totalPrice,
        this.status});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    variantId = json['variant_id'];
    price = json['price'];
    feedback = json['feedback'];
    itemQty = json['item_qty'];
    qty = json['qty'];
    totalPrice = json['total_price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['variant_id'] = this.variantId;
    data['price'] = this.price;
    data['item_qty'] = this.itemQty;
    data['qty'] = this.qty;
    data['feedback'] = this.feedback;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    return data;
  }
}
