import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'homepage_mart_model.dart';

class WishListModel {
  bool? status;
  String? message;
  Data? data;

  WishListModel({this.status, this.message, this.data});

  WishListModel.fromJson(Map<String, dynamic> json) {
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
  List<Wishlist>? wishlist;

  Data({this.wishlist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  int? id;
  dynamic productId;
  dynamic avgRating;
  String? name;
  String? image;
  List<Variants>? variants;
  Variants? selectedVarient;
  RxInt? varientIndex = (0).obs;

  Wishlist({this.id, this.name,this.avgRating, this.image, this.productId, this.variants});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avgRating = json['avg_rating'];
    productId = json['product_id'];
    image = json['image'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
      variants ??=[];
      if(variants!.isNotEmpty){
        selectedVarient=variants!.first;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_id'] = this.productId;
    data['avg_rating'] = this.avgRating;
    data['image'] = this.image;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Variants {
//   int? id;
//   int? vendorProductId;
//   int? marketPrice;
//   int? price;
//   String? variantQty;
//   String? variantQtyType;
//   int? minQty;
//   int? maxQty;
//   String? discountOff;
//
//   Variants(
//       {this.id,
//         this.vendorProductId,
//         this.marketPrice,
//         this.price,
//         this.variantQty,
//         this.variantQtyType,
//         this.minQty,
//         this.maxQty,
//         this.discountOff});
//
//   Variants.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorProductId = json['vendor_product_id'];
//     marketPrice = json['market_price'];
//     price = json['price'];
//     variantQty = json['variant_qty'];
//     variantQtyType = json['variant_qty_type'];
//     minQty = json['min_qty'];
//     maxQty = json['max_qty'];
//     discountOff = json['discount_off'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_product_id'] = this.vendorProductId;
//     data['market_price'] = this.marketPrice;
//     data['price'] = this.price;
//     data['variant_qty'] = this.variantQty;
//     data['variant_qty_type'] = this.variantQtyType;
//     data['min_qty'] = this.minQty;
//     data['max_qty'] = this.maxQty;
//     data['discount_off'] = this.discountOff;
//     return data;
//   }
// }
