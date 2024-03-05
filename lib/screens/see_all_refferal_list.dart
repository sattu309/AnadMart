// import 'package:flutter/material.dart';
// import 'package:fresh2_arrive/resources/app_theme.dart';
// import 'package:fresh2_arrive/widgets/add_text.dart';
// import 'package:fresh2_arrive/widgets/dimensions.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../resources/app_assets.dart';
// import '../model/marketinginf_model.dart';
// import '../repositories/marketinginf_repo.dart';
// import '../widgets/common_error.dart';
//
// class ReferralOrderList extends StatefulWidget {
//   const ReferralOrderList({Key? key}) : super(key: key);
//   static var referralOrderList = "/referralOrderList";
//
//   @override
//   State<ReferralOrderList> createState() => _ReferralOrderListState();
// }
//
// class _ReferralOrderListState extends State<ReferralOrderList> {
//   Rx<RxStatus> statusOfManagerInf = RxStatus.empty().obs;
//   Rx<MarketingInfModel> managerinf = MarketingInfModel().obs;
//   getDataSubscription() {
//     ManagerInfRepo().then((value) async {
//       managerinf.value = value;
//       if (value.status == true) {
//         print("1111111111111");
//         statusOfManagerInf.value = RxStatus.success();
//         // referralLink = await dyLink.createReferralLink(managerinf.value.data!.referralCode.toString());
//         setState(() {});
//       } else {
//         statusOfManagerInf.value = RxStatus.error();
//       }
//     }
//     );
//   }
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getDataSubscription();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: backAppBar(
//             title: "Orders List",
//             textColor: AppTheme.backgroundcolor,
//             context: context,
//             backgroundColor: AppTheme.primaryColor,
//             icon: Image.asset(
//               AppAssets.backwhiteicon,
//               height: AddSize.size20,
//             )),
//         body: Obx(() {
//           return statusOfManagerInf.value.isSuccess
//               ? SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding18),
//                   child: Column(children: [
//                     Card(
//                         elevation: 0,
//                         color: AppTheme.backgroundcolor,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         child: Padding(
//                             padding:
//                             EdgeInsets.symmetric(horizontal: AddSize.padding18, vertical: AddSize.padding20),
//                             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "Order No.",
//                                     style: Theme.of(context).textTheme.headline5!.copyWith(
//                                         height: 1.5,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: AddSize.font14,
//                                         color: const Color(0xff52AC1A)),
//                                   ),
//                                   Text(
//                                     "               Order Amount",
//                                     style: Theme.of(context).textTheme.headline5!.copyWith(
//                                         height: 1.5,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: AddSize.font14,
//                                         color: const Color(0xff52AC1A)),
//                                   ),
//                                   Text(
//                                     "Earning",
//                                     style: Theme.of(context).textTheme.headline5!.copyWith(
//                                         height: 1.5,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: AddSize.font14,
//                                         color: const Color(0xff52AC1A)),
//                                   )
//                                 ],
//                               ),
//                               managerinf.value.data!.orderList!.isNotEmpty?
//                               ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: managerinf.value.data!.orderList!.length,
//                                 scrollDirection: Axis.vertical,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return Column(
//                                     children: [
//                                       SizedBox(
//                                         height: AddSize.size5,
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {},
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   "Order No.:-  #${managerinf.value.data!.orderList![index].orderId.toString()}",
//                                                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                                                       height: 1.5,
//                                                       fontWeight: FontWeight.w500,
//                                                       fontSize: AddSize.font14),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Text(
//                                                   managerinf.value.data!.orderList![index].name.toString(),
//                                                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                                                       height: 1.5,
//                                                       fontWeight: FontWeight.w500,
//                                                       fontSize: AddSize.font12,
//                                                       color: Colors.grey.shade500),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () async {
//                                                     var url =
//                                                         "https://wa.me/${managerinf.value.data!.orderList![index].phone.toString()}/?text=hello";
//                                                     if (await launch(url)) {
//                                                       await canLaunch(url);
//                                                     } else {
//                                                       showToast('there is no WhatsApp installed');
//                                                     }
//                                                   },
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Text(
//                                                         managerinf.value.data!.orderList![index].phone
//                                                             .toString(),
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .headline5!
//                                                             .copyWith(
//                                                             height: 1.5,
//                                                             fontWeight: FontWeight.w500,
//                                                             fontSize: AddSize.font12,
//                                                             color: Colors.grey.shade500),
//                                                       ),
//                                                       Icon(
//                                                         Icons.chat,
//                                                         color: AppTheme.primaryColor,
//                                                         size: 16,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 Text(
//                                                   (managerinf.value.data!.orderList![index].date ?? "")
//                                                       .toString(),
//                                                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                                                       height: 1.5,
//                                                       fontWeight: FontWeight.w500,
//                                                       fontSize: AddSize.font12,
//                                                       color: Colors.grey.shade500),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 managerinf.value.data!.orderList![index].address == null?SizedBox():
//                                                 SizedBox(
//                                                   width: 150,
//                                                   child: Text(
//                                                     (managerinf.value.data!.orderList![index].address!
//                                                         .location ??
//                                                         "")
//                                                         .toString(),
//                                                     style: Theme.of(context).textTheme.headline5!.copyWith(
//                                                         height: 1.5,
//                                                         fontWeight: FontWeight.w500,
//                                                         fontSize: AddSize.font12,
//                                                         color: Colors.grey.shade500),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Text(
//                                               "₹${managerinf.value.data!.orderList![index].orderAmount.toString()}",
//                                               style: Theme.of(context).textTheme.headline5!.copyWith(
//                                                   height: 1.5,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: AddSize.font14,
//                                                   color: AppTheme.blackcolor),
//                                             ),
//                                             Text(
//                                               "₹${managerinf.value.data!.orderList![index].commissionMarketingPartner.toString()}",
//                                               style: Theme.of(context).textTheme.headline5!.copyWith(
//                                                   height: 1.5,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontSize: AddSize.font14,
//                                                   color: AppTheme.blackcolor),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: AddSize.size5,
//                                       ),
//                                       const Divider(),
//                                     ],
//                                   );
//                                 },
//                               )
//                                   : Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: AddSize.padding20 * 3),
//                                 child: Text("Order not Available",
//                                     style: Theme.of(context).textTheme.headline5!.copyWith(
//                                         height: 1.5,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: AddSize.font14,
//                                         color: AppTheme.blackcolor)),
//                               )
//                             ]))),
//                   ])))
//               : statusOfManagerInf.value.isError
//               ? CommonErrorWidget(
//             errorText: managerinf.value.message.toString(),
//             onTap: () {},
//           )
//               : Center(child: const CircularProgressIndicator());
//         }));
//   }
// }
