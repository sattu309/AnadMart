class MyOrdersMart {
  bool? status;
  String? message;
  List<Data>? data;

  MyOrdersMart({this.status, this.message, this.data});

  MyOrdersMart.fromJson(Map<String, dynamic> json) {
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
  dynamic itemCount;
  List<OrderItems>? orderItems;
  dynamic image;
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
        this.itemCount,
        this.orderItems,
        this.image,
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
    itemCount = json['item_count'];
    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    image = json['image'];
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
    data['item_count'] = this.itemCount;
    if (this.orderItems != null) {
      data['order_items'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['placed_at'] = this.placedAt;
    return data;
  }
}

class User {
  dynamic id;
  dynamic isDriver;
  dynamic isVendor;
  dynamic isMarketingManager;
  dynamic marketingBalance;
  dynamic walletBalance;
  dynamic earnedBalance;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic phone;
  dynamic email;
  dynamic otp;
  dynamic otpCreatedAt;
  dynamic otpVerified;
  dynamic profileImage;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic defaultAddress;
  dynamic referalCode;
  dynamic deviceToken;
  dynamic deviceId;
  dynamic isDriverOnline;
  dynamic isVendorOnline;
  dynamic deliveryRange;
  dynamic selfDelivery;
  dynamic adminCommissionType;
  dynamic adminCommission;
  dynamic asDriverVerified;
  dynamic asVendorVerified;
  dynamic asMarketingManagerVerified;
  dynamic featuredStore;
  dynamic emailVerifiedAt;
  dynamic status;
  dynamic isProfileComplete;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  User(
      {this.id,
        this.isDriver,
        this.isVendor,
        this.isMarketingManager,
        this.marketingBalance,
        this.walletBalance,
        this.earnedBalance,
        this.firstName,
        this.middleName,
        this.lastName,
        this.phone,
        this.email,
        this.otp,
        this.otpCreatedAt,
        this.otpVerified,
        this.profileImage,
        this.latitude,
        this.longitude,
        this.location,
        this.defaultAddress,
        this.referalCode,
        this.deviceToken,
        this.deviceId,
        this.isDriverOnline,
        this.isVendorOnline,
        this.deliveryRange,
        this.selfDelivery,
        this.adminCommissionType,
        this.adminCommission,
        this.asDriverVerified,
        this.asVendorVerified,
        this.asMarketingManagerVerified,
        this.featuredStore,
        this.emailVerifiedAt,
        this.status,
        this.isProfileComplete,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isDriver = json['is_driver'];
    isVendor = json['is_vendor'];
    isMarketingManager = json['is_marketing_manager'];
    marketingBalance = json['marketing_balance'];
    walletBalance = json['wallet_balance'];
    earnedBalance = json['earned_balance'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'];
    otpCreatedAt = json['otp_created_at'];
    otpVerified = json['otp_verified'];
    profileImage = json['profile_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    defaultAddress = json['default_address'];
    referalCode = json['referal_code'];
    deviceToken = json['device_token'];
    deviceId = json['device_id'];
    isDriverOnline = json['is_driver_online'];
    isVendorOnline = json['is_vendor_online'];
    deliveryRange = json['delivery_range'];
    selfDelivery = json['self_delivery'];
    adminCommissionType = json['admin_commission_type'];
    adminCommission = json['admin_commission'];
    asDriverVerified = json['as_driver_verified'];
    asVendorVerified = json['as_vendor_verified'];
    asMarketingManagerVerified = json['as_marketing_manager_verified'];
    featuredStore = json['featured_store'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    isProfileComplete = json['is_profile_complete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_driver'] = this.isDriver;
    data['is_vendor'] = this.isVendor;
    data['is_marketing_manager'] = this.isMarketingManager;
    data['marketing_balance'] = this.marketingBalance;
    data['wallet_balance'] = this.walletBalance;
    data['earned_balance'] = this.earnedBalance;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['otp_created_at'] = this.otpCreatedAt;
    data['otp_verified'] = this.otpVerified;
    data['profile_image'] = this.profileImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['default_address'] = this.defaultAddress;
    data['referal_code'] = this.referalCode;
    data['device_token'] = this.deviceToken;
    data['device_id'] = this.deviceId;
    data['is_driver_online'] = this.isDriverOnline;
    data['is_vendor_online'] = this.isVendorOnline;
    data['delivery_range'] = this.deliveryRange;
    data['self_delivery'] = this.selfDelivery;
    data['admin_commission_type'] = this.adminCommissionType;
    data['admin_commission'] = this.adminCommission;
    data['as_driver_verified'] = this.asDriverVerified;
    data['as_vendor_verified'] = this.asVendorVerified;
    data['as_marketing_manager_verified'] = this.asMarketingManagerVerified;
    data['featured_store'] = this.featuredStore;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['is_profile_complete'] = this.isProfileComplete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
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
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    return data;
  }
}
