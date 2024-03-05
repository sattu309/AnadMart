import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/home_page_model.dart';
import 'package:get/get.dart';
import '../model/Home_Search_Model.dart';
import '../model/homepage_mart_model.dart';
import '../repositories/Homepage_search_Repo.dart';
import '../repositories/home_page_repository.dart';
import '../repositories/homepage_mart_repo.dart';

class HomePageController extends GetxController {
  RxBool isDataLoading = false.obs;
  Rx<HomePageModel> model = HomePageModel().obs;
  Rx<HomepageMartModel> homePageMartModel = HomepageMartModel().obs;
  Rx<HomeSearchModel> searchDataModel = HomeSearchModel().obs;
  final searchController = TextEditingController();


  Future getData() async {
    // isDataLoading.value = false;
    await homeData().then((value) {
      isDataLoading.value = true;
      model.value = value;
    });
  }

  Future getHomePageData() async {
     // isDataLoading.value = false;
    await homePageDataOfMart().then((value) {
      isDataLoading.value = true;
      homePageMartModel.value = value;
    });
  }

  Future<HomeSearchModel> getSearchData() async {
    // isDataLoading.value = false;
  return await homeSearchRepo(searchController.text.trim()).then((value) {
    isDataLoading.value = true;
      searchDataModel.value = value;
      return value;
    });
  }
}
