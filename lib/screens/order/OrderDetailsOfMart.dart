import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/sendFeedbackscreen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/order_details_mart.dart';
import '../../repositories/common_repo/repository.dart';
import '../../resources/api_url.dart';
import '../../resources/app_theme.dart';

class OrderDetailsOfMart extends StatefulWidget {
  final orderId;
  const OrderDetailsOfMart({Key? key, this.orderId}) : super(key: key);
  static var orderDetailsOfMart = "/orderDetailsOfMart";

  @override
  State<OrderDetailsOfMart> createState() => _OrderDetailsOfMartState();
}

class _OrderDetailsOfMartState extends State<OrderDetailsOfMart>
    with TickerProviderStateMixin {
  late TabController tabController;
  Repositories repositories = Repositories();
  OrderDetailsModel? orderDetailsModel;
    getOrderDetails() {
    repositories.getApi(url: "${ApiUrl.martOrderDetailsUrl}?order_id=${widget.orderId}").then((value) {
      orderDetailsModel = OrderDetailsModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getOrderDetails();
    // print("ID is ${orderDetailsModel!.data!.orderId!.toString()}");
    tabController = TabController(length: 2, vsync: this, );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return
      Scaffold(
      appBar: backAppBar2(title: 'Order Details', context: context),
        body:
            orderDetailsModel != null ?
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AddSize.padding16,
            ),
            child:
            orderDetailsModel!.data != null ?
            Column(
                children: [
                  addHeight(10),
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
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/order_details.png',height: 22,),
                          addWidth(15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order ID: ${widget.orderId}',style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Color(0xFF7ED957)
                              ),),
                              addHeight(5),
                              Text(orderDetailsModel!.data!.placedAt.toString(),style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: const Color(0xFF303C5E)
                              ),),

                            ],
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(0xFF7ED957)
                            ),
                            child: Center(
                              child: Text(orderDetailsModel!.data!.deliveryStatus.toString(),
                                style: GoogleFonts.quicksand(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  addHeight(10),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: orderDetailsModel!.data!.orderItems!.length,
                      itemBuilder: (context, index) {
                        final orderDetailsData = orderDetailsModel!.data!.orderItems![index];
                        return Column(

                            children: [

                              GestureDetector(
                                onTap:(){
                                  // Get.toNamed(OrderDetailsOfMart.orderDetailsOfMart);
                                },
                                child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 7),
                                    width: width,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF37C666).withOpacity(0.10),
                                        offset: const Offset(
                                          1,
                                          1,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ]),
                                    child:
                                    Column(crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [

                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(12),
                                                width: width * .25,
                                                // height:  height * .15,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF6F6F6),
                                                    borderRadius: BorderRadius.circular(15)

                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: orderDetailsData.productImage.toString(),
                                                  fit: BoxFit.cover,
                                                  width: 65,
                                                  height: 75,
                                                  errorWidget: (_, __, ___) => Image.asset(
                                                    'assets/images/Ellipse 67.png',
                                                    width: 74,
                                                    height: 82,
                                                  ),
                                                  placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 15),
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          orderDetailsData.productName.toString(),
                                                          style: GoogleFonts.quicksand(
                                                              fontSize: 17, fontWeight: FontWeight.w600, color: const Color(0xFF191723)),
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),

                                                        Text(
                                                          "Quantity: ${orderDetailsData.qty.toString()}",
                                                          style: GoogleFonts.quicksand(
                                                              fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF486769).withOpacity(.50)),
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(mainAxisAlignment: MainAxisAlignment.start,

                                                          children: [
                                                            Text(
                                                              "\$${orderDetailsData.price.toString()}",
                                                              style: GoogleFonts.quicksand(
                                                                  fontSize: 17, fontWeight: FontWeight.w700, color: const Color(0xFF4DBA4D)),
                                                            ),
                                                            SizedBox(width: 20,),
                                                            Text(
                                                              "Tax : \$2.00",
                                                              style: GoogleFonts.quicksand(
                                                                  fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF959595)),
                                                            ),


                                                          ],
                                                        ),
                                                        addHeight(7),
                                                        orderDetailsModel!.data!.deliveryStatus == "Delivered" &&
                                                            orderDetailsData.feedback == false ?
                                                        GestureDetector(
                                                          onTap: (){
                                                            Get.to(()=> SendFeedbackScreen(
                                                                        productId: orderDetailsData.productId.toString(),
                                                                        orderId: orderDetailsModel!.data!.orderId.toString(), onUpdate: () {
                                                              getOrderDetails();
                                                            },
                                                                      ));
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(3),
                                                              border: Border.all(color:Colors.green)
                                                            ),
                                                            child: Text(
                                                              "Give Review",
                                                              style: GoogleFonts.quicksand(
                                                                  fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
                                                            ),
                                                          ),
                                                        ):SizedBox()
                                                      ]),
                                                ),
                                              ) ]),
                                      ],
                                    )


                                ),
                              )
                            ]);
                      }),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(12),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: const Color(0xFF37C666).withOpacity(0.10),
                  //         offset: const Offset(.1, .1,
                  //         ),
                  //         blurRadius: 20.0,
                  //         spreadRadius: 1.0,
                  //       ),
                  //     ],
                  //   ),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: AddSize.padding15,
                  //         vertical: AddSize.padding15),
                  //     child: Column(
                  //       children: [
                  //         ...[
                  //           Row(
                  //             mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Row(children: [
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                   CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "Driver Name",
                  //                       style: GoogleFonts.quicksand(
                  //                           color: Color(0xff486769),
                  //                           fontWeight: FontWeight.w500,
                  //                           fontSize: 14),
                  //                     ),
                  //                     Text(
                  //                       'Rajesh Sharma',
                  //                       style: GoogleFonts.quicksand(
                  //                           height: 1.5,
                  //                           fontWeight: FontWeight.w700,
                  //                           fontSize: 16),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ]),
                  //               Container(
                  //                 height: AddSize.size45,
                  //                 width: AddSize.size45,
                  //                 decoration: const ShapeDecoration(
                  //                     color: Color(0xFFFE7E73),
                  //                     shape: CircleBorder()),
                  //                 child: const Center(
                  //                     child: Icon(
                  //                       Icons.message,
                  //                       color: AppTheme.backgroundcolor,
                  //                     )),
                  //               ),
                  //             ],
                  //           ),
                  //           const Divider(),
                  //           Row(
                  //             mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Row(children: [
                  //                 Column(
                  //                   crossAxisAlignment:
                  //                   CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       "Driver Number",
                  //                       style: GoogleFonts.quicksand(
                  //                           color: Color(0xff486769),
                  //                           fontWeight: FontWeight.w500,
                  //                           fontSize: 14),
                  //                     ),
                  //                     Text(
                  //                       "86859654",
                  //                       style: GoogleFonts.quicksand(
                  //                           color: Color(0xff486769),
                  //                           fontWeight: FontWeight.w700,
                  //                           fontSize: 16),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ]),
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   // _makingPhoneCall("tel:+916565656545");
                  //                 },
                  //                 child: Container(
                  //                     height: AddSize.size45,
                  //                     width: AddSize.size45,
                  //                     decoration: const ShapeDecoration(
                  //                         color: Color(0xFF4DBA4D),
                  //                         shape: CircleBorder()),
                  //                     child: const Center(
                  //                         child: Icon(
                  //                           Icons.phone,
                  //                           color: AppTheme.backgroundcolor,
                  //                         ))),
                  //               ),
                  //             ],
                  //           ),
                  //           const Divider(),
                  //           Row(
                  //             mainAxisAlignment:
                  //             MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Expanded(
                  //                 child: Row(children: [
                  //                   Expanded(
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                       CrossAxisAlignment.start,
                  //                       children:   [
                  //                         Text(
                  //                           "Delivery Address",
                  //                           style: GoogleFonts.quicksand(
                  //                               color: Color(0xff486769),
                  //                               fontWeight: FontWeight.w500,
                  //                               fontSize: 14),
                  //                         ),
                  //                         Text(
                  //                           "United",
                  //                           style: GoogleFonts.quicksand(
                  //                               color: Color(0xff486769),
                  //                               fontWeight: FontWeight.w700,
                  //                               fontSize: 16),
                  //                         ),
                  //                         SizedBox(
                  //                           width: 5,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ]),
                  //               ),
                  //               GestureDetector(
                  //                 onTap: () {
                  //                   // Get.toNamed(MyRouters.chooseAddress);
                  //                 },
                  //                 child: Container(
                  //                   height: AddSize.size45,
                  //                   width: AddSize.size45,
                  //                   decoration: const ShapeDecoration(
                  //                       color: Color(0xFF0074D9),
                  //                       shape: CircleBorder()),
                  //                   child: const Center(
                  //                       child: Icon(
                  //                         Icons.location_on,
                  //                         color: AppTheme.backgroundcolor,
                  //                       )),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ]
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  addHeight(5),
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
                      padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Payment:',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff1A2E33)
                                ),),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFF7ED957),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    orderDetailsModel!.data!.orderType.toString(),
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              )
                            ],
                          ),
                          addHeight(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Subtotal:',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff1A2E33)
                                ),),
                              Spacer(),
                              Text( '\$12.99',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff486769)
                                ),),
                            ],
                          ),
                          addHeight(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Service charge:',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1A2E33)
                                ),),
                              Spacer(),
                              Text( '\$5.00',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff486769)
                                ),),
                            ],
                          ),
                          addHeight(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Delivery:',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1A2E33)
                                ),),
                              Spacer(),
                              Text(
                                "\$${orderDetailsModel!.data!.deliveryCharges.toString()}",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff486769)
                                ),),
                            ],
                          ),
                          addHeight(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Total:',
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff6BC744)
                                ),),
                              Spacer(),
                              Text(
                              "\$${orderDetailsModel!.data!.grandTotal.toString()}",
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff6BC744)
                                ),),
                            ],
                          ),
                          addHeight(20)
                        ],

                      ),
                    ),
                  ),
                  // addHeight(15),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12,right: 12),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Text('Delivery Date',
                  //         style: GoogleFonts.quicksand(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w700,
                  //             color: const Color(0xff1A2E33)
                  //         ),),
                  //       Spacer(),
                  //       Text( '10/12/2023',
                  //         style: GoogleFonts.quicksand(
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w500,
                  //             color: const Color(0xff486769)
                  //         ),),
                  //     ],
                  //   ),
                  // ),
                   addHeight(40),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 12,right: 12),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Text('Status',
                  //         style: GoogleFonts.quicksand(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w700,
                  //             color: const Color(0xff1A2E33)
                  //         ),),
                  //       Spacer(),
                  //       Text( 'Running',
                  //         style: GoogleFonts.quicksand(
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w500,
                  //             color: const Color(0xff486769)
                  //         ),),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: AddSize.size40),

                ]
            ):Center(child: CircularProgressIndicator(),),
          ),
        ):Center(child: CircularProgressIndicator()),
      // ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
      //   child: InkWell(
      //     onTap: () {
      //       Get.to(()=> SendFeedbackScreen(
      //         productId: orderDetailsModel!.data!.orderItems!.map((e) => e.productId.toString()).toList().toString(),
      //       ));
      //     },
      //     child: Container(
      //       height: 56,
      //       width: AddSize.screenWidth / 1.1,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: const Color(0xFF0074D9)
      //       ),
      //       child: Center(
      //         child: Text(
      //           'Send Feedback For Order',
      //           style: GoogleFonts.poppins(
      //             color:  Colors.white,
      //             fontSize: 16,
      //             fontWeight: FontWeight.w700,
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

}
