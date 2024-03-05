class CheckoutModelMart {
  bool? status;
  String? message;
  Data? data;

  CheckoutModelMart({this.status, this.message, this.data});

  CheckoutModelMart.fromJson(Map<String, dynamic> json) {
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
  List<CartItems>? cartItems;
  int? cartTotalItems;
  CartPaymentSummary? cartPaymentSummary;
  OrderAddress? orderAddress;

  Data(
      {this.cartItems,
        this.cartTotalItems,
        this.cartPaymentSummary,
        this.orderAddress});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    cartTotalItems = json['cartTotalItems'];
    cartPaymentSummary = json['cartPaymentSummary'] != null
        ? new CartPaymentSummary.fromJson(json['cartPaymentSummary'])
        : null;
    orderAddress = json['orderAddress'] != null
        ? new OrderAddress.fromJson(json['orderAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['cartTotalItems'] = this.cartTotalItems;
    if (this.cartPaymentSummary != null) {
      data['cartPaymentSummary'] = this.cartPaymentSummary!.toJson();
    }
    if (this.orderAddress != null) {
      data['orderAddress'] = this.orderAddress!.toJson();
    }
    return data;
  }
}

class CartItems {
  int? id;
  int? cartId;
  int? userId;
  Null? storeId;
  int? vendorProductVariantId;
  Null? productAddons;
  int? vendorProductId;
  int? qty;
  int? freeQty;
  int? isSelected;
  String? createdAt;
  String? updatedAt;

  CartItems(
      {this.id,
        this.cartId,
        this.userId,
        this.storeId,
        this.vendorProductVariantId,
        this.productAddons,
        this.vendorProductId,
        this.qty,
        this.freeQty,
        this.isSelected,
        this.createdAt,
        this.updatedAt});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    vendorProductVariantId = json['vendor_product_variant_id'];
    productAddons = json['product_addons'];
    vendorProductId = json['vendor_product_id'];
    qty = json['qty'];
    freeQty = json['free_qty'];
    isSelected = json['is_selected'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cart_id'] = this.cartId;
    data['user_id'] = this.userId;
    data['store_id'] = this.storeId;
    data['vendor_product_variant_id'] = this.vendorProductVariantId;
    data['product_addons'] = this.productAddons;
    data['vendor_product_id'] = this.vendorProductId;
    data['qty'] = this.qty;
    data['free_qty'] = this.freeQty;
    data['is_selected'] = this.isSelected;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CartPaymentSummary {
  double? adminCommission;
  int? subTotal;
  int? marketingPartnerCommission;
  String? driverCommission;
  String? freeDeliveryMinOrderValue;
  int? deliveryCharge;
  String? surCharge;
  int? tipAmount;
  String? packingFee;
  Null? tax1;
  Null? tax2;
  int? total;

  CartPaymentSummary(
      {this.adminCommission,
        this.subTotal,
        this.marketingPartnerCommission,
        this.driverCommission,
        this.freeDeliveryMinOrderValue,
        this.deliveryCharge,
        this.surCharge,
        this.tipAmount,
        this.packingFee,
        this.tax1,
        this.tax2,
        this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    adminCommission = json['adminCommission'];
    subTotal = json['subTotal'];
    marketingPartnerCommission = json['marketingPartnerCommission'];
    driverCommission = json['driver_commission'];
    freeDeliveryMinOrderValue = json['free_delivery_min_order_value'];
    deliveryCharge = json['deliveryCharge'];
    surCharge = json['surCharge'];
    tipAmount = json['tipAmount'];
    packingFee = json['packingFee'];
    tax1 = json['tax_1'];
    tax2 = json['tax_2'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminCommission'] = this.adminCommission;
    data['subTotal'] = this.subTotal;
    data['marketingPartnerCommission'] = this.marketingPartnerCommission;
    data['driver_commission'] = this.driverCommission;
    data['free_delivery_min_order_value'] = this.freeDeliveryMinOrderValue;
    data['deliveryCharge'] = this.deliveryCharge;
    data['surCharge'] = this.surCharge;
    data['tipAmount'] = this.tipAmount;
    data['packingFee'] = this.packingFee;
    data['tax_1'] = this.tax1;
    data['tax_2'] = this.tax2;
    data['total'] = this.total;
    return data;
  }
}

class OrderAddress {
  int? id;
  int? userId;
  String? latitude;
  String? longitude;
  String? location;
  String? flatNo;
  String? street;
  String? landmark;
  String? addressType;
  Null? recipientName;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  OrderAddress(
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

  OrderAddress.fromJson(Map<String, dynamic> json) {
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
