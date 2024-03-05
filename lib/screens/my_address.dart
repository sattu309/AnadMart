
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/update_address_screen_mart.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../resources/app_theme.dart';
import '../controller/MyAddress_controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/main_home_controller.dart';
import '../repositories/add_address_repository.dart';
import '../resources/app_text.dart';
import 'Add_address_screen_mart.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({Key? key}) : super(key: key);
  static var myAddressScreen = "/myAddressScreen";

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final addressController = Get.put(MyAddressController());
  final controller = Get.put(MyCartDataListController());
  final mainController = Get.put(MainHomeController());

  @override
  void initState() {
    super.initState();
    addressController.getAddress();
  }

  // showUploadWindow(index) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: SingleChildScrollView(
  //           child: Padding(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: AddSize.padding16,
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(height: AddSize.size10),
  //                   Text("Are you sure you want to delete this address?",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: AddSize.font16)),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                         child: Text("No",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.w500,
  //                                 color: AppTheme.primaryColor,
  //                                 fontSize: AddSize.font18)),
  //                         onPressed: () {
  //                           Get.back();
  //                         },
  //                       ),
  //                       TextButton(
  //                         child: Text("Yes",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.w500,
  //                                 color: AppTheme.primaryColor,
  //                                 fontSize: AddSize.font18)),
  //                         onPressed: () {
  //                           removeAddress(
  //                                   addressId: index.id.toString(),
  //                                   context: context)
  //                               .then((value) {
  //                             showToast(value.message.toString());
  //                             if (value.status == true) {
  //                               addressController.getAddress();
  //                               Get.back();
  //                             }
  //                           });
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               )),
  //         ),
  //       );
  //     },
  //   );
  // }

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
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        leadingWidth: AddSize.size20 * 2,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Address",
          style: GoogleFonts.quicksand(fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xff303D48)),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: AddSize.padding15),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                ("assets/images/backArrow.png"),
                height: AddSize.size20,
              )),
        ),
      ),
      // backAppBar(title: "My Address", context: context),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Obx(() {
              return Column(
                children: [
                  // SizedBox(
                  //   height: height * .01,
                  // ),
                  addressController.isAddressLoad.value
                      ? addressController.myAddressModel.value.data!.isNotEmpty
                      ? Column(
                    children: [
                      ListView.builder(
                          itemCount: addressController.myAddressModel.value.data!.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: height * .01),
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                              // height: height * .23,
                              child: InkWell(
                                onTap: () {
                                  controller.model.value.data!.cartItems!.isNotEmpty ?
                                  chooseOrderAddress(addressId: addressController.myAddressModel.value.data![index].id
                                                  .toString(),
                                          context: context)
                                      .then((value) {
                                    if (value.status == true) {
                                      showToast(value.message);
                                      controller.getAddToCartList();
                                      Get.back();
                                      // Get.back();
                                      // Get.back();
                                      // Get.back();
                                      // mainController.onItemTap(1);
                                    }
                                  }):null;
                                },
                                child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: width * .03, vertical: height * .020),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                "assets/images/editAddress.png",
                                                height: 50,
                                              ),
                                              addWidth(12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(

                                                          child: Text(
                                                            // "Home",
                                                            addressController
                                                                .myAddressModel.value.data![index].addressType
                                                                .toString(),
                                                            style: GoogleFonts.quicksand(
                                                                color: Color(0xff1A2E33),
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                       // addWidth(width * .45),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.to(()=>UpdateAddressScreenMart(
                                                                addressId: addressController.myAddressModel.value.data![index].id
                                                                .toString(),
                                                              addressType: addressController.myAddressModel.value.data![index].addressType
                                                                  .toString(),
                                                            ));
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/AddressIcon.png",
                                                            height: 30,
                                                          ),
                                                        ),
                                                        IconButton(
                                                            onPressed: (){
                                                              removeAddress(
                                                                  addressId: addressController.myAddressModel.value.data![index].id
                                                                      .toString(),
                                                                  context: context)
                                                                  .then((value) {
                                                                showToast("Address successfully deleted");
                                                                if (value.status == true) {
                                                                  addressController.getAddress();
                                                                  //Get.back();
                                                                }
                                                              });
                                                            },
                                                            icon: Icon(Icons.delete,color: Color(0xff4DBA4D),))
                                                      ],
                                                    ),
                                                    Text(
                                                      // "4295 Shinn Avenue, Indiana, States",
                                                      "${addressController.myAddressModel.value.data![index].address1
                                                          .toString()},"
                                                          " ${addressController.myAddressModel.value.data![index].address2
                                                          .toString()
                                                          .capitalizeFirst}, "
                                                      // "${addressController.myAddressModel.value.data![index].landmark.toString().capitalizeFirst},"
                                                          " ${addressController.myAddressModel.value.data![index].city
                                                          .toString()
                                                          .capitalizeFirst},"
                                                          " ${addressController.myAddressModel.value.data![index].zipCode
                                                          .toString()
                                                          .capitalizeFirst},",
                                                      style: TextStyle(
                                                          color: Color(0xff5C5C60),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    )),
                              ),
                            );
                          }),
                    ],
                  )
                      : const SizedBox()
                      : const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      )),
                ],
              );
            }),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
        child: CommonButton(
          title: 'ADD ADDRESS',
          onPressed: () {
            FocusManager.instance.primaryFocus!.unfocus();
            Get.to(()=>AddressScreenMart());

          },
        ),
      ),
    );
  }
}
