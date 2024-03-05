import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/thankyou_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/My_cart_controller.dart';
import '../controller/wishlist_data_controller.dart';
import '../repositories/apply_coupons_repository.dart';
import '../repositories/check_out_repository.dart';
import '../repositories/wishlist_repo.dart';
import '../resources/app_assets.dart';
import '../resources/app_text.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'add_new_card_Mart.dart';
import 'coupons_screen.dart';
import 'my_address.dart';

class CheckoutScreenMart extends StatefulWidget {
  static var checkoutScreenOfMart = "/checkoutScreenOfMart";

  const CheckoutScreenMart({Key? key}) : super(key: key);

  @override
  State<CheckoutScreenMart> createState() => _CheckoutScreenMartState();
}

class _CheckoutScreenMartState extends State<CheckoutScreenMart> {
  // final TextEditingController tipController = TextEditingController();
  final myCartController = Get.put(MyCartDataListController());
  final wishListController = Get.put(FavoriteListController());
  final _formKey = GlobalKey<FormState>();
  // RxBool customTip = false.obs;
  // RxString selectedChip = "".obs;
  // final List<String> tips = ["1", "2", "5", "Custom"];
  // String getColor = '0xFF#F1F1F1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myCartController.getAddToCartList();

      // Add Your Code here.
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Obx(() {
      return Scaffold(
          appBar: backAppBar2(title: "Checkout", context: context),
          body: myCartController.model.value.data != null
              ? SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: [
                            // addHeight(5),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: myCartController.model.value.data!.cartItems!.length,
                              itemBuilder: (context, index) {
                                final checkOutData = myCartController.model.value.data!.cartItems![index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF37C666).withOpacity(0.10),
                                                offset: const Offset(
                                                  .1,
                                                  .1,
                                                ),
                                                blurRadius: 20.0,
                                                spreadRadius: 1.0,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(12),
                                                      width: width * .32,
                                                      height:  height * .15,
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(13)),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: CachedNetworkImage(
                                                          imageUrl: checkOutData.image.toString(),
                                                          fit: BoxFit.contain,
                                                          width: 65,
                                                          height: 75,
                                                          errorWidget: (_, __, ___) => Image.asset(
                                                            'assets/images/Ellipse 67.png',
                                                            width: 74,
                                                            height: 82,
                                                          ),
                                                          placeholder: (_, __) =>
                                                              const Center(child: CircularProgressIndicator()),
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(8.0),
                                                      //   child: Image.asset("assets/images/perfume.png", height: 65,),
                                                      // ),
                                                    ),
                                                    Positioned(
                                                        top: 8,
                                                        right: 10,
                                                        child: InkWell(
                                                            onTap: () {
                                                              wishlistRepo(productId: checkOutData.productId.toString(),context: context).then((value){
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
                                                            checkOutData.whislist!
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
                                                addWidth(35),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              checkOutData.productName.toString(),
                                                              style: GoogleFonts.quicksand(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Color(0xff08141B)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      addHeight(8),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${checkOutData.variantQty.toString()}',
                                                            style: GoogleFonts.quicksand(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                color: Color(0xff776569)),
                                                          ),
                                                          addWidth(4),
                                                          Text(
                                                            '${checkOutData.variantQtyType.toString()}',
                                                            style: GoogleFonts.quicksand(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w500,
                                                                color: Color(0xff776569)),
                                                          ),
                                                        ],
                                                      ),
                                                      addHeight(5),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "\$${checkOutData.variantPrice.toString()}",
                                                            style: GoogleFonts.quicksand(
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w600,
                                                                color: Color(0xffBD0028)),
                                                          ),
                                                          addWidth(8),
                                                          Text(
                                                            "Tax: \$10:00",
                                                            // homeController1.model.value
                                                            //     .data!.recommendedStore![index].name
                                                            //     .toString(),
                                                            style: GoogleFonts.quicksand(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600,
                                                                color: Color(0xff776569)),
                                                          ),
                                                        ],
                                                      ),
                                                      addHeight(8),
                                                      Text(
                                                        "Qty ${checkOutData.variantQty.toString()}",
                                                        style: GoogleFonts.quicksand(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xff776569)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      addHeight(10)
                                    ],
                                  ),
                                );
                              },
                            ),
                            // Card(
                            //   color: Color(0xffFFFFFF),
                            //     elevation: 0,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: Padding(
                            //       padding: EdgeInsets.symmetric(
                            //         horizontal: width * .035,
                            //         vertical: height * .022,
                            //       ),
                            //       child: Column(
                            //         children: [
                            //           InkWell(
                            //               onTap: () {
                            //                 // Get.toNamed(
                            //                     // CouponsScreen.couponsScreen);
                            //               },
                            //               child: Row(children: [
                            //                 Expanded(
                            //                   child: Row(children: [
                            //                     const Image(
                            //                         height: 22,
                            //                         width: 28,
                            //                         image: AssetImage(AppAssets
                            //                             .coupons_image)),
                            //                     const SizedBox(
                            //                       width: 17,
                            //                     ),
                            //                     Text("Use Coupons",
                            //                         style: GoogleFonts.quicksand(
                            //                             color: Color(0xff293044),
                            //                             fontSize:16,
                            //                             fontWeight:
                            //                             FontWeight.w600)),
                            //                   ]),
                            //                 ),
                            //                 // Icon(
                            //                 //   Icons.arrow_forward_ios,
                            //                 //   color: Colors.black,
                            //                 //   size: AddSize.size15,
                            //                 // ),
                            //               ])),
                            //           addHeight(12),
                            //           Row(
                            //             crossAxisAlignment: CrossAxisAlignment.start,
                            //               mainAxisAlignment:
                            //               MainAxisAlignment
                            //                   .spaceBetween,
                            //               children: [
                            //                 Container(
                            //                   height: 20,
                            //                   width: 20,
                            //                   decoration:
                            //                   const ShapeDecoration(
                            //                       color: AppTheme
                            //                           .userActive,
                            //                       shape:
                            //                       CircleBorder()),
                            //                   child: Center(
                            //                       child: Icon(
                            //                         Icons.check,
                            //                         color: AppTheme
                            //                             .backgroundcolor,
                            //                         size: AddSize.size12,
                            //                       )),
                            //                 ),
                            //                 const SizedBox(
                            //                   width: 17,
                            //                 ),
                            //                 Expanded(
                            //                   child: Column(
                            //                     crossAxisAlignment:
                            //                     CrossAxisAlignment
                            //                         .start,
                            //                     children: [
                            //                       Text(
                            //                         "WELCOME50 applied successfully ",
                            //                           // "${controller.model.value.data!.cartPaymentSummary!.couponCode.toString()} applied successfully",
                            //                           style: TextStyle(
                            //                               color: Color(0xff1E2538).withOpacity(.5),
                            //                               fontSize:
                            //                               AddSize
                            //                                   .font14,
                            //                               fontWeight:
                            //                               FontWeight
                            //                                   .w500)),
                            //                       addHeight(7),
                            //                       Text(
                            //                         "You saved \$5 ",
                            //                           // "You saved ₹${controller.model.value.data!.cartPaymentSummary!.couponDiscount.toString()}",
                            //                           style: GoogleFonts.quicksand(
                            //                               color: Color(0xff0074D9),
                            //                               fontSize: 13,
                            //                               fontWeight:
                            //                               FontWeight
                            //                                   .w500)),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 // TextButton(
                            //                 //   onPressed: () {
                            //                 //     removeCoupons(
                            //                 //         context: context)
                            //                 //         .then((value) {
                            //                 //       showToast(
                            //                 //           value.message);
                            //                 //       if (value.status ==
                            //                 //           true) {
                            //                 //         controller
                            //                 //             .getAddToCartList();
                            //                 //       }
                            //                 //     });
                            //                 //   },
                            //                 //   style: TextButton.styleFrom(
                            //                 //       padding:
                            //                 //       EdgeInsets.zero),
                            //                 //   child: Text("Remove",
                            //                 //       style: TextStyle(
                            //                 //           color: Colors.red,
                            //                 //           fontSize:
                            //                 //           AddSize.font12,
                            //                 //           fontWeight:
                            //                 //           FontWeight
                            //                 //               .w500)),
                            //                 // ),
                            //               ]),
                            //         ],
                            //       ),
                            //     )),
                            Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * .03,
                                    vertical: height * .02,
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Get.toNamed(CouponsScreen.couponsScreen);
                                          },
                                          child: Row(children: [
                                            Expanded(
                                              child: Row(children: [
                                                const Image(
                                                    height: 22, width: 28, image: AssetImage(AppAssets.coupons_image)),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text("Use Coupons",
                                                    style: TextStyle(
                                                        color: AppTheme.blackcolor,
                                                        fontSize: AddSize.font14,
                                                        fontWeight: FontWeight.w500)),
                                              ]),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: AddSize.size15,
                                            ),
                                          ])),
                                      myCartController.model.value.data!.cartPaymentSummary!.couponDiscount == 0 &&
                                              myCartController.model.value.data!.cartPaymentSummary!.couponCode.toString() ==
                                                  ""
                                          ? const SizedBox()
                                          : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration:
                                                    const ShapeDecoration(color: AppTheme.userActive, shape: CircleBorder()),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.check,
                                                  color: AppTheme.backgroundcolor,
                                                  size: AddSize.size12,
                                                )),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${myCartController.model.value.data!.cartPaymentSummary!.couponCode.toString()} applied successfully",
                                                        style: TextStyle(
                                                            color: AppTheme.userActive,
                                                            fontSize: AddSize.font14,
                                                            fontWeight: FontWeight.w500)),
                                                    Text(
                                                        "You saved ₹${myCartController.model.value.data!.cartPaymentSummary!.couponDiscount.toString()}",
                                                        style: TextStyle(
                                                            color: AppTheme.userActive,
                                                            fontSize: AddSize.font12,
                                                            fontWeight: FontWeight.w500)),
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  removeCoupons(context: context).then((value) {
                                                    showToast(value.message);
                                                    if (value.status == true) {
                                                      myCartController.getAddToCartList();
                                                    }
                                                  });
                                                },
                                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                                child: Text("Remove",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: AddSize.font12,
                                                        fontWeight: FontWeight.w500)),
                                              ),
                                            ]),
                                    ],
                                  ),
                                )),
                            addHeight(10),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(MyAddress.myAddressScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF37C666).withOpacity(0.10),
                                      offset: const Offset(
                                        .1,
                                        .1,
                                      ),
                                      blurRadius: 20.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 23, top: 10, bottom: 10, right: 25),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Deliver to',
                                            style: GoogleFonts.poppins(
                                                fontSize: 18, fontWeight: FontWeight.w600, color: const Color(0xff1A2E33)),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(0xFF04666E),
                                            size: 17,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, bottom: 15, right: 5),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/images/Group 1000004233.png',
                                            height: 36,
                                          ),
                                          addWidth(10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  myCartController.model.value.data!.orderAddress != null
                                                      ? myCartController.model.value.data!.orderAddress!.addressType
                                                          .toString()
                                                      : "Choose address",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xff1A2E33)),
                                                ),
                                                myCartController.model.value.data!.orderAddress != null
                                                    ? Text(
                                                        "${myCartController.model.value.data!.orderAddress!.address1} ${myCartController.model.value.data!.orderAddress!.address2} ${myCartController.model.value.data!.orderAddress!.city} ${myCartController.model.value.data!.orderAddress!.state} ${myCartController.model.value.data!.orderAddress!.zipCode}",
                                                        style: GoogleFonts.quicksand(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            color: const Color(0xff1E2538)),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                          // const Spacer(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            addHeight(10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF37C666).withOpacity(0.10),
                                    offset: const Offset(
                                      .1,
                                      .1,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment Method',
                                      style: GoogleFonts.alegreyaSans(
                                          fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xff000000)),
                                    ),
                                    addHeight(16),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(AddNewCardScreenMart.addNewCardScreenMart);
                                          },
                                          child: Container(
                                            width: 41,
                                            height: 57,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(42),
                                                border: Border.all(color: const Color(0xFFF2F2F2))),
                                            child: const Center(
                                                child: Icon(
                                              Icons.add,
                                              color: Color(0xFF7DD856),
                                            )),
                                          ),
                                        ),
                                        addWidth(5),
                                        Container(
                                          height: 60,
                                          width: 57,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
                                              border: Border.all(color: const Color(0xFFF2F2F2))),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/mastercard.png',
                                            height: 36,
                                          )),
                                        ),
                                        addWidth(5),
                                        Container(
                                          height: 60,
                                          width: 57,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
                                              border: Border.all(color: const Color(0xFFF2F2F2))),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/paytm_img.png',
                                            height: 30,
                                          )),
                                        ),
                                        addWidth(5),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          height: 60,
                                          // width: 57,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
                                              border: Border.all(color: const Color(0xFFF2F2F2))),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/google_pay.png',
                                            height: 20,
                                          )),
                                        ),
                                        addWidth(5),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          height: 60,
                                          // width: 57,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(14),
                                              border: Border.all(color: const Color(0xFFF2F2F2))),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/paypal.png',
                                            height: 20,
                                          )),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            addHeight(10),
                            myCartController.model.value.data!.cartItems!.isNotEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF37C666).withOpacity(0.10),
                                          offset: const Offset(
                                            .1,
                                            .1,
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
                                                Text(
                                                  'Subtotal:',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff191723)),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "\$${myCartController.model.value.data!.cartPaymentSummary!.subTotal.toString()}",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xff95A0A3)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Tax:',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff191723)),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '\$0',
                                                  // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xff95A0A3)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Delivery:',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff191723)),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "\$${myCartController.model.value.data!.cartPaymentSummary!.deliveryCharge.toString()}",
                                                  // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xff95A0A3)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Total:',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff191723)),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  "\$${myCartController.model.value.data!.cartPaymentSummary!.total.toString()}",
                                                  // '€ ${controller.model.value.data!.cartPaymentSummary!.subTotal.toString()}',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xff95A0A3)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          addHeight(28),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5, right: 5),
                                            child: CommonButton1(
                                              title: 'Checkout',
                                              onPressed: () {
                                                if (myCartController.model.value.data!.orderAddress != null) {
                                                  checkOut(payment_type: 'cod', context: context).then((value) {
                                                    if (value.status == true) {
                                                      showToast(value.message);
                                                      Get.to(ThankYouScreen(
                                                        orderId: "#${value.data!.orderId.toString()}",
                                                        orderDate: value.data!.placedAt.toString(),
                                                        subTotal: "\$${value.data!.itemTotal.toString()}",
                                                        deliveryCharges: '\$${value.data!.deliveryCharges.toString()}',
                                                        total: '\$${value.data!.grandTotal.toString()}',
                                                      ));
                                                      // Get.toNamed(ThankYouScreen.thankYouScreen);
                                                    } else {
                                                      showToast(value.message);
                                                    }
                                                  });
                                                } else {
                                                  showToast("Please Choose address");
                                                }
                                              },
                                            ),
                                          ),
                                          addHeight(10),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),

                            addHeight(20),
                          ],
                        ),
                      )),
                )
              : Center(child: CircularProgressIndicator())
          // Padding(
          //   padding: const EdgeInsets.all(30.0),
          //   child: Column(
          //     children: [
          //       const SizedBox(height: 60,),
          //       Image.asset('assets/images/emptyCartImg.png'),
          //       const SizedBox(height: 10,),
          //       const Text("No Product",style: TextStyle(fontWeight: FontWeight.w700,color: Color(0xff000000),fontSize: 22),),
          //     ],
          //   ),
          // ) :const Center(child: CircularProgressIndicator()),
          );
    });
  }
}
