import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fresh2_arrive/repositories/common_repo/repository.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/My_cart_controller.dart';
import '../model/My_Cart_Model.dart';
import '../model/single_product_mart_model.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../repositories/wishlist_repo.dart';
import '../resources/api_url.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'feedback_screen.dart';

class SingleProductScreenMart extends StatefulWidget {
  String productId;
  String variantId;
  String? selectedPrice;

  SingleProductScreenMart({Key? key, required this.productId, required this.variantId, required this.selectedPrice})
      : super(key: key);

  @override
  State<SingleProductScreenMart> createState() => _SingleProductScreenMartState();
}

class _SingleProductScreenMartState extends State<SingleProductScreenMart> {
  final myCartController = Get.put(MyCartDataListController());
  String? selectedSubscribtionTYpe;
  List method = ["M", "TM"];
  double fullRating = 0;
  int currentIndex = 0;
  int galleryIndex = 0;
  int? selectedSubscriptionIndex;
  var getItem;
  var price;

  SingleProductModel? singleProductModel;
  Repositories repositories = Repositories();
  CartItems? cartItem;

  getProductInfo() {
    repositories.getApi(url: "${ApiUrl.singleProductScreenUrl}/${widget.productId}").then((value) {
      singleProductModel = SingleProductModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myCartController.getAddToCartList();
      getProductInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // var singleProductdata = singleProductModel.data!;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                )),
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 17,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: singleProductModel != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // addHeight(10),
                    Center(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: CachedNetworkImage(
                          imageUrl: singleProductModel!.data!.thumbnailImage.toString(),
                          key: ValueKey(singleProductModel!.data!.thumbnailImage.toString()),
                          errorWidget: (_, __, ___) => const SizedBox(),
                          placeholder: (_, __) => const SizedBox(),
                          fit: BoxFit.cover,
                          height: height * .2,
                        ),
                      ),
                    ),
                    addHeight(20),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: singleProductModel!.data!.thumbnailGalleryImage!.length,
                        itemBuilder: (BuildContext context, int index) {
                          // String productID = widget.productId.toString();
                          // singleProductModel!.data!.productCount = int.tryParse((myCartController.model.value.data!.cartItems!
                          //     .firstWhere((element) =>
                          // element.productId.toString() == productID, orElse: () => CartItems()).cartItemQty ?? "").toString()) ??
                          //     0;
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    singleProductModel!.data!.thumbnailImage =
                                        singleProductModel!.data!.thumbnailGalleryImage![index];
                                    galleryIndex = index;
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 80,
                                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 27),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: galleryIndex == index ? Color(0xff4DBA4D) : Colors.white24, width: 2),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: singleProductModel!.data!.thumbnailGalleryImage![index],
                                      errorWidget: (_, __, ___) => const SizedBox(),
                                      placeholder: (_, __) => const SizedBox(),
                                      fit: BoxFit.contain,
                                      height: 45,
                                    ),
                                  ),
                                ),
                                addWidth(10),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    addHeight(15),
                    Container(
                      decoration: BoxDecoration(
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 1.0,
                          //     offset: Offset(1, 1),
                          //   ),
                          // ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    singleProductModel!.data!.name.toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xff000000)),
                                  ),
                                ),
                                // Obx(() {
                                //   if (myCartController.refreshInt.value > 0) {}
                                //   CartItems? cartItem;
                                //   if (myCartController.isDataLoaded.value &&
                                //       myCartController.model.value.data!.cartItems != null) {
                                //     final list = myCartController.model.value.data!.cartItems!
                                //         .where((element) => element.variantId.toString() == widget.variantId)
                                //         .toList();
                                //     if (list.isNotEmpty) {
                                //       cartItem = list.first;
                                //     }
                                //   }
                                //   return Padding(
                                //     padding: const EdgeInsets.only(top: 10),
                                //     child: Container(
                                //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                //       decoration:
                                //           BoxDecoration(color: Color(0xffEEEEEE), borderRadius: BorderRadius.circular(25)),
                                //       child: Row(
                                //         children: [
                                //           GestureDetector(
                                //             onTap: () {
                                //               // myCartController.minusCounter();
                                //               // setState(() {});
                                //               if (cartItem!.cartItemQty.toString() == "1") {
                                //                 removeCartItemRepo(cartId: cartItem.id.toString(), context: context)
                                //                     .then((value) {
                                //                   if (value.status == true) {
                                //                     myCartController.getAddToCartList();
                                //                   }
                                //                 }).then((value) {});
                                //               } else {
                                //                 addToCartRepo(
                                //                         context: context,
                                //                         product_id: widget.productId.toString(),
                                //                         qty: (int.parse(cartItem!.cartItemQty.toString()) - 1).toString(),
                                //                         variant_id: widget.variantId.toString())
                                //                     .then((value) {
                                //                   showToast(value.message);
                                //                   if (value.status == true) {
                                //                     myCartController.getAddToCartList();
                                //                   }
                                //                 });
                                //               }
                                //             },
                                //             child: Icon(
                                //               Icons.remove,
                                //               size: 17,
                                //             ),
                                //           ),
                                //           addWidth(7),
                                //           Text(
                                //             cartItem != null ? cartItem.cartItemQty.toString() : "0",
                                //             style: GoogleFonts.poppins(
                                //                 fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xff000000)),
                                //           ),
                                //           addWidth(7),
                                //           GestureDetector(
                                //             onTap: () {
                                //               // myCartController.plusCounter();
                                //               // log(myCartController.counter.toString());
                                //               // setState(() {});
                                //
                                //               if (cartItem != null) {
                                //                 addToCartRepo(
                                //                         context: context,
                                //                         product_id: singleProductModel!.data!.id.toString(),
                                //                         qty: (int.parse((cartItem!.cartItemQty ?? "0").toString()) + 1)
                                //                             .toString(),
                                //                         variant_id: widget.variantId.toString())
                                //                     .then((value) {
                                //                   showToast(value.message);
                                //                   if (value.status == true) {
                                //                     myCartController.getAddToCartList();
                                //                   }
                                //                 });
                                //               } else {
                                //                 addToCartRepo(
                                //                         context: context,
                                //                         product_id: singleProductModel!.data!.id.toString(),
                                //                         qty: 1.toString(),
                                //                         variant_id: widget.variantId.toString())
                                //                     .then((value) {
                                //                   showToast(value.message);
                                //                   if (value.status == true) {
                                //                     myCartController.getAddToCartList();
                                //                   }
                                //                 });
                                //               }
                                //             },
                                //             child: Icon(
                                //               Icons.add,
                                //               size: 17,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   );
                                // })
                              ],
                            ),
                            addHeight(10),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: double.parse(singleProductModel!.data!.avgRating.toString()),
                                  glowColor: Colors.white10,
                                  minRating: 1,
                                  unratedColor: const Color(0xFFE0DEDA),
                                  itemCount: 5,
                                  itemSize: 15.0,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  updateOnDrag: false,
                                  ignoreGestures: true,
                                  allowHalfRating: true,
                                  itemBuilder: (context, index) => Image.asset(
                                    'assets/images/star.png',
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (ratingvalue) {
                                    // setState(() {
                                    //   fullRating = ratingvalue;
                                    // });
                                  },
                                ),
                                addWidth(6),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => FeedBackScreen(
                                          productId: widget.productId,
                                        ));
                                  },
                                  child: Text(
                                    "(${singleProductModel!.data!.reviewCount.toString()} Review)",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff000000)),
                                  ),
                                ),
                              ],
                            ),
                            addHeight(13),
                            Row(
                              children: [
                                Image.asset("assets/images/shareIcon.png"),
                                Expanded(
                                  child: Text(
                                    singleProductModel!.data!.shareCount.toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xff000000)),
                                  ),
                                ),
                                Text(
                                  "Available in stock",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xff4DBA4D)),
                                ),
                              ],
                            ),
                            addHeight(10),
                            Text(
                              "Size",
                              style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff000000)),
                            ),
                            SizedBox(
                              height: 53,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: singleProductModel!.data!.variants!.length,
                                  itemBuilder: (BuildContext Context, index) {
                                    final variantData = singleProductModel!.data!.variants![index];

                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // myCartController.counter.value = 1;
                                            currentIndex = index;
                                            price = variantData.price.toString();
                                            widget.variantId = variantData.id.toString();
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: widget.variantId.toString() != variantData.id.toString()
                                                    ? Colors.white
                                                    : Color(0xff0074D9),
                                                border: Border.all(color: Color(0xffE9E9E9)),
                                                borderRadius: BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffE9E9E9),
                                                    blurRadius: 2.0,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ]),
                                            child: Text(
                                              " ${variantData.variantQty.toString()}" +
                                                  " ${variantData.variantQtyType.toString()}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: widget.variantId.toString() != variantData.id.toString()
                                                      ? Color(0xff000000)
                                                      : Colors.white),
                                            ),
                                          ),
                                        ),
                                        addWidth(15)
                                      ],
                                    );
                                  }),
                            ),
                            addHeight(15),
                            Text(
                              "Description",
                              style:
                                  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xff000000)),
                            ),
                            addHeight(8),
                            Text(
                              singleProductModel!.data!.content.toString().replaceAll( RegExp(r'<[^>]*>|&[^;]+;'),"" ),
                              style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff666666)),
                            ),
                            addHeight(18),
                            singleProductModel!.data!.subscriptionplan!.isNotEmpty


                                ? Text(
                                    "Select Subscription Plan",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xff000000)),
                                  )
                                : SizedBox(),
                            addHeight(14),
                            ...List.generate(singleProductModel!.data!.subscriptionplan!.length, (index) {
                              final memberShipData = singleProductModel!.data!.subscriptionplan![index];
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: Color(0xffE2E2E2))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            memberShipData.name.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff000000)),
                                          ),
                                          Checkbox(
                                              side: const BorderSide(color: Colors.black, width: 2),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                              value: selectedSubscriptionIndex == index,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value!) {
                                                    selectedSubscriptionIndex = index;
                                                  } else {
                                                    selectedSubscriptionIndex = null;
                                                  }
                                                  memberShipData.selectedTermId = value;
                                                  log(memberShipData.selectedTermId.toString());
                                                  if (memberShipData.selectedTermId == true) {
                                                    getItem = memberShipData.id.toString();
                                                    log(getItem);
                                                  }
                                                });
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                  addHeight(13),
                                ],
                              );
                            }),
                            addHeight(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Total Price",
                                      style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xffAAAAAA)),
                                    ),
                                    Obx(() {
                                      if (myCartController.refreshInt.value > 0) {}
                                      CartItems? cartItem;
                                      if (myCartController.isDataLoaded.value &&
                                          myCartController.model.value.data!.cartItems != null) {
                                        final list = myCartController.model.value.data!.cartItems!
                                            .where((element) => element.variantId.toString() == widget.variantId)
                                            .toList();
                                        if (list.isNotEmpty) {
                                          cartItem = list.first;
                                        }
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child:
                                            // myCartController.isDataLoaded.value &&
                                            //         myCartController.model.value.data!.cartItems!.isNotEmpty
                                            //     ?
                                            cartItem != null
                                                ? Text(
                                                    "\$ ${int.parse(price ?? widget.selectedPrice.toString()) * int.parse(cartItem!.cartItemQty.toString())}  ",
                                                    style: GoogleFonts.quicksand(
                                                        fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xff000000)),
                                                  )
                                                : Text(
                                                    "\$ ${int.parse(price ?? widget.selectedPrice ?? "0")}",
                                                    style: GoogleFonts.quicksand(
                                                        fontWeight: FontWeight.w700, fontSize: 18, color: Color(0xff000000)),
                                                  ),
                                      );
                                    })
                                  ],
                                ),
                                Obx(() {
                                  if (myCartController.refreshInt.value > 0) {}
                                  CartItems? cartItem;
                                  if (myCartController.isDataLoaded.value &&
                                      myCartController.model.value.data!.cartItems != null) {
                                    final list = myCartController.model.value.data!.cartItems!
                                        .where((element) => element.variantId.toString() == widget.variantId)
                                        .toList();
                                    if (list.isNotEmpty) {
                                      cartItem = list.first;
                                    }
                                  }
                                  return Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child:
                                          cartItem != null
                                              ? Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff0074D9), borderRadius: BorderRadius.circular(25)),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
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
                                                                    product_id: widget.productId.toString(),
                                                                    qty: (int.parse(cartItem!.cartItemQty.toString()) - 1)
                                                                        .toString(),
                                                                    variant_id: widget.variantId.toString())
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

                                                      Obx(() {
                                                        if (myCartController.refreshInt.value > 0) {}
                                                        CartItems? cartItem;
                                                        if (myCartController.isDataLoaded.value &&
                                                            myCartController.model.value.data!.cartItems != null) {
                                                          final list = myCartController.model.value.data!.cartItems!
                                                              .where((element) => element.variantId.toString() == widget.variantId)
                                                              .toList();
                                                          if (list.isNotEmpty) {
                                                            cartItem = list.first;
                                                          }
                                                        }
                                                        return  Text(
                                                          cartItem != null ? cartItem.cartItemQty.toString() : "0",
                                                          style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        );
                                                      }),
                                                      addWidth(7),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (cartItem != null) {
                                                            addToCartRepo(
                                                                    context: context,
                                                                    product_id: singleProductModel!.data!.id.toString(),
                                                                    qty: (int.parse(
                                                                                (cartItem!.cartItemQty ?? "0").toString()) +
                                                                            1)
                                                                        .toString(),
                                                                    variant_id: widget.variantId.toString())
                                                                .then((value) {
                                                              showToast(value.message);
                                                              if (value.status == true) {
                                                                myCartController.getAddToCartList();
                                                              }
                                                            });
                                                          } else {
                                                            addToCartRepo(
                                                                    context: context,
                                                                    product_id: singleProductModel!.data!.id.toString(),
                                                                    qty: 1.toString(),
                                                                    variant_id: widget.variantId.toString())
                                                                .then((value) {
                                                              showToast(value.message);
                                                              if (value.status == true) {
                                                                myCartController.getAddToCartList();
                                                              }
                                                            });
                                                          }
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
                                                    log(widget.variantId.toString());
                                                    log(widget.productId.toString());
                                                    log(myCartController.counter.toString());
                                                    addToCartRepo(
                                                            context: context,
                                                            product_id: widget.productId.toString(),
                                                            qty: 1.toString(),
                                                            variant_id: widget.variantId.toString())
                                                        .then((value) {
                                                      showToast(value.message);
                                                      if (value.status == true) {
                                                        myCartController.getAddToCartList();
                                                        // Get.to(()=>CartScreenOfMart());
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 17, horizontal: 55),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8), color: Color(0xff0074D9)),
                                                    child: Row(
                                                      children: [
                                                        Image.asset("assets/images/bagIcon.png"),
                                                        addWidth(13),
                                                        Text(
                                                          "Add to cart",
                                                          style: GoogleFonts.quicksand(
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 17,
                                                              color: Color(0xffFFFFFF)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                      // : SizedBox(),
                                      );
                                })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    singleProductModel!.data!.relatedProduct!.isNotEmpty ? addHeight(27) : SizedBox(),
                    singleProductModel!.data!.relatedProduct!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "Related Products",
                              style:
                                  GoogleFonts.quicksand(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xff000000)),
                            ),
                          )
                        : SizedBox(),
                    addHeight(8),
                    SizedBox(
                      height: 290,
                      child: GridView.builder(
                          itemCount: singleProductModel!.data!.relatedProduct!.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, crossAxisSpacing: 0, mainAxisExtent: 200, mainAxisSpacing: 7.0),
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, i) {
                            final product = singleProductModel!.data!.relatedProduct![i];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleProductScreenMart(
                                              productId: product.id.toString(),
                                              variantId: product.selectedVariant!.id.toString(),
                                              selectedPrice: product.selectedVariant!.price.toString(),
                                            )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    // color: Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: AddSize.size125,
                                                width: width * .5,
                                                // width: AddSize.size80,
                                                padding: EdgeInsets.all(12),
                                                // width: width * .5,
                                                // height:  height * .15,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: product.image.toString(),
                                                  errorWidget: (_, __, ___) => const SizedBox(),
                                                  placeholder: (_, __) => const SizedBox(),
                                                  fit: BoxFit.cover,
                                                  height: 80,
                                                ),
                                                // Image.asset("assets/images/perfume.png", height: 90,),
                                              ),
                                            ),
                                            Positioned(
                                                top: 10,
                                                right: 13,
                                                child: InkWell(
                                                    onTap: () {
                                                      print("Store wishlist id..${product.id.toString()}");

                                                      wishlistRepo(productId: product.id.toString(), context: context)
                                                          .then((value) {
                                                        if (value.status == true) {
                                                          showToast(value.message);
                                                          getProductInfo();
                                                        }
                                                      });
                                                    },
                                                    child: product.whislist!
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
                                                  product.name.toString(),
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
                                                          variants: product.variants ?? [],
                                                          dropDownValue: product.selectedVariant,
                                                          vv: (Variants variants) {
                                                            product.selectedVariant = variants;
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
                                                          product.avgRating.toString(),
                                                          style: GoogleFonts.ibmPlexSansArabic(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                              color: Color(0xff0F0300)),
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
                                                            element.variantId.toString() ==
                                                            product.selectedVariant!.id.toString())
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
                                                          product.selectedVariant != null
                                                              ? "\$${product.selectedVariant!.price.toString()}"
                                                              : "not available",
                                                          style: GoogleFonts.quicksand(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w700,
                                                              color: Color(0xff000000)),
                                                        ),
                                                        myCartController.isDataLoaded.value && product.variants!.isNotEmpty
                                                            ? cartItem != null
                                                                ? Container(
                                                                    padding:
                                                                        EdgeInsets.symmetric(vertical: 3, horizontal: 5),
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
                                                                                      cartId: cartItem.id.toString(),
                                                                                      context: context)
                                                                                  .then((value) {
                                                                                if (value.status == true) {
                                                                                  myCartController.getAddToCartList();
                                                                                }
                                                                              }).then((value) {});
                                                                            } else {
                                                                              addToCartRepo(
                                                                                      context: context,
                                                                                      product_id: product.id.toString(),
                                                                                      qty: (int.parse(cartItem.cartItemQty
                                                                                                  .toString()) -
                                                                                              1)
                                                                                          .toString(),
                                                                                      variant_id: product.selectedVariant!.id
                                                                                          .toString())
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
                                                                                    product_id: product.id.toString(),
                                                                                    qty: (int.parse(cartItem!.cartItemQty
                                                                                                .toString()) +
                                                                                            1)
                                                                                        .toString(),
                                                                                    variant_id: product.selectedVariant!.id
                                                                                        .toString())
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
                                                                              product_id: product.id.toString(),
                                                                              qty: 1.toString(),
                                                                              variant_id:
                                                                                  product.selectedVariant!.id.toString())
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
                          }),
                    ),
                    addHeight(30),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
      bottomNavigationBar: myCartController.isDataLoaded.value
          ? myCartController.model.value.data!.cartItems!.isNotEmpty
              ? addCartSection()
              : null
          : const SizedBox(),
    );
  }

  Row addRadioButton(int btnValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          hoverColor: const Color(0xFF0074D9),
          activeColor: const Color(0xFF0074D9),
          value: method[btnValue],
          groupValue: selectedSubscribtionTYpe,
          onChanged: (value) {
            setState(() {
              selectedSubscribtionTYpe = value;
            });
          },
        ),
      ],
    );
  }

  buildDropdownButtonFormField(
      {required List<Variants> variants, required Function(Variants variants) vv, Variants? dropDownValue}) {
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
