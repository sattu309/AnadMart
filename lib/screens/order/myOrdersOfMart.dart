import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/order/OrderDetailsOfMart.dart';
import 'package:fresh2_arrive/screens/cart_screenOfMart.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/my_orders_mart_moder.dart';
import '../../model/time_model.dart';
import '../../repositories/Add_To_Cart_Repo.dart';
import '../../repositories/common_repo/repository.dart';
import '../../resources/app_assets.dart';
import '../../widgets/dimensions.dart';

class MyOrdersOfMart extends StatefulWidget {
  const MyOrdersOfMart({Key? key}) : super(key: key);
  static var referAndEarnScreen = "/referAndEarnScreen";

  @override
  State<MyOrdersOfMart> createState() => _MyOrdersOfMartState();
}

class _MyOrdersOfMartState extends State<MyOrdersOfMart> {
  final key = GlobalKey<ScaffoldState>();
  var currentDrawer = 0;
  String? selectedTime;
  String dropdownvalue = 'Today';
  var items = [
    'Today',
    'This Week',
    'This Month',
    'Last Year',
  ];
  Repositories repositories = Repositories();
  MyOrdersMart? myOrdersMart;

  getMyOrders(String filter) {
    repositories.getApi(url: "${ApiUrl.myOrdersUrl}?filter=$filter").then((value) {
      myOrdersMart = MyOrdersMart.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  //




  @override
  void initState() {
    super.initState();
    getMyOrders("");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              leading:
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Image.asset(
                    "assets/images/backArrow.png",
                    height: AddSize.size25,
                  ),
                ),
              ),
              elevation: 1,
              title: Text(
                "My Orders",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  Container(
                    // height: 15,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: const Color(0xFFEEEEEE))),
                    child:
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isDense: true,
                        hint: Text(
                          'Choose option'
                              '',
                          style: TextStyle(
                              color: AppTheme.userText,
                              fontSize: AddSize.font14,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                        ),
                        isExpanded: false,
                        style: const TextStyle(
                          color: Color(0xFF697164),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        value: selectedTime,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF000000),
                        ),
                        items: timeData.map((value) {
                          return DropdownMenuItem(
                            value: value.key.toString(),
                            child: Text(
                              value.value,
                              style: TextStyle(
                                fontSize: AddSize.font14,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedTime =
                            newValue as String?;
                            log(selectedTime.toString());
                            getMyOrders(selectedTime.toString());

                            // newValue!;
                            // if (newValue != "custom") {
                            //   myOrderController
                            //       .getMyOrder();
                            // } else {
                            //   myOrderController
                            //       .selectedDate.value =
                            //       DateTime.now()
                            //           .subtract(
                            //           const Duration(
                            //               days: 5))
                            //           .toString();
                            //   myOrderController
                            //       .selectedDate1.value =
                            //       DateTime.now().toString();
                            // }
                          });
                        },
                      ),
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.primaryColor,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                // automaticIndicatorColorAdjustment: true,
                onTap: (value) {
                  currentDrawer = 0;
                  setState(() {});
                },
                tabs: [
                  Tab(
                    child: Text(
                      "Active",
                      style: currentDrawer == 0
                          ? GoogleFonts.poppins(color: const Color(0xff1A2E33), fontSize: 16, fontWeight: FontWeight.w500)
                          : GoogleFonts.poppins(color: AppTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Completed",
                      style: currentDrawer == 1
                          ? GoogleFonts.poppins(color: Colors.cyan, fontSize: 16, fontWeight: FontWeight.w500)
                          : GoogleFonts.poppins(color: Color(0xff1A2E33), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Cancelled",
                      style: currentDrawer == 1
                          ? GoogleFonts.poppins(color: Colors.cyan, fontSize: 16, fontWeight: FontWeight.w500)
                          : GoogleFonts.poppins(color: Color(0xff1A2E33), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
            myOrdersMart != null ? myOrdersMart!.data!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: myOrdersMart!.data!.length,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        final myOrderData = myOrdersMart!.data![index].orderItems;
                        if(myOrdersMart!.data![index].deliveryStatus != "Delivered" &&
                            myOrdersMart!.data![index].deliveryStatus != "Cancel"){
                          return Column(children: [

                            GestureDetector(
                              onTap: () {
                                print("Order id is"+myOrdersMart!.data!.first.orderId.toString());
                                Get.to(()=>OrderDetailsOfMart(orderId: myOrdersMart!.data![index].orderId.toString()));
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                                  width: size.width,
                                  padding: const EdgeInsets.all(14),
                                  decoration:
                                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                                  color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(15)),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(5),
                                                child:
                                                CachedNetworkImage(
                                                  imageUrl: myOrderData!.first.productImage.toString(),
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
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 15),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              myOrderData!.first.productName.toString(),
                                                              style: GoogleFonts.quicksand(
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: const Color(0xFF191723)),
                                                            ),
                                                          ),
                                                          // addWidth(20),
                                                          Text(
                                                            "Subscription",
                                                            style: GoogleFonts.quicksand(
                                                                fontSize: 11,
                                                                fontWeight: FontWeight.w600,
                                                                color: const Color(0xFF4DBA4D)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "${myOrderData.first.qty.toString()} Item",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 11,
                                                                fontWeight: FontWeight.w300,
                                                                color: const Color(0xFF74848C)),
                                                          ),
                                                          SizedBox(
                                                              height: 15,
                                                              child: VerticalDivider(
                                                                thickness: 2,
                                                              )),
                                                          Text(
                                                            "1.5km",
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 11,
                                                                fontWeight: FontWeight.w300,
                                                                color: const Color(0xFF74848C)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "\$${myOrderData.first.price.toString()}",
                                                            style: GoogleFonts.quicksand(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w600,
                                                                color: const Color(0xFF000000)),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          SizedBox(
                                                            // width: size.width,
                                                            height: 28,

                                                            child: ElevatedButton(
                                                              onPressed: () {},
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor: const Color(0xFF4DBA4D),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5),
                                                                    // side: const BorderSide(
                                                                    //   width: 2.0,
                                                                    //   color: const Color(0xFFFFA1A1),
                                                                    // )
                                                                  ),
                                                                  primary: const Color(0xFFFFA1A1),
                                                                  textStyle: const TextStyle(
                                                                      fontSize: 18, fontWeight: FontWeight.w500)),
                                                              child: Text(
                                                                "COD",
                                                                style: GoogleFonts.quicksand(
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                              ),
                                            )
                                          ]),
                                      Divider(
                                        height: 40,
                                        color: Color(0xffE8E8E8),
                                        thickness: 1,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 28,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                cancelOrderRepo(
                                                  orderId: myOrdersMart!.data![index].orderId.toString(),
                                                  status: 'C',
                                                  context: context,).then((value){
                                                  if(value.status==true){
                                                    showToast(value.message);
                                                    getMyOrders("");
                                                  }else{
                                                    showToast(value.message);
                                                  }
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                      side: const BorderSide(
                                                        width: 1,
                                                        color: const Color(0xFF4DBA4D),
                                                      )),
                                                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                                child: Text(
                                                  "Cancel Order",
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          SizedBox(
                                            // width: size.width,
                                            height: 28,

                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFF4DBA4D),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5),
                                                      side: const BorderSide(
                                                        width: 2.0,
                                                        color: const Color(0xFF4DBA4D),
                                                      )),
                                                  primary: const Color(0xFF4DBA4D),
                                                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                              child: Text(
                                                "Track Order",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            )

                          ]);
                        }else{
                         return SizedBox();
                        }


                      })
                  :
            Column(
                      children: [
                        addHeight(20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width,
                            margin: EdgeInsets.only(
                              top: 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(AppAssets.orderEmpty),
                                Text(
                                  'Empty',
                                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'You do not have an active order of this time',
                                  style:
                                      GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xff747474)),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ):Center(child: CircularProgressIndicator(color: Colors.green,),),
              myOrdersMart != null ? myOrdersMart!.data!.isNotEmpty ?
              ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: myOrdersMart!.data!.length,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    final completedData = myOrdersMart!.data![index].orderItems;
                    return
                      Column(children: [
                      myOrdersMart!.data![index].deliveryStatus == "Delivered" ?
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>OrderDetailsOfMart(orderId: myOrdersMart!.data![index].orderId.toString(),));
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                            width: size.width,

                            padding: const EdgeInsets.all(14),
                            decoration:
                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        width: width * .25,
                                        // height:  height * .15,
                                        decoration:
                                            BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(15)),
                                        child: CachedNetworkImage(
                                          imageUrl: completedData!.first.productImage.toString(),
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
                                                  completedData!.first.productName.toString(),
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF191723)),
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${completedData!.first.qty.toString()} item',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w300,
                                                          color: const Color(0xFF74848C)),
                                                    ),
                                                    SizedBox(
                                                        height: 15,
                                                        child: VerticalDivider(
                                                          thickness: 2,
                                                        )),
                                                    Text(
                                                      "1.5km",
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w300,
                                                          color: const Color(0xFF74848C)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '\$${completedData!.first.price.toString()}',
                                                      style: GoogleFonts.quicksand(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color: const Color(0xFF000000)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    SizedBox(
                                                      // width: size.width,
                                                      height: 28,

                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: const Color(0xFF4DBA4D),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5),
                                                              // side: const BorderSide(
                                                              //   width: 2.0,
                                                              //   color: const Color(0xFFFFA1A1),
                                                              // )
                                                            ),
                                                            primary: const Color(0xFFFFA1A1),
                                                            textStyle:
                                                                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                                        child: Text(
                                                          "Completed",
                                                          style: GoogleFonts.quicksand(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      )
                                    ]),
                                Divider(
                                  height: 40,
                                  color: Color(0xffE8E8E8),
                                  thickness: 1,
                                ),
                                Row(
                                  children: [

                                    SizedBox(
                                      // width: size.width,
                                      height: 28,

                                      child: ElevatedButton(
                                        onPressed: () {
                                          print("Re-order ID"+myOrdersMart!.data![index].orderId.toString());
                                          reOrderRepo(id: myOrdersMart!.data![index].orderId.toString() ,context: context).then((value){
                                            if(value.status==true){
                                              showToast(value.message);
                                              Get.to(CartScreenOfMart());
                                            }else{
                                              showToast(value.message);
                                            }

                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                                side: const BorderSide(
                                                  width: 1,
                                                  color: const Color(0xFF4DBA4D),
                                                )),
                                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                        child: Text(
                                          "    Order Again    ",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      // width: size.width,
                                      height: 28,

                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                                side: const BorderSide(
                                                  width: 1,
                                                  color: const Color(0xFF4DBA4D),
                                                )),
                                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                        child: Text(
                                          "Refund",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ): index == 0 && !myOrdersMart!.data!.map((element) =>
                      element.deliveryStatus == 'Delivered').toList().contains(true) ?
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(AppAssets.orderEmpty),
                                Text(
                                  'Empty',
                                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'You do not have an active order of this time',
                                    style:
                                    GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xff747474)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ):SizedBox()
                    ]);
                  }) :
              Column(
                children: [
                  addHeight(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width,
                      margin: EdgeInsets.only(
                        top: 18,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.orderEmpty),
                          Text(
                            'Empty',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'You do not have an completed order of this time',
                            style:
                            GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xff747474)),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ):Center(child: CircularProgressIndicator(color: Colors.green,),),
              myOrdersMart != null ? myOrdersMart!.data!.isNotEmpty ?
              ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: myOrdersMart!.data!.length,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    final cancelledData = myOrdersMart!.data![index].orderItems;
                    return Column(children: [
                      myOrdersMart!.data![index].deliveryStatus == 'Cancel' ?
                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                            width: size.width,
                            padding: const EdgeInsets.all(14),
                            decoration:
                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12),
                                        width: width * .25,
                                        // height:  height * .15,
                                        decoration:
                                            BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.circular(15)),
                                        child: CachedNetworkImage(
                                          imageUrl: cancelledData!.first.productImage.toString(),
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
                                                  cancelledData!.first.productName.toString(),
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF191723)),
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${cancelledData!.first.qty.toString()} item",
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w300,
                                                          color: const Color(0xFF74848C)),
                                                    ),
                                                    SizedBox(
                                                        height: 15,
                                                        child: VerticalDivider(
                                                          thickness: 2,
                                                        )),
                                                    Text(
                                                      "1.5km",
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w300,
                                                          color: const Color(0xFF74848C)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "\$${cancelledData!.first.price.toString()}",
                                                      style: GoogleFonts.quicksand(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color: const Color(0xFF000000)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    SizedBox(
                                                      // width: size.width,
                                                      height: 28,

                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: const Color(0xFFFFA1A1),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(5),
                                                                side: const BorderSide(
                                                                  width: 2.0,
                                                                  color: const Color(0xFFFFA1A1),
                                                                )),
                                                            primary: const Color(0xFFFFA1A1),
                                                            textStyle:
                                                                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                                                        child: Text(
                                                          "Cancelled",
                                                          style: GoogleFonts.quicksand(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xFFFF4141),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      )
                                    ]),
                              ],
                            )),
                      ):index == 0 && !myOrdersMart!.data!.map((element) =>
                      element.deliveryStatus == 'Cancel').toList().contains(true) ?Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 18,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(AppAssets.orderEmpty),
                                Text(
                                  'Empty',
                                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'You do not have an active order of this time',
                                    style:
                                    GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xff747474)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ):SizedBox(),
                    ]);
                  }):
              Column(
                children: [
                  addHeight(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width,
                      margin: EdgeInsets.only(
                        top: 18,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.orderEmpty),
                          Text(
                            'Empty',
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'You do not have an cancelled order of this time',
                            style:
                            GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xff747474)),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ):Center(child: CircularProgressIndicator(color: Colors.green,),),
            ])));
  }
}
