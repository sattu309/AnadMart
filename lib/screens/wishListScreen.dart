import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/product_screen_ofMart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/My_cart_controller.dart';
import '../controller/home_page_controller.dart';
import '../controller/wishlist_data_controller.dart';
import '../model/My_Cart_Model.dart';
import '../model/homepage_mart_model.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../repositories/wishlist_repo.dart';
import '../resources/app_assets.dart';
import '../widgets/add_text.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);
  static var wishListScreen = "/wishListScreen";

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final wishListController = Get.put(FavoriteListController());
  final myCartController = Get.put(MyCartDataListController());
  final homepageControllerMart = Get.put(HomePageController());

  double fullRating = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      wishListController.getWishListData();
    });

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: backAppBar2(title: "Wishlist", context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            child: Obx(() {
              return
                wishListController.isDataLoading.value ? wishListController.model.value.data!.wishlist!.isNotEmpty?
                Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      itemCount: wishListController.model.value.data!.wishlist!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisExtent: 290,
                          mainAxisSpacing: 7.0),
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final wishListData = wishListController.model.value.data!.wishlist![index];
                        return GestureDetector(
                          onTap: (){
                            Get.to(() => SingleProductScreenMart(
                              productId: wishListData.id.toString(),
                              variantId: wishListData.selectedVarient!.id.toString(),
                              selectedPrice: wishListData.selectedVarient!.price.toString(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              // height: 300,
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
                                           height:  height * .17,
                                          decoration:
                                          BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(10)),
                                          child: CachedNetworkImage(
                                            imageUrl: wishListData.image.toString(),
                                            errorWidget: (_, __, ___) => const SizedBox(),
                                            placeholder: (_, __) => const SizedBox(),
                                            fit: BoxFit.contain,
                                            height: 80,
                                          ),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 13,
                                            child: InkWell(
                                                onTap: () {
                                                  print(wishListData.productId.toString());
                                                  wishlistRepo(productId: wishListData.id.toString(), context: context)
                                                      .then((value) {
                                                    if (value.status == true) {
                                                      showToast(value.message);
                                                      wishListController.getWishListData();
                                                      homepageControllerMart.getHomePageData();
                                                    } else {
                                                      showToast(value.message);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  // padding: EdgeInsets.all(8),
                                                  // margin: EdgeInsets.all(5),
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
                                                ))),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Expanded(
                                      child: StatefulBuilder(builder: (context, newState) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              wishListData.name.toString(),
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
                                                      variants: wishListData.variants ?? [],
                                                      dropDownValue: wishListData.selectedVarient,
                                                      vv: (Variants variants) {
                                                        wishListData.selectedVarient = variants;
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
                                        wishListData.avgRating.toString(),
                                                      style: GoogleFonts.ibmPlexSansArabic(
                                                          fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff0F0300)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                        // addHeight(5),
                                            Obx(() {
                                              if(myCartController.refreshInt.value > 0 ){}
                                              CartItems? cartItem;
                                              if(myCartController.isDataLoaded.value && myCartController.model.value.data!.cartItems != null){
                                                final list = myCartController.model.value.data!.cartItems!.where((element) => element.variantId.toString()== wishListData.selectedVarient!.id.toString()).toList();
                                                if (list.isNotEmpty) {
                                                  cartItem = list.first;
                                                }
                                              }



                                              return Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      wishListData.selectedVarient != null
                                                          ? "\$${wishListData.selectedVarient!.price.toString()}.00"
                                                          : "not available",
                                                      style: GoogleFonts.quicksand(
                                                          fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xff000000)),
                                                    ),
                                                    myCartController.isDataLoaded.value && wishListData.variants!.isNotEmpty
                                                        ? cartItem != null ?
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 3, horizontal: 5),
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
                                                                removeCartItemRepo(cartId: cartItem.id.toString(), context: context)
                                                                    .then((value) {
                                                                  if (value.status == true) {
                                                                    myCartController.getAddToCartList();
                                                                  }
                                                                }).then((value) {});
                                                              } else{
                                                                updateCartRepo(cartItem.id.toString(), int.parse((cartItem.cartItemQty ?? "").toString()) - 1, context).then((value) {
                                                                  showToast(value.message);
                                                                  if (value.status == true) {
                                                                    cartItem!.cartItemQty = int.parse((cartItem.cartItemQty ?? "").toString()) - 1;
                                                                    myCartController.getAddToCartList();
                                                                  }
                                                                  setState(() {});
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
                                                            cartItem.cartItemQty
                                                                .toString(),
                                                            style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 16,
                                                              color: Colors.white,),
                                                          ),
                                                          addWidth(7),
                                                          InkWell(
                                                            onTap: () {
                                                              updateCartRepo(cartItem!.id.toString(), int.parse((cartItem.cartItemQty ?? "").toString()) + 1, context).then((value) {
                                                                showToast(value.message);
                                                                if (value.status == true) {
                                                                  cartItem!.cartItemQty = int.parse((cartItem.cartItemQty ?? "").toString()) + 1;
                                                                  myCartController.getAddToCartList();
                                                                }
                                                                setState(() {});
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
                                                    ) :
                                                    GestureDetector(
                                                      onTap: () {
                                                        addToCartRepo(
                                                            context: context,
                                                            product_id: wishListData.id.toString(),
                                                            qty: 1.toString(),
                                                            variant_id: wishListData.selectedVarient!.id.toString())
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
                                                            child:
                                                            Image.asset("assets/images/plusIcon.png"),
                                                          )
                                                      ),
                                                    ) : SizedBox(),
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
                  // SizedBox(height: height * .03,)
                ],
                              ):Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(child: Column(
                  children: [
                    Image.asset("assets/images/Favaorites.png"),
                    addHeight(5),
                    Text(
                      "No item in wishlist",
                      style: GoogleFonts.ibmPlexSansArabic(
                          fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff0F0300)),
                    ),
                  ],
                ),),
              ):Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Center(child: CircularProgressIndicator(color: Colors.green,)),
              );
            }),
          ),
        ));
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
              .map((e) =>
              DropdownMenuItem(
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
            // newState(() {});
          }),
    );
    // });
  }
}
