import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/MyOrder_Details_Controller.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key, this.orderId, this.orderDate, this.subTotal, this.total, this.deliveryCharges}) : super(key: key);
  final orderId;
  final orderDate;
  final subTotal;
  final total;
  final deliveryCharges;
  static var thankYouScreen = "/thankYouScreen";
  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  final myOrderDetailsController = Get.put(MyOrderDetailsController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AddSize.padding16, vertical: AddSize.padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .08,
                ),
                Image(
                  height: height * .25,
                  width: width,
                  image: const AssetImage(AppAssets.thankYou),
                  color: Color(0xff4DBA4D),
                ),
                SizedBox(
                  height: height * .04,
                ),
                Text(
                  "Thank You!",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: AddSize.font24,
                      color: AppTheme.blackcolor),
                ),
                SizedBox(
                  height: height * .005,
                ),
                Text(
                  "your order has been successful",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: AddSize.font16,
                      color: AppTheme.blackcolor),
                ),
                SizedBox(
                  height: height * .04,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 0,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding20,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Order ID:",
                                    style: TextStyle(
                                        color: AppTheme.blackcolor,
                                        fontSize: AddSize.font16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  widget.orderId,
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: AddSize.font14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date:",
                                    style: TextStyle(
                                        color: AppTheme.blackcolor,
                                        fontSize: AddSize.font16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    widget.orderDate,
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: AddSize.font14,
                                        fontWeight: FontWeight.w500)),
                              ]),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Subtotal:",
                                    style: TextStyle(
                                        color: AppTheme.blackcolor,
                                        fontSize: AddSize.font16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    widget.subTotal,
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: AddSize.font14,
                                        fontWeight: FontWeight.w500)),
                              ]),

                          SizedBox(
                            height: height * .01,
                          ),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery charges:",
                                    style: TextStyle(
                                        color: AppTheme.blackcolor,
                                        fontSize: AddSize.font16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    widget.deliveryCharges,
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: AddSize.font14,
                                        fontWeight: FontWeight.w500)),
                              ]),
                          SizedBox(
                            height: height * .01,
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total:",
                                    style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: AddSize.font16,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    widget.total,
                                    style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontSize: AddSize.font14,
                                        fontWeight: FontWeight.w500)),
                              ]),
                        ]),
                  ),
                ),
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // OutlinedButton(
            //   style: OutlinedButton.styleFrom(
            //     foregroundColor: AppTheme.primaryColor,
            //     minimumSize: const Size(double.maxFinite, 60),
            //     side: const BorderSide(color: AppTheme.primaryColor, width: 2),
            //     shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(10))),
            //   ),
            //   onPressed: () {
            //   },
            //   child: Text(
            //     'ORDER DETAILS',
            //     style: Theme.of(context).textTheme.headline5!.copyWith(
            //         color: AppTheme.primaryColor,
            //         fontWeight: FontWeight.w500,
            //         fontSize: AddSize.font16),
            //   ),
            // ),
            // SizedBox(
            //   height: height * .01,
            // ),
            ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(CustomNavigationBar.customNavigationBar);
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    backgroundColor: Color(0xff4DBA4D),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AddSize.size10)),
                    textStyle: TextStyle(
                        fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                child: Text(
                  "BACK TO HOME",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font16),
                )),
          ],
        ),
      ),
    );
  }
}
