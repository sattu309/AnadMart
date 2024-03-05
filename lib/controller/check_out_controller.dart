// import 'package:fresh2_arrive/model/check_out_model.dart';
// import 'package:fresh2_arrive/repositories/check_out_repository.dart';
// import 'package:get/get.dart';
//
// import '../model/checkout_model_Mart.dart';
//
// class CheckOutController extends GetxController {
//   RxBool isDataLoading = false.obs;
//   RxBool idDataLoadedMart = false.obs;
//   Rx<CheckoutModelMart> checkoutModel = CheckoutModelMart().obs;
//   Rx<CheckOutDataModel> model = CheckOutDataModel().obs;
//   RxString type = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     //getData();
//   }
//
//   getData () async {
//     isDataLoading.value = false;
//     checkOut(context: Get.context).then((value) {
//       isDataLoading.value = true;
//       model.value = value;
//     });
//   }
//   //
//     getCheckoutMartData(){
//       idDataLoadedMart.value = false;
//       checkoutRepoOfMart().then((value){
//         idDataLoadedMart.value = true;
//         checkoutModel.value =value;
//       });
//
//
//     }
// }
