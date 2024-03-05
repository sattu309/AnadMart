// // class MyCartData {
// //   bool? status;
// //   dynamic message;
// //   Data? data;
// //
// //   MyCartData({this.status, this.message, this.data});
// //
// //   MyCartData.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     message = json['message'];
// //     data = json['data'] != null ? Data.fromJson(json['data']) : null;
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['status'] = status;
// //     data['message'] = message;
// //     if (this.data != null) {
// //       data['data'] = this.data!.toJson();
// //     }
// //     return data;
// //   }
// // }
// //
// // class Data {
// //   List<CartItems>? cartItems;
// //   CartPaymentSummary? cartPaymentSummary;
// //   OrderAddress? orderAddress;
// //
// //   Data({this.cartItems, this.cartPaymentSummary, this.orderAddress});
// //
// //   Data.fromJson(Map<String, dynamic> json) {
// //     if (json['cartItems'] != null) {
// //       cartItems = <CartItems>[];
// //       json['cartItems'].forEach((v) {
// //         cartItems!.add(CartItems.fromJson(v));
// //       });
// //     }
// //     cartPaymentSummary = json['cartPaymentSummary'] != null
// //         ? CartPaymentSummary.fromJson(json['cartPaymentSummary'])
// //         : null;
// //     orderAddress = json['orderAddress'] != null
// //         ? OrderAddress.fromJson(json['orderAddress'])
// //         : null;
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     if (cartItems != null) {
// //       data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
// //     }
// //     if (cartPaymentSummary != null) {
// //       data['cartPaymentSummary'] = cartPaymentSummary!.toJson();
// //     }
// //     if (orderAddress != null) {
// //       data['orderAddress'] = orderAddress!.toJson();
// //     }
// //     return data;
// //   }
// // }
// //
// // class CartItems {
// //   dynamic id;
// //   dynamic productId;
// //   dynamic variantId;
// //   dynamic name;
// //   dynamic variantQty;
// //   dynamic variantQtyType;
// //   dynamic variantPrice;
// //   dynamic cartItemQty;
// //   dynamic minQty;
// //   dynamic maxQty;
// //   dynamic totalPrice;
// //   dynamic image;
// //
// //   CartItems(
// //       {this.id,
// //         this.productId,
// //         this.variantId,
// //         this.name,
// //         this.variantQty,
// //         this.variantQtyType,
// //         this.variantPrice,
// //         this.cartItemQty,
// //         this.minQty,
// //         this.maxQty,
// //         this.totalPrice,
// //         this.image});
// //
// //   CartItems.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     productId = json['product_id'];
// //     variantId = json['variant_id'];
// //     name = json['name'];
// //     variantQty = json['variant_qty'];
// //     variantQtyType = json['variant_qty_type'];
// //     variantPrice = json['variant_price'];
// //     cartItemQty = json['cart_item_qty'];
// //     minQty = json['min_qty'];
// //     maxQty = json['max_qty'];
// //     totalPrice = json['total_price'];
// //     image = json['image'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['id'] = id;
// //     data['product_id'] = productId;
// //     data['variant_id'] = variantId;
// //     data['name'] = name;
// //     data['variant_qty'] = variantQty;
// //     data['variant_qty_type'] = variantQtyType;
// //     data['variant_price'] = variantPrice;
// //     data['cart_item_qty'] = cartItemQty;
// //     data['min_qty'] = minQty;
// //     data['max_qty'] = maxQty;
// //     data['total_price'] = totalPrice;
// //     data['image'] = image;
// //     return data;
// //   }
// // }
// //
// // class CartPaymentSummary {
// //   dynamic subTotal;
// //   dynamic couponDiscount;
// //   dynamic couponCode;
// //   dynamic deliveryCharge;
// //   dynamic surCharge;
// //   dynamic tipAmount;
// //   dynamic packingFee;
// //   dynamic taxAndFee;
// //   dynamic total;
// //
// //   CartPaymentSummary(
// //       {this.subTotal,
// //         this.couponDiscount,
// //         this.couponCode,
// //         this.deliveryCharge,
// //         this.surCharge,
// //         this.tipAmount,
// //         this.packingFee,
// //         this.taxAndFee,
// //         this.total});
// //
// //   CartPaymentSummary.fromJson(Map<String, dynamic> json) {
// //     subTotal = json['subTotal'];
// //     couponDiscount = json['couponDiscount'];
// //     couponCode = json['couponCode'];
// //     deliveryCharge = json['deliveryCharge'];
// //     surCharge = json['surCharge'];
// //     tipAmount = json['tipAmount'];
// //     packingFee = json['packingFee'];
// //     taxAndFee = json['taxAndFee'];
// //     total = json['total'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['subTotal'] = subTotal;
// //     data['couponDiscount'] = couponDiscount;
// //     data['couponCode'] = couponCode;
// //     data['deliveryCharge'] = deliveryCharge;
// //     data['surCharge'] = surCharge;
// //     data['tipAmount'] = tipAmount;
// //     data['packingFee'] = packingFee;
// //     data['taxAndFee'] = taxAndFee;
// //     data['total'] = total;
// //     return data;
// //   }
// // }
// //
// // class OrderAddress {
// //   dynamic id;
// //   dynamic userId;
// //   dynamic latitude;
// //   dynamic longitude;
// //   dynamic location;
// //   dynamic flatNo;
// //   dynamic street;
// //   dynamic landmark;
// //   dynamic addressType;
// //   dynamic createdAt;
// //   dynamic updatedAt;
// //   dynamic deletedAt;
// //
// //   OrderAddress(
// //       {this.id,
// //         this.userId,
// //         this.latitude,
// //         this.longitude,
// //         this.location,
// //         this.flatNo,
// //         this.street,
// //         this.landmark,
// //         this.addressType,
// //         this.createdAt,
// //         this.updatedAt,
// //         this.deletedAt});
// //
// //   OrderAddress.fromJson(Map<String, dynamic> json) {
// //     id = json['id'];
// //     userId = json['user_id'];
// //     latitude = json['latitude'];
// //     longitude = json['longitude'];
// //     location = json['location'];
// //     flatNo = json['flat_no'];
// //     street = json['street'];
// //     landmark = json['landmark'];
// //     addressType = json['address_type'];
// //     createdAt = json['created_at'];
// //     updatedAt = json['updated_at'];
// //     deletedAt = json['deleted_at'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['id'] = id;
// //     data['user_id'] = userId;
// //     data['latitude'] = latitude;
// //     data['longitude'] = longitude;
// //     data['location'] = location;
// //     data['flat_no'] = flatNo;
// //     data['street'] = street;
// //     data['landmark'] = landmark;
// //     data['address_type'] = addressType;
// //     data['created_at'] = createdAt;
// //     data['updated_at'] = updatedAt;
// //     data['deleted_at'] = deletedAt;
// //     return data;
// //   }
// // }
//
//
// // fresh2
// class MyCartData {
//   bool? status;
//   dynamic message;
//   Data? data;
//
//   MyCartData({this.status, this.message, this.data});
//
//   MyCartData.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<CartItems>? cartItems;
//   CartPaymentSummary? cartPaymentSummary;
//   OrderAddress? orderAddress;
//
//   Data({this.cartItems, this.cartPaymentSummary, this.orderAddress});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['cartItems'] != null) {
//       cartItems = <CartItems>[];
//       json['cartItems'].forEach((v) {
//         cartItems!.add(new CartItems.fromJson(v));
//       });
//     }
//     cartPaymentSummary = json['cartPaymentSummary'] != null
//         ? new CartPaymentSummary.fromJson(json['cartPaymentSummary'])
//         : null;
//     orderAddress = json['orderAddress'] != null
//         ? new OrderAddress.fromJson(json['orderAddress'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.cartItems != null) {
//       data['cartItems'] = this.cartItems!.map((v) => v.toJson()).toList();
//     }
//     if (this.cartPaymentSummary != null) {
//       data['cartPaymentSummary'] = this.cartPaymentSummary!.toJson();
//     }
//     if (this.orderAddress != null) {
//       data['orderAddress'] = this.orderAddress!.toJson();
//     }
//     return data;
//   }
// }
//
// class CartItems {
//   dynamic id;
//   dynamic productId;
//   dynamic variantId;
//   dynamic name;
//   dynamic variantQty;
//   dynamic variantQtyType;
//   dynamic minQty;
//   dynamic maxQty;
//   dynamic variantPrice;
//   dynamic cartItemQty;
//   dynamic totalPrice;
//   dynamic image;
//
//   CartItems(
//       {this.id,
//         this.productId,
//         this.variantId,
//         this.name,
//         this.variantQty,
//         this.variantQtyType,
//         this.minQty,
//         this.maxQty,
//         this.variantPrice,
//         this.cartItemQty,
//         this.totalPrice,
//         this.image});
//
//   CartItems.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     productId = json['product_id'];
//     variantId = json['variant_id'];
//     name = json['name'];
//     variantQty = json['variant_qty'];
//     variantQtyType = json['variant_qty_type'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     variantPrice = json['variant_price'];
//     cartItemQty = json['cart_item_qty'];
//     totalPrice = json['total_price'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['variant_id'] = this.variantId;
//     data['name'] = this.name;
//     data['variant_qty'] = this.variantQty;
//     data['variant_qty_type'] = this.variantQtyType;
//     data['min_qty'] = this.minQty;
//     data['max_qty'] = this.maxQty;
//     data['variant_price'] = this.variantPrice;
//     data['cart_item_qty'] = this.cartItemQty;
//     data['total_price'] = this.totalPrice;
//     data['image'] = this.image;
//     return data;
//   }
// }
//
// class CartPaymentSummary {
//   dynamic adminCommisssion;
//   dynamic subTotal;
//   dynamic couponDiscount;
//   dynamic couponCode;
//   dynamic deliveryCharge;
//   dynamic surCharge;
//   dynamic tipAmount;
//   dynamic packingFee;
//   dynamic taxAndFee;
//   dynamic free_delivery_min_order_value;
//   Tax1? tax1;
//   Tax2? tax2;
//   dynamic total;
//
//   CartPaymentSummary(
//       {this.adminCommisssion,
//         this.subTotal,
//         this.couponDiscount,
//         this.couponCode,
//         this.deliveryCharge,
//         this.surCharge,
//         this.tipAmount,
//         this.packingFee,
//         this.taxAndFee,
//         this.free_delivery_min_order_value,
//         this.tax1,
//         this.tax2,
//         this.total});
//
//   CartPaymentSummary.fromJson(Map<String, dynamic> json) {
//     adminCommisssion = json['adminCommisssion'];
//     subTotal = json['subTotal'];
//     couponDiscount = json['couponDiscount'];
//     couponCode = json['couponCode'];
//     deliveryCharge = json['deliveryCharge'];
//     free_delivery_min_order_value = json['free_delivery_min_order_value'];
//     surCharge = json['surCharge'];
//     tipAmount = json['tipAmount'];
//     packingFee = json['packingFee'];
//     taxAndFee = json['taxAndFee'];
//     tax1 = json['tax_1'] != null ? new Tax1.fromJson(json['tax_1']) : null;
//     tax2 = json['tax_2'] != null ? new Tax2.fromJson(json['tax_2']) : null;
//     total = json['total'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['adminCommisssion'] = this.adminCommisssion;
//     data['subTotal'] = this.subTotal;
//     data['couponDiscount'] = this.couponDiscount;
//     data['couponCode'] = this.couponCode;
//     data['deliveryCharge'] = this.deliveryCharge;
//     data['free_delivery_min_order_value'] = this.free_delivery_min_order_value;
//     data['surCharge'] = this.surCharge;
//     data['tipAmount'] = this.tipAmount;
//     data['packingFee'] = this.packingFee;
//     data['taxAndFee'] = this.taxAndFee;
//     if (this.tax1 != null) {
//       data['tax_1'] = this.tax1!.toJson();
//     }
//     if (this.tax2 != null) {
//       data['tax_2'] = this.tax2!.toJson();
//     }
//     data['total'] = this.total;
//     return data;
//   }
// }
//
// class Tax1 {
//   dynamic type;
//   dynamic amount;
//
//   Tax1({this.type, this.amount});
//
//   Tax1.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     amount = json['amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['amount'] = this.amount;
//     return data;
//   }
// }
//
//
// class Tax2 {
//   dynamic type;
//   dynamic amount;
//
//   Tax2({this.type, this.amount});
//
//   Tax2.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     amount = json['amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['amount'] = this.amount;
//     return data;
//   }
// }
//
// class OrderAddress {
//   dynamic id;
//   dynamic userId;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic location;
//   dynamic flatNo;
//   dynamic street;
//   dynamic landmark;
//   dynamic addressType;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic deletedAt;
//
//   OrderAddress(
//       {this.id,
//         this.userId,
//         this.latitude,
//         this.longitude,
//         this.location,
//         this.flatNo,
//         this.street,
//         this.landmark,
//         this.addressType,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt});
//
//   OrderAddress.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     location = json['location'];
//     flatNo = json['flat_no'];
//     street = json['street'];
//     landmark = json['landmark'];
//     addressType = json['address_type'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     deletedAt = json['deleted_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['location'] = this.location;
//     data['flat_no'] = this.flatNo;
//     data['street'] = this.street;
//     data['landmark'] = this.landmark;
//     data['address_type'] = this.addressType;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['deleted_at'] = this.deletedAt;
//     return data;
//   }
// }
class MyCartData {
  bool? status;
  String? message;
  Data? data;

  MyCartData({this.status, this.message, this.data});

  MyCartData.fromJson(Map<String, dynamic> json) {
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
  CartPaymentSummary? cartPaymentSummary;
  OrderAddress? orderAddress;

  Data({this.cartItems, this.cartPaymentSummary, this.orderAddress});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
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
  dynamic id;
  dynamic productId;
  bool? whislist;
  dynamic productName;
  dynamic variantId;
  dynamic variantQty;
  dynamic variantQtyType;
  dynamic variantPrice;
  dynamic cartItemQty;
  dynamic image;

  CartItems(
      {this.id,
        this.productId,
        this.whislist,
        this.productName,
        this.variantId,
        this.variantQty,
        this.variantQtyType,
        this.variantPrice,
        this.cartItemQty,
        this.image});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    whislist = json['whislist'];
    productName = json['product_name'];
    variantId = json['variant_id'];
    variantQty = json['variant_qty'];
    variantQtyType = json['variant_qty_type'];
    variantPrice = json['variant_price'];
    cartItemQty = json['cart_item_qty'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['whislist'] = this.whislist;
    data['product_name'] = this.productName;
    data['variant_id'] = this.variantId;
    data['variant_qty'] = this.variantQty;
    data['variant_qty_type'] = this.variantQtyType;
    data['variant_price'] = this.variantPrice;
    data['cart_item_qty'] = this.cartItemQty;
    data['image'] = this.image;
    return data;
  }
}

class CartPaymentSummary {
  dynamic adminCommission;
  dynamic subTotal;
  dynamic marketingPartnerCommission;
  dynamic couponDiscount;
  dynamic couponCode;
  dynamic driverCommission;
  dynamic freeDeliveryMinOrderValue;
  dynamic deliveryCharge;
  dynamic surCharge;
  dynamic tipAmount;
  dynamic packingFee;
  dynamic tax1;
  dynamic tax2;
  dynamic taxAndFee;
  dynamic total;

  CartPaymentSummary(
      {this.adminCommission,
        this.subTotal,
        this.marketingPartnerCommission,
        this.couponDiscount,
        this.couponCode,
        this.driverCommission,
        this.freeDeliveryMinOrderValue,
        this.deliveryCharge,
        this.surCharge,
        this.tipAmount,
        this.packingFee,
        this.tax1,
        this.tax2,
        this.taxAndFee,
        this.total});

  CartPaymentSummary.fromJson(Map<String, dynamic> json) {
    adminCommission = json['adminCommission'];
    subTotal = json['subTotal'];
    marketingPartnerCommission = json['marketingPartnerCommission'];
    couponDiscount = json['couponDiscount'];
    couponCode = json['couponCode'];
    driverCommission = json['driver_commission'];
    freeDeliveryMinOrderValue = json['free_delivery_min_order_value'];
    deliveryCharge = json['deliveryCharge'];
    surCharge = json['surCharge'];
    tipAmount = json['tipAmount'];
    packingFee = json['packingFee'];
    tax1 = json['tax_1'];
    tax2 = json['tax_2'];
    taxAndFee = json['tax_and_fee'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adminCommission'] = this.adminCommission;
    data['subTotal'] = this.subTotal;
    data['marketingPartnerCommission'] = this.marketingPartnerCommission;
    data['couponDiscount'] = this.couponDiscount;
    data['couponCode'] = this.couponCode;
    data['driver_commission'] = this.driverCommission;
    data['free_delivery_min_order_value'] = this.freeDeliveryMinOrderValue;
    data['deliveryCharge'] = this.deliveryCharge;
    data['surCharge'] = this.surCharge;
    data['tipAmount'] = this.tipAmount;
    data['packingFee'] = this.packingFee;
    data['tax_1'] = this.tax1;
    data['tax_2'] = this.tax2;
    data['tax_and_fee'] = this.taxAndFee;
    data['total'] = this.total;
    return data;
  }
}

class OrderAddress {
  dynamic id;
  dynamic userId;
  dynamic latitude;
  dynamic longitude;
  dynamic location;
  dynamic address1;
  dynamic address2;
  dynamic flatNo;
  dynamic street;
  dynamic city;
  dynamic state;
  dynamic zipCode;
  dynamic landmark;
  dynamic otherInstruction;
  dynamic addressType;
  dynamic recipientName;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  bool? defaultAddress;

  OrderAddress(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.location,
        this.address1,
        this.address2,
        this.flatNo,
        this.street,
        this.city,
        this.state,
        this.zipCode,
        this.landmark,
        this.otherInstruction,
        this.addressType,
        this.recipientName,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.defaultAddress});

  OrderAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    flatNo = json['flat_no'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    landmark = json['landmark'];
    otherInstruction = json['other_instruction'];
    addressType = json['address_type'];
    recipientName = json['recipient_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    defaultAddress = json['default_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location'] = this.location;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['flat_no'] = this.flatNo;
    data['street'] = this.street;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['landmark'] = this.landmark;
    data['other_instruction'] = this.otherInstruction;
    data['address_type'] = this.addressType;
    data['recipient_name'] = this.recipientName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['default_address'] = this.defaultAddress;
    return data;
  }
}

