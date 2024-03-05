class SubCategoryModel {
  bool? status;
  String? message;
  Data? data;

  SubCategoryModel({this.status, this.message, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  Detail? detail;
  List<SubCategory>? subCategory;

  Data({this.detail, this.subCategory});

  Data.fromJson(Map<String, dynamic> json) {
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    if (json['sub_category'] != null) {
      subCategory = <SubCategory>[];
      json['sub_category'].forEach((v) {
        subCategory!.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  Null? tax;
  String? name;
  String? slug;
  String? image;
  bool? status;

  Detail({this.id, this.tax, this.name, this.slug, this.image, this.status});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tax = json['tax'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax'] = this.tax;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class SubCategory {
  int? id;
  String? taxPercent;
  String? name;
  String? slug;
  String? image;
  List<Null>? subCategory;
  List<Products>? products;

  SubCategory(
      {this.id,
        this.taxPercent,
        this.name,
        this.slug,
        this.image,
        this.subCategory,
        this.products});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxPercent = json['tax_percent'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    if (json['sub_category'] != null) {
      subCategory = <Null>[];
      json['sub_category'].forEach((v) {
        // subCategory!.add(new Null.fromJson(v));
      });
    }
    if (json['Products'] != null) {
      products = <Products>[];
      json['Products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_percent'] = this.taxPercent;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    if (this.subCategory != null) {
      // data['sub_category'] = this.subCategory!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['Products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? categoryId;
  String? sKU;
  String? name;
  bool? whislist;
  String? image;
  List<Variants>? variants;

  Products(
      {this.id,
        this.categoryId,
        this.sKU,
        this.name,
        this.whislist,
        this.image,
        this.variants});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    sKU = json['SKU'];
    name = json['name'];
    whislist = json['whislist'];
    image = json['image'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['whislist'] = this.whislist;
    data['image'] = this.image;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  int? id;
  int? vendorProductId;
  int? marketPrice;
  int? price;
  String? variantQty;
  String? variantQtyType;
  int? minQty;
  int? maxQty;
  String? discountOff;

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
