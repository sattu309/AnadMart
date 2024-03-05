import 'package:get/get.dart';
import '../model/Cart_Related_product_Model.dart';
import '../model/My_Cart_Model.dart';
import '../repositories/Cart_Related_Product.Repo.dart';
import '../repositories/My_Cart_Repo.dart';
import '../widgets/add_text.dart';

class MyCartDataListController extends GetxController {
  Rx<MyCartData> model = MyCartData().obs;
  RxBool isDataLoaded = false.obs;
  RxBool isRelatedProductDataLoaded = false.obs;
  RxInt sum = 0.obs;
  RxInt counter = 1.obs;
  RxInt refreshInt = 0.obs;
  plusCounter(){
    counter=counter++;
  }
  minusCounter(){
    if(counter.value>1 && counter.value != 1){
      counter=counter--;
    }
    else{
      showToast("Qty should be 1");
    }
  }
  Future getAddToCartList() async {
   await myCartRepo().then((value) {
      isDataLoaded.value = true;
      model.value = value;
      sum.value = 0;
      for(int i = 0; i<value.data!.cartItems!.length;i++){
        sum.value = sum.value + (int.tryParse(value.data!.cartItems![i].cartItemQty.toString()) ?? 0);
      }
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAddToCartList();
  }
}
