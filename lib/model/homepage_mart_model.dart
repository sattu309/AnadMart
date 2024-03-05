
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class HomepageMartModel {
  bool? status;
  String? message;
  Data? data;

  HomepageMartModel({this.status, this.message, this.data});

  HomepageMartModel.fromJson(Map<String, dynamic> json) {
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
  List<SliderData>? sliderData;
  List<LatestCategory>? latestCategory;

  Data({this.sliderData, this.latestCategory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sliderData'] != null) {
      sliderData = <SliderData>[];
      json['sliderData'].forEach((v) {
        sliderData!.add(new SliderData.fromJson(v));
      });
    }
    if (json['latestCategory'] != null) {
      latestCategory = <LatestCategory>[];
      json['latestCategory'].forEach((v) {
        latestCategory!.add(new LatestCategory.fromJson(v));
      });
    }
    latestCategory ??= [];
    latestCategory!.removeWhere((element) => element.products!.isEmpty);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliderData != null) {
      data['sliderData'] = this.sliderData!.map((v) => v.toJson()).toList();
    }
    if (this.latestCategory != null) {
      data['latestCategory'] =
          this.latestCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderData {
  int? id;
  String? title;
  String? link;
  String? image;

  SliderData({this.id, this.title, this.link, this.image});

  SliderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    link = json['link'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    data['image'] = this.image;
    return data;
  }
}

class LatestCategory {
  dynamic id;
  dynamic taxPercent;
  dynamic name;
  dynamic slug;
  dynamic image;
  List<Variants>? varints;
  RxInt? varientIndex = (0).obs;
  List<Products>? products = [];

  LatestCategory(
      {this.id,
        this.taxPercent,
        this.name,
        this.slug,
        this.image,
        this.products});

  LatestCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxPercent = json['tax_percent'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    products ??= [];
    products!.removeWhere((element) => element.selectedVariant == null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_percent'] = this.taxPercent;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  dynamic id;
  dynamic categoryId;
  dynamic sKU;
  dynamic avgRating;
  dynamic name;
  dynamic image;
  bool ? value;
  bool? whislist;
  List<Variants>? variants;
  Variants? selectedVariant;
  // Variants? selectedPrice;
  // int productCount = 0;


  Products({this.id, this.categoryId, this.sKU, this.name, this.avgRating, this.image, this.whislist, this.variants});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    sKU = json['SKU'];
    name = json['name'];
    avgRating = json['avg_rating'];
    whislist = json['whislist'];
    image = json['image'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
      variants ??= [];
      if(variants!.isNotEmpty){
        selectedVariant = variants!.first;
      }
      // variants?.removeWhere((element) => element.variantQtyType!.isEmpty);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['avg_rating'] = this.avgRating;
    data['whislist'] = this.whislist;
    data['image'] = this.image;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  dynamic id;
  dynamic vendorProductId;
  dynamic marketPrice;
  dynamic price;
  dynamic variantQty;
  dynamic variantQtyType;
  dynamic minQty;
  dynamic maxQty;
  dynamic discountOff;
  dynamic selectedPrice;

  Variants(
      {this.id,
        this.vendorProductId,
        this.marketPrice,
        this.price,
        this.variantQty,
        this.variantQtyType,
        this.minQty,
        this.maxQty,
        this.discountOff});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorProductId = json['vendor_product_id'];
    marketPrice = json['market_price'];
    price = json['price'];
    variantQty = json['variant_qty'];
    variantQtyType = json['variant_qty_type'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    discountOff = json['discount_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_product_id'] = this.vendorProductId;
    data['market_price'] = this.marketPrice;
    data['price'] = this.price;
    data['variant_qty'] = this.variantQty;
    data['variant_qty_type'] = this.variantQtyType;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    data['discount_off'] = this.discountOff;
    return data;
  }
}
