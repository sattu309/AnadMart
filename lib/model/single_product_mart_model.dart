class SingleProductModel {
  bool? status;
  String? message;
  Data? data;

  SingleProductModel({this.status, this.message, this.data});

  SingleProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json
    ['data']) : null;
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
  Category? category;
  dynamic tax;
  dynamic sKU;
  dynamic name;
  dynamic qty;
  dynamic qtyType;
  dynamic cartItemQty;
  dynamic marketPrice;
  dynamic regularPrice;
  dynamic content;
  dynamic avgRating;
  dynamic reviewCount;
  dynamic shareCount;
  dynamic image;
  int? selectedTerm;
  int productCount=0;
  List<Subscriptionplan>? subscriptionplan;
  List<String>? galleryImage;
  List<String>? thumbnailGalleryImage;
  dynamic thumbnailImage;
  List<RelatedProduct>? relatedProduct;
  List<Variants>? variants;


  Data(
      {this.id,
        this.category,
        this.tax,
        this.sKU,
        this.name,
        this.qty,
        this.thumbnailImage,
        this.thumbnailGalleryImage,
        this.subscriptionplan,
        this.qtyType,
        this.cartItemQty,
        this.marketPrice,
        this.regularPrice,
        this.content,
        this.avgRating,
        this.shareCount,
        this.reviewCount,
        this.image,
        this.galleryImage,
        this.relatedProduct,
        this.variants});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    tax = json['tax'] != null ? new Tax.fromJson(json['tax']) : null;
    sKU = json['SKU'];
    name = json['name'];
    qty = json['qty'];
    qtyType = json['qty_type'];
    avgRating = json['avg_rating'];
    reviewCount = json['review_count'];
    shareCount = json['share_count'];
    cartItemQty = json['cart_item_qty'];
    marketPrice = json['market_price'];
    regularPrice = json['regular_price'];
    content = json['content'];
    image = json['image'];
    if (json['subscriptionplan'] != null) {
      subscriptionplan = <Subscriptionplan>[];
      json['subscriptionplan'].forEach((v) {
        subscriptionplan!.add(new Subscriptionplan.fromJson(v));
      });
    }
    galleryImage = json['gallery_image'].cast<String>();
    thumbnailGalleryImage = json['thumbnail_gallery_image'].cast<String>();
    thumbnailImage = json['thumbnail_image'];
    if (json['related_product'] != null) {
      relatedProduct = <RelatedProduct>[];
      json['related_product'].forEach((v) {
        relatedProduct!.add(new RelatedProduct.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    relatedProduct ??=[];
    relatedProduct!.removeWhere((element) => element.variants!.isEmpty);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.tax != null) {
      data['tax'] = this.tax!.toJson();
    }
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['qty_type'] = this.qtyType;
    data['avg_rating'] = this.avgRating;
    data['review_count'] = this.reviewCount;
    data['share_count'] = this.shareCount;
    data['cart_item_qty'] = this.cartItemQty;
    data['market_price'] = this.marketPrice;
    data['regular_price'] = this.regularPrice;
    data['content'] = this.content;
    data['image'] = this.image;
    data['gallery_image'] = this.galleryImage;
    data['thumbnail_gallery_image'] = this.thumbnailGalleryImage;
    data['thumbnail_image'] = this.thumbnailImage;
    if (this.subscriptionplan != null) {
      data['subscriptionplan'] =
          this.subscriptionplan!.map((v) => v.toJson()).toList();
    }
    if (this.relatedProduct != null) {
      data['related_product'] =
          this.relatedProduct!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  dynamic id;
  dynamic tax;
  dynamic name;
  dynamic slug;
  dynamic image;
  bool? status;

  Category({this.id, this.tax, this.name, this.slug, this.image, this.status});

  Category.fromJson(Map<String, dynamic> json) {
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

class Tax {
  dynamic id;
  dynamic title;
  dynamic taxPercent;
  bool? status;

  Tax({this.id, this.title, this.taxPercent, this.status});

  Tax.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    taxPercent = json['tax_percent'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tax_percent'] = this.taxPercent;
    data['status'] = this.status;
    return data;
  }
}

class RelatedProduct {
  dynamic id;
  dynamic categoryId;
  dynamic sKU;
  dynamic name;
  dynamic avgRating;
  dynamic cartItemQty;
  bool? whislist;
  String? image;
  List<Variants>? variants;
  Variants? selectedVariant;

  RelatedProduct(
      {this.id,
        this.categoryId,
        this.sKU,
        this.name,
        this.avgRating,
        this.cartItemQty,
        this.whislist,
        this.image,
        this.variants});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    sKU = json['SKU'];
    name = json['name'];
    cartItemQty = json['cart_item_qty'];
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
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['avg_rating'] = this.avgRating;
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['cart_item_qty'] = this.cartItemQty;
    data['whislist'] = this.whislist;
    data['image'] = this.image;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Subscriptionplan {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  dynamic selectedTermId;

  Subscriptionplan({this.id, this.name, this.createdAt, this.updatedAt});

  Subscriptionplan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  dynamic discountOff;

  Variants(
      {this.id,
        this.vendorProductId,
        this.marketPrice,
        this.price,
        this.variantQty,
        this.variantQtyType,
        this.discountOff});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorProductId = json['vendor_product_id'];
    marketPrice = json['market_price'];
    price = json['price'];
    variantQty = json['variant_qty'];
    variantQtyType = json['variant_qty_type'];
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
    data['discount_off'] = this.discountOff;
    return data;
  }
}
