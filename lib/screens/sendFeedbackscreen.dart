import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:fresh2_arrive/repositories/common_repo/repository.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/order_details_mart.dart';
import '../resources/app_text.dart';
import '../widgets/add_text.dart';
import '../widgets/editprofile_textfield.dart';
import 'order/OrderDetailsOfMart.dart';
import 'custum_bottom_bar.dart';

class SendFeedbackScreen extends StatefulWidget {
  final String productId;
  final String orderId;
  final Function() onUpdate;
  const SendFeedbackScreen({Key? key, required, required this.productId, required this.orderId, required this.onUpdate}) : super(key: key);

  static var termAndConditionScreen = "/termAndConditionScreen";
  @override
  State<SendFeedbackScreen> createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  final formKey = GlobalKey<FormState>();
  final reviewController = TextEditingController();
  OrderDetailsOfMart orderDetailsOfMart = OrderDetailsOfMart();

  Repositories repositories = Repositories();

  giveFeedback() {
    print("Product id ${widget.productId}");
    print("order id ${widget.orderId}");
    var map = <String, dynamic>{};
    map["rating"] = fullRating;
    map["product_id"] = widget.productId;
    map["order_id"] = widget.orderId;
    map["review"] = reviewController.text;
    print(map.toString());
    repositories.postApi(url: ApiUrl.feedbackUrl, mapData: map, context: context).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      if (modelCommonResponse.status == true) {
        showToast(modelCommonResponse.message);
        widget.onUpdate();
        Get.back();
      } else {
        showToast(modelCommonResponse.message);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // controller.getData();
  }

  @override
  double fullRating = 0;
  bool? _isValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar2(title: 'Send Feedback', context: context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How did we do?',
                      style: GoogleFonts.quicksand(color: Color(0xFF1A2E33), fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    addHeight(16),

                    RatingBar.builder(
                      initialRating: 0,
                      glowColor: Colors.white10,
                      minRating: 1,
                      unratedColor: const Color(0xFFE0DEDA),
                      itemCount: 5,
                      itemSize: 22.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      updateOnDrag: true,
                      allowHalfRating: true,
                      itemBuilder: (context, index) => Image.asset(
                        'assets/images/star.png',
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (ratingvalue) {
                        setState(() {
                          fullRating = ratingvalue;
                          print(fullRating);
                        });
                      },
                    ),
                    addHeight(20),
                    Text(
                      'Care to share more about it?',
                      style: GoogleFonts.quicksand(color: Color(0xFF000000), fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    addHeight(10),
                    EditProfileTextFieldWidget(
                      controller: reviewController,
                      onTap: () {},
                      minLines: 5,
                      maxLines: null,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Please share your experience"),
                      ]),
                    ),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1.5,
                    //
                    //           child: Checkbox(
                    //               activeColor: Color(0xff7ED957),
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius:
                    //                   BorderRadius.circular(3)),
                    //               value: _isValue,
                    //               onChanged: (bool? value) {
                    //                 setState(() {
                    //                   _isValue = value;
                    //                 });
                    //               }),
                    //         ),
                    //         const Text("Food Quality",style: TextStyle(
                    //             color: Color(0xFF969AA3),
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 15
                    //         ),),
                    //         SizedBox(width: 25,),
                    //         Transform.scale(
                    //           scale: 1.5,
                    //           child: Checkbox(
                    //               activeColor: Color(0xff7ED957),
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius:
                    //                   BorderRadius.circular(3)),
                    //               value: _isValue,
                    //               onChanged: (bool? value) {
                    //                 setState(() {
                    //                   _isValue = value;
                    //                 });
                    //               }),
                    //         ),
                    //         const Text(" Food Quantity",style: TextStyle(
                    //             color: Color(0xFF969AA3),
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 15
                    //         ),)
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1.5,
                    //           child: Checkbox(
                    //               activeColor: Color(0xff7ED957),
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius:
                    //                   BorderRadius.circular(3)),
                    //               value: _isValue,
                    //               onChanged: (bool? value) {
                    //                 setState(() {
                    //                   _isValue = value;
                    //                 });
                    //               }),
                    //         ),
                    //         const Text("Communication",style: TextStyle(
                    //             color: Color(0xFF969AA3),
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 15
                    //         ),),
                    //         Transform.scale(
                    //           scale: 1.5,
                    //           child: Checkbox(
                    //               activeColor: Color(0xff7ED957),
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius:
                    //                   BorderRadius.circular(3)),
                    //               value: _isValue,
                    //               onChanged: (bool? value) {
                    //                 setState(() {
                    //                   _isValue = value;
                    //                 });
                    //               }),
                    //         ),
                    //         const Text("Hygiene",style: TextStyle(
                    //             color: Color(0xFF969AA3),
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 14
                    //         ),)
                    //       ],
                    //     ),
                    //     Row(
                    //       children: [
                    //         Transform.scale(
                    //           scale: 1.5,
                    //           child: Checkbox(
                    //               activeColor: Color(0xff7ED957),
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius:
                    //                   BorderRadius.circular(3)),
                    //               value: _isValue,
                    //               onChanged: (bool? value) {
                    //                 setState(() {
                    //                   _isValue = value;
                    //                 });
                    //               }),
                    //         ),
                    //         const Text("Delivery",style: TextStyle(
                    //             color: Color(0xFF969AA3),
                    //             fontWeight: FontWeight.w400,
                    //             fontSize: 15
                    //         ),),
                    //
                    //       ],
                    //     ),
                    //     addHeight(20),
                    //     const Text('Care to share more about it?',
                    //       style: TextStyle(
                    //           color: Color(0xFF1A1917),
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 14
                    //       ),),
                    //     addHeight(10),
                    //     EditProfileTextFieldWidget(
                    //       onTap: (){},
                    //       minLines: 8,
                    //       maxLines: null,
                    //     ),
                    //   ],
                    // ),

                    addHeight(40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CommonButton1(
              title: 'Send Feedback',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  giveFeedback();
                }
              },
            ),
            addHeight(20),
            GestureDetector(
              onTap: () {
                Get.toNamed(CustomNavigationBar.customNavigationBar);
              },
              child: Text(
                "Skip",
                style: GoogleFonts.quicksand(color: Color(0xff000000), fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            addHeight(10),
          ],
        ),
      ),
    );
  }
}
