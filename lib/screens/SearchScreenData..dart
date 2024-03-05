import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/product_screen_ofMart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/My_cart_controller.dart';
import '../controller/home_page_controller.dart';
import '../controller/wishlist_data_controller.dart';
import '../model/Home_Search_Model.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../repositories/wishlist_repo.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';

class SearchScreenData extends StatefulWidget {
  const SearchScreenData({Key? key}) : super(key: key);
  static var searchScreen = "/searchScreen";
  @override
  State<SearchScreenData> createState() => _SearchScreenDataState();
}

class _SearchScreenDataState extends State<SearchScreenData> {
  final controller = Get.put(HomePageController());
  final wishListController = Get.put(FavoriteListController());
  final myCartController = Get.put(MyCartDataListController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getSearchData();
      controller.searchDataModel.value.data != null
          ? controller.searchDataModel.value.data!.clear()
          : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        leadingWidth: AddSize.size20 * 2.2,
        backgroundColor: Color(0xffF6F6F6),
        title: Text(
          "Search Product",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xff303D48),),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: AddSize.padding20),
          child: GestureDetector(
              onTap: () {
                controller.searchController.text ="";
                Get.back();
                if (dispose == "dispose") {}
              },
              child:
                  Image.asset(
                    "assets/images/backArrow.png",
                    height: AddSize.size25,
                  )),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16, vertical: AddSize.padding10),
          child: Column(
            children: [
              SizedBox(
                height: height * .07,
                child: TextField(
                  maxLines: 1,
                  controller: controller.searchController,
                  style: const TextStyle(fontSize: 17),
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    controller.getSearchData().then((value) {
                      if (value.status == false) {
                        showToast("No data found");
                      }
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.getSearchData().then((value) {
                            if (value.status == false) {
                              showToast("No data found");
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      border: const OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      fillColor: Colors.white,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: width * .04),
                      hintText: 'Search product',
                      hintStyle: TextStyle(
                          fontSize: AddSize.font14,
                          color: AppTheme.blackcolor,
                          fontWeight: FontWeight.w400)),
                ),
              ),
              Obx(() {
                return controller.isDataLoading.value ? (controller.searchDataModel.value.data != null && controller.searchDataModel.value.data!.isNotEmpty)
                    ?
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.searchDataModel.value.data!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisExtent: 280,
                        mainAxisSpacing: 7.0),
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final  searchData = controller.searchDataModel.value.data![index];
                      return
                        GestureDetector(
                          onTap: (){
                            Get.to(() => SingleProductScreenMart(
                              productId: searchData.id.toString(),
                              variantId: searchData.selectedVarient!.id.toString(),
                              selectedPrice: searchData.selectedVarient!.price.toString(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              //height: 300,
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
                                          // height:  height * .15,
                                          decoration: BoxDecoration(
                                              color: Color(0xffF6F6F6),
                                              borderRadius: BorderRadius.circular(10)

                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: searchData.image.toString(),
                                            errorWidget: (_, __, ___) => const SizedBox(),
                                            placeholder: (_, __) => const SizedBox(),
                                            fit: BoxFit.cover,
                                            height: 80,
                                          ),
                                        ),
                                        Positioned(
                                            top: 10,
                                            right: 13,
                                            child: InkWell(
                                                onTap: () {
                                                  wishlistRepo(productId: searchData.id.toString(),context: context).then((value){
                                                    if(value.status == true){
                                                      showToast(value.message);
                                                      wishListController.getWishListData();
                                                      controller.getSearchData();
                                                    }else{
                                                      showToast(value.message);
                                                    }
                                                  });
                                                },
                                                child:
                                                searchData.whislist!
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
                                                )
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 8,),

                                    Expanded(
                                      child: StatefulBuilder(
                                        builder: (BuildContext context, newState) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                searchData.name.toString(),
                                                maxLines: 2,
                                                style: GoogleFonts.ibmPlexSansArabic(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff08141B)),
                                              ),
                                              // addHeight(10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: buildDropdownButtonFormField(
                                                        variants: searchData.variants ?? [],
                                                        dropDownValue: searchData.selectedVarient,
                                                        vv: (Variants variants) {
                                                          searchData.selectedVarient = variants;
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
                                                        searchData.avgRating.toString(),
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

                                                if(myCartController.refreshInt.value > 0){}
                                                  CartItems? cartItem;
                                                  if(myCartController.isDataLoaded.value && myCartController.model.value.data!.cartItems != null){
                                                    final list = myCartController.model.value.data!.cartItems!.where((e) => e.variantId.toString() ==
                                                    searchData.selectedVarient!.id.toString()).toList();
                                                    if(list.isNotEmpty){
                                                      cartItem = list.first;
                                                    }
                                                  }

                                                return Expanded(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        searchData.selectedVarient != null
                                                            ?
                                                        "\$${searchData.selectedVarient!.price.toString()}"
                                                            : "not available",
                                                        style: GoogleFonts.quicksand(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w700,
                                                            color: Color(0xff000000)),
                                                      ),
                                                      myCartController.isDataLoaded.value &&
                                                          searchData.variants!.isNotEmpty
                                                          ? myCartController.model.value.data!.cartItems!
                                                          .map((e) => e.variantId.toString())
                                                          .toList()
                                                          .contains(
                                                          searchData.variants![searchData
                                                              .varientIndex!
                                                              .value]
                                                              .id
                                                              .toString()) ?
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
                                                            onTap: (){
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
                                                             cartItem!.cartItemQty.toString(),
                                                              style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 16,
                                                                color: Colors.white,),
                                                            ),
                                                            addWidth(7),
                                                            InkWell(
                                                           onTap: (){
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
                                                              product_id: searchData.id.toString(),
                                                              qty: 1.toString(),
                                                              variant_id: searchData.selectedVarient!.id.toString())
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
                                            ],
                                          );
                                        },

                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                    })
                    : const Text("No data found"):Center(child: CircularProgressIndicator());
              })
            ],
          ),
        ),
      ),
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
          items:
          variants.map((e) =>
              DropdownMenuItem(
                value: e,
                child: Text(
                  "${e.variantQty} "
                      " ${e.variantQtyType}",
                  style: const TextStyle(fontSize: 16),
                ),
              )).toList(),
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
