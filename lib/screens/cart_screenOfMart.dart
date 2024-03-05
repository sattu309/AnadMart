import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/product_screen_ofMart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/My_cart_controller.dart';
import '../controller/wishlist_data_controller.dart';
import '../repositories/Add_To_Cart_Repo.dart';
import '../repositories/Remove_CartItem_Repo.dart';
import '../repositories/wishlist_repo.dart';
import '../resources/app_assets.dart';
import '../resources/app_text.dart';
import '../widgets/add_text.dart';
import 'checkout_screen_mart.dart';


class CartScreenOfMart extends StatefulWidget {
  static var cartScreenOfMart = "/cartScreenOfMart";

  const CartScreenOfMart({Key? key}) : super(key: key);

  @override
  State<CartScreenOfMart> createState() => _CartScreenOfMartState();
}

class _CartScreenOfMartState extends State<CartScreenOfMart> {
  final myCartController = Get.put(MyCartDataListController());
  final wishListController = Get.put(FavoriteListController());
  final TextEditingController tipController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RxBool customTip = false.obs;
  RxString selectedChip = "".obs;
  final List<String> tips = ["1", "2", "5", "Custom"];
  String getColor = '0xFF#F1F1F1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myCartController.getAddToCartList().then((value) {
        setState(() {});
      });
      // Add Your Code here.
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

    return Obx(() {
      return Scaffold(
          appBar: backAppBar2(title: "My Cart", context: context),
          body:

          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child:
                myCartController.isDataLoaded.value ? myCartController.model.value.data!.cartItems!.isNotEmpty ?
                Column(
                  children: [

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: myCartController.model.value.data!.cartItems!.length,
                      itemBuilder: (context, index) {
                        final cartData = myCartController.model.value.data!.cartItems![index];
                        return
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF37C666).withOpacity(0.10),
                                            offset: const Offset(.1, .1,
                                            ),
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child:
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              width: width * .35,
                                              height: height * .17,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius: BorderRadius.circular(15)

                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child: CachedNetworkImage(
                                                  imageUrl: cartData.image.toString(),
                                                  fit: BoxFit.contain,
                                                  // width: 65,
                                                  height: 75,
                                                  errorWidget: (_, __, ___) =>
                                                      Image.asset(
                                                        'assets/images/Ellipse 67.png',
                                                        width: 74,
                                                        height: 82,
                                                      ),
                                                  placeholder: (_, __) =>
                                                  const Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                            ),
                                            addWidth(22),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          cartData.productName.toString(),
                                                          style: GoogleFonts.quicksand(fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0xff08141B)),),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            removeCartItemRepo( cartId: cartData.id.toString(), context: context,).then((value) {
                                                              if (value.status == true) {
                                                                showToast(value.message);
                                                                myCartController.getAddToCartList();
                                                              }
                                                              else {


                                                                showToast(value.message);
                                                              }
                                                            });
                                                          },
                                                          child: Image.asset('assets/images/cleanIcon.png', height: 20,)),
                                                    ],
                                                  ),
                                                  addHeight(8),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${cartData.variantQty.toString()}',
                                                        style: GoogleFonts.quicksand(fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color(0xff776569)),),
                                                      addWidth(4),
                                                      Text(
                                                        '${cartData.variantQtyType.toString()}',
                                                        style: GoogleFonts.quicksand(fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color(0xff776569)),),

                                                    ],
                                                  ),
                                                  addHeight(5),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '\$${int.parse((cartData.variantPrice == "" ? "0" : cartData.variantPrice).toString()) * int.parse(cartData.cartItemQty.toString())}',
                                                        style: GoogleFonts.quicksand(fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xffBD0028)),),
                                                      addWidth(12),
                                                      Text(
                                                        "Tax: \$10:00",
                                                        // homeController1.model.value
                                                        //     .data!.recommendedStore![index].name
                                                        //     .toString(),
                                                        style: GoogleFonts.quicksand(fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xff776569)),),

                                                    ],
                                                  ),
                                                  addHeight(12),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap:
                                                            () {
                                                              if (cartData!.cartItemQty.toString() == "1") {
                                                                removeCartItemRepo(cartId: cartData.id.toString(), context: context)
                                                                    .then((value) {
                                                                  if (value.status == true) {
                                                                    myCartController.getAddToCartList();
                                                                  }
                                                                }).then((value) {});
                                                              }else{
                                                                updateCartRepo(myCartController.model.value.data!.cartItems![index].id.toString(), int.parse((myCartController.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) - 1, context).then((value) {
                                                                  showToast(value.message);
                                                                  if (value.status == true) {
                                                                    myCartController.model.value.data!.cartItems![index].cartItemQty = int.parse((myCartController.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) - 1;
                                                                    myCartController.getAddToCartList();
                                                                  }
                                                                  setState(() {});
                                                                });
                                                              }
                                                        },
                                                        child: Container(
                                                          // width: 25,
                                                          decoration: BoxDecoration(
                                                              color: Color(0xff0F0300),
                                                              borderRadius: BorderRadius.circular(5),
                                                              // border: Border.all(color: const Color(0xFF72CD4A)),
                                                              shape: BoxShape.rectangle),
                                                          alignment: Alignment.center,
                                                          child: const Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                                            child:
                                                            Text(
                                                              '-',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16,
                                                                  color: Colors.white),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 12, right: 12),
                                                          child: Text(
                                                            cartData.cartItemQty.toString(),
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 19,
                                                                color: Color(0xff000000)),
                                                            // controller.model.value.data!.latestProducts![index].buttonCount.value
                                                            //     .toString(),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                              onTap: () {
                                                            // myCartController.model.value.data!.cartItems![index].maxQty.toString() != myCartController.model.value.data!.cartItems![index].cartItemQty.toString()
                                                           updateCartRepo(myCartController.model.value.data!.cartItems![index].id.toString(), int.parse((myCartController.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) + 1, context).then((value) {
                                                              showToast(value.message);
                                                              if (value.status == true) {
                                                                myCartController.model.value.data!.cartItems![index].cartItemQty = int.parse((myCartController.model.value.data!.cartItems![index].cartItemQty ?? "").toString()) + 1;
                                                                myCartController.getAddToCartList();
                                                              }
                                                              setState(() {});
                                                            });
                                                                // : showToast("You can't add more then ${myCartController.model.value.data!.cartItems![index].maxQty} item");
                                                          },

                                                        child: Container(
                                                          // width: 25,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              color: Color(0xff0F0300),
                                                              // border: Border.all(color: const Color(0xFF72CD4A)),
                                                              shape: BoxShape.rectangle),
                                                          alignment: Alignment.center,
                                                          child: const Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                                            child: Text(
                                                              '+',
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16,
                                                                  color: Colors.white),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      )
                                  ),
                                  // Positioned(
                                  //   top: 12,
                                  //   right: 12,
                                  //   child:
                                  //   GestureDetector(
                                  //       onTap: () {
                                  //         removeCartItemRepo( cartId: cartData.id.toString(), context: context,).then((value) {
                                  //           if (value.status == true) {
                                  //             showToast(value.message);
                                  //             myCartController.getAddToCartList();
                                  //           }
                                  //           else {
                                  //
                                  //
                                  //             showToast(value.message);
                                  //           }
                                  //         });
                                  //       },
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.only(left: 8,),
                                  //         child: Image.asset('assets/images/cleanIcon.png', height: 20,),
                                  //       )),),
                                  Positioned(
                                      top: 18,
                                      left: 105,
                                      child: InkWell(
                                          onTap: () {
                                            wishlistRepo(productId: cartData.productId.toString(),context: context).then((value){
                                              if(value.status == true){
                                                showToast(value.message);
                                                wishListController.getWishListData();
                                                myCartController.getAddToCartList();
                                              }else{
                                                showToast(value.message);
                                              }
                                            });
                                          },
                                          child:
                                          cartData.whislist!
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
                              addHeight(13)
                            ],
                          );
                      },
                    ),
                    addHeight(1),
                    myCartController.model.value.data!.cartItems!.isNotEmpty ?
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF37C666).withOpacity(0.10),
                            offset: const Offset(.1, .1,
                            ),
                            blurRadius: 20.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Subtotal:',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff191723)
                                    ),),
                                  const Spacer(),
                                  Text(
                                    "\$${myCartController.model.value.data!.cartPaymentSummary!.subTotal.toString()}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff95A0A3)
                                    ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Tax:',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff191723)
                                    ),),
                                  const Spacer(),
                                  Text(
                                    '\$0',
                                    // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff95A0A3)
                                    ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Delivery:',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff191723)
                                    ),),
                                  const Spacer(),
                                  Text(
                                    "\$${myCartController.model.value.data!.cartPaymentSummary!.deliveryCharge.toString()}",
                                    // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff95A0A3)
                                    ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Total:',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff191723)
                                    ),),
                                  const Spacer(),
                                  Text(
                                    "\$${myCartController.model.value.data!.cartPaymentSummary!.total.toString()}",
                                    // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff95A0A3)
                                    ),),
                                ],
                              ),
                            ),
                            addHeight(28),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: CommonButton(title: 'Checkout', onPressed: () {
                                Get.toNamed(CheckoutScreenMart.checkoutScreenOfMart);
                              },),
                            ),
                            addHeight(10),
                          ],


                        ),
                      ),
                    ) : SizedBox(),


                    addHeight(40),
                  ],
                ) :
                Padding(
                  padding: const EdgeInsets.only(top: 90, left: 10,right: 10),
                  child: Center(child:
                               Column(
                                 children: [
                   Image.asset("assets/images/cartImg.png"),
                   addHeight(5),
                   Text(
                     "No item in cart",
                     style: GoogleFonts.ibmPlexSansArabic(
                         fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff0F0300)),
                   )
                                 ],
                               )),
                ) : Center(child: CircularProgressIndicator(),),

              ),

            ),
          )
      );
    });
  }
// chipList(
//     title,
//     ) {
//   var height = MediaQuery.of(context).size.height;
//   var width = MediaQuery.of(context).size.width;
//   return Obx(() {
//     return GestureDetector(
//       onTap: () {},
//       child: ChoiceChip(
//         padding: EdgeInsets.symmetric(
//             horizontal: width * .01, vertical: height * .01),
//         backgroundColor: AppTheme.backgroundcolor,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: BorderSide(
//                 color: title != selectedChip.value
//                     ? Colors.grey.shade300
//                     : const Color(0xff7ED957))),
//         label: Text(title == "Custom" ? "$title" : "€$title",
//             style: TextStyle(
//                 color: title != selectedChip.value
//                     ? Colors.grey.shade600
//                     : Colors.white,
//                 fontSize: AddSize.font14,
//                 fontWeight: FontWeight.w500)),
//         selected: title == selectedChip.value,
//         selectedColor: const Color(0xff7ED957),
//         onSelected: (value) {
//           selectedChip.value = title;
//           if (title == "Custom") {
//             customTip.value = true;
//             tipController.text = "";
//           } else {
//             customTip.value = false;
//             tipController.text = title;
//           }
//           tipController.text != ""
//               ? orderTip(tipAmount: tipController.text, context: context)
//               .then((value) {
//             showToast(value.message);
//             if (value.status == true) {
//               // controller.getData();
//             }
//           })
//               : null;
//           setState(() {});
//         },
//       ),
//     );
//   });
// }
}
