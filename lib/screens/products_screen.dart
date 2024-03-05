import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fresh2_arrive/screens/product_screen_ofMart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/My_cart_controller.dart';
import '../controller/home_page_controller.dart';
import '../model/My_Cart_Model.dart';
import '../model/category_products_model.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../repositories/category_products_repo.dart';
import '../repositories/wishlist_repo.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';

class ProductScreenOfMart extends StatefulWidget {
  final String categoryId;

  const ProductScreenOfMart({Key? key, required this.categoryId}) : super(key: key);


  @override
  State<ProductScreenOfMart> createState() => _ProductScreenOfMartState();
}

class _ProductScreenOfMartState extends State<ProductScreenOfMart> {
  final myCartController = Get.put(MyCartDataListController());


  final homepageControllerMart = Get.put(HomePageController());

  RxBool isPaginationLoading = false.obs;
  bool loadMore = true;

  int page = 1;
  int pagination = 10;
  ProductModel? productModel;
  final ScrollController scrollController = ScrollController();

  Future<dynamic> getCategoryProductsData() async {
    isPaginationLoading.value = true;
    await categoryProductsData(id: widget.categoryId, page: page, pagination: pagination).then((value) {

      if (value.data!.products!.length < pagination) {
        loadMore = false;
      }
      if (productModel == null) {
        productModel = value;
        log("leech ${productModel!.data!.products!.length.toString()}");
      } else {
        productModel!.data!.products!.addAll(value.data!.products!);
      }
      isPaginationLoading.value = false;
      setState(() {});
    }).catchError((e) {
      isPaginationLoading.value = false;
    });
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getCategoryProductsData();
      scrollController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      page++;
      getCategoryProductsData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: backAppBar2(title: "All Product", context: context),
      extendBody: true,
      body: productModel != null
          ? productModel!.data!.products!.isNotEmpty
              ? GridView.builder(
                    controller: scrollController,
                  shrinkWrap: true,
            itemCount: productModel!.data!.products!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisExtent: 290,
                      mainAxisSpacing: 5.0),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    final itemData = productModel!.data!.products![i];
                    return GestureDetector(
                      onTap: (){
                        Get.to(() => SingleProductScreenMart(
                          productId: itemData.id.toString(),
                          variantId: itemData.selectedVarient!.id.toString(),
                          selectedPrice: itemData.selectedVarient!.price.toString(),
                        ));
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      width: width * .6,
                                       height:  height * .15,
                                      decoration:
                                          BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: itemData.image.toString(),
                                        fit: BoxFit.cover,
                                        height: 80,
                                        errorWidget: (_, __, ___) => Image.asset(
                                          'assets/images/Ellipse 67.png',
                                          height: 80,
                                        ),
                                        placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                      ),
                                    ),
                                    Positioned(
                                        top: 10,
                                        right: 13,
                                        child: InkWell(
                                            onTap: () {
                                              print("Store wishlist id..${itemData.id.toString()}");

                                              wishlistRepo(productId: itemData.id.toString(), context: context).then((value) {
                                                if (value.status == true) {
                                                  itemData.whislist= !(itemData.whislist?? false);
                                                  setState(() {

                                                  });
                                                  showToast(value.message);

                                                  homepageControllerMart.getHomePageData();
                                                }
                                              });
                                            },
                                            child: itemData.whislist!
                                                ? Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                            AppAssets.wishlistIconnns,
                                                          ),
                                                        )),
                                                  )
                                                : Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      size: 18,
                                                    ),
                                                  ))),
                                  ],
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Expanded(
                                  child: StatefulBuilder(builder: (context, newState) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          itemData.name.toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.ibmPlexSansArabic(
                                              fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xff08141B)),
                                        ),
                                        // addHeight(10),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: buildDropdownButtonFormField(
                                                  variants: itemData.variants ?? [],
                                                  dropDownValue: itemData.selectedVarient,
                                                  vv: (Variants variants) {
                                                    itemData.selectedVarient = variants;
                                                    newState(() {});
                                                  }),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Color(0xffFFAB07),
                                                  size: 20,
                                                ),
                                                Text(
                                    itemData.avgRating.toString(),
                                                  style: GoogleFonts.ibmPlexSansArabic(
                                                      fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff0F0300)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Obx(() {
                                          if (myCartController.refreshInt.value > 0) {}
                                          CartItems? cartItem;
                                          if (myCartController.isDataLoaded.value &&
                                              myCartController.model.value.data!.cartItems != null) {
                                            final list = myCartController.model.value.data!.cartItems!
                                                .where((element) =>
                                                    element.variantId.toString() == itemData.selectedVarient!.id.toString())
                                                .toList();
                                            if (list.isNotEmpty) {
                                              cartItem = list.first;
                                            }
                                          }

                                          return Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  itemData.selectedVarient != null
                                                      ? "\$${itemData.selectedVarient!.price.toString()}"
                                                      : "not available",
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xff000000)),
                                                ),
                                                myCartController.isDataLoaded.value && itemData.variants!.isNotEmpty
                                                    ? cartItem != null
                                                        ? Container(
                                                            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(6),
                                                                color: Color(0xff4DBA4D),
                                                                // border: Border.all(color: const Color(0xFF72CD4A)),
                                                                shape: BoxShape.rectangle),
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (cartItem!.cartItemQty.toString() == "1") {
                                                                      removeCartItemRepo(
                                                                              cartId: cartItem.id.toString(), context: context)
                                                                          .then((value) {
                                                                        if (value.status == true) {
                                                                          myCartController.getAddToCartList();
                                                                        }
                                                                      }).then((value) {});
                                                                    } else {
                                                                      addToCartRepo(
                                                                              context: context,
                                                                              product_id: itemData.id.toString(),
                                                                              qty:
                                                                                  (int.parse(cartItem.cartItemQty.toString()) -
                                                                                          1)
                                                                                      .toString(),
                                                                              variant_id:
                                                                                  itemData.selectedVarient!.id.toString())
                                                                          .then((value) {
                                                                        showToast(value.message);
                                                                        if (value.status == true) {
                                                                          myCartController.getAddToCartList();
                                                                        }
                                                                      });
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons.remove,
                                                                    size: 17,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                                addWidth(7),
                                                                Text(
                                                                  cartItem.cartItemQty.toString(),
                                                                  style: GoogleFonts.poppins(
                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 16,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                                addWidth(7),
                                                                InkWell(
                                                                  onTap: () {
                                                                    addToCartRepo(
                                                                            context: context,
                                                                            product_id: itemData.id.toString(),
                                                                            qty: (int.parse(cartItem!.cartItemQty.toString()) +
                                                                                    1)
                                                                                .toString(),
                                                                            variant_id:
                                                                                itemData.selectedVarient!.id.toString())
                                                                        .then((value) {
                                                                      showToast(value.message);
                                                                      if (value.status == true) {
                                                                        myCartController.getAddToCartList();
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 17,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              addToCartRepo(
                                                                      context: context,
                                                                      product_id: itemData.id.toString(),
                                                                      qty: 1.toString(),
                                                                      variant_id: itemData.selectedVarient!.id.toString())
                                                                  .then((value) {
                                                                showToast(value.message);
                                                                if (value.status == true) {
                                                                  myCartController.getAddToCartList();
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                                height: 35,
                                                                width: 35,
                                                                // width: 25,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                    color: Color(0xff4DBA4D),
                                                                    // border: Border.all(color: const Color(0xFF72CD4A)),
                                                                    shape: BoxShape.rectangle),
                                                                alignment: Alignment.center,
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: 5,
                                                                  ),
                                                                  child: Image.asset("assets/images/plusIcon.png"),
                                                                )),
                                                          )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          );
                                        }),
                                        // SizedBox(height: height * .03,)
                                      ],
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                child:  Text(
                  "No product available",
                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: Obx(() {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: isPaginationLoading.value && productModel != null ? 1 : 0),
          duration: Duration(seconds: 1),
          builder: (BuildContext context, double value, Widget? child) {
            return IgnorePointer(
              ignoring: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Opacity(
                    opacity: value,
                    child: Card(
                      color: Colors.green,
                      surfaceTintColor: Colors.green,
                      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Loading",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Transform.scale(
                                scale: .75,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      })
    );
  }

  buildDropdownButtonFormField(
      {required List<Variants> variants, required Function(Variants variants) vv, Variants? dropDownValue}) {
    // final dropDownValues= homepageControllerMart.homePageMartModel.value.data!.latestCategory![index].products![index].variants!.length;
    // return Obx(() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Variants>(
          icon: Icon(
            Icons.arrow_drop_down,
            size: 23,
          ),
          isDense: true,
          // isExpanded: true,
          alignment: Alignment.centerLeft,
          style: TextStyle(fontSize: 12.5, color: Colors.black),
          value: dropDownValue,
          items: variants
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      "${e.variantQty} "
                      " ${e.variantQtyType}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ))
              .toList(),
          onChanged: (newValue) {
            if (newValue == null) return;
            dropDownValue = newValue;
            vv(newValue);
            setState(() {});
          }),
    );
    // });
  }


}
