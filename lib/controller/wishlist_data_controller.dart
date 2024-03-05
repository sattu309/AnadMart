import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/wishlist_model.dart';
import '../repositories/wishlist_repo.dart';

class FavoriteListController extends GetxController{

  Rx<WishListModel> model = WishListModel().obs;
  RxBool isDataLoading = false.obs;
  RxInt refreshInt = 0.obs;

  getWishListData(){
    isDataLoading.value = false;
    favoriteData().then((value) {
      isDataLoading.value = true;
      model.value = value;
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  List<String> get wishListProducts => model.value.data != null && model.value.data!.wishlist != null ?
  model.value.data!.wishlist!.map((e) => e.productId.toString()).toList() : [];

}