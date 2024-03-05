import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:fresh2_arrive/screens/products_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/My_cart_controller.dart';
import '../controller/home_page_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/wishlist_data_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';
import 'SearchScreenData..dart';
import 'products_screen/product_widget.dart';

class CustomerHomepage extends StatefulWidget {
  static var customerHomepage = "/customerHomepage";

  const CustomerHomepage({Key? key}) : super(key: key);

  @override
  CustomerHomepageState createState() => CustomerHomepageState();
}

class CustomerHomepageState extends State<CustomerHomepage> {
  final homepageControllerMart = Get.put(HomePageController());
  final myCartController = Get.put(MyCartDataListController());
  final wishListController = Get.put(FavoriteListController());
  final controller = Get.put(MainHomeController());

  RxInt refreshInt = 0.obs;
  RxDouble sliderIndex = (0.0).obs;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      homepageControllerMart.getHomePageData();
      myCartController.getAddToCartList();

    });
  }


  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: homepageControllerMart.isDataLoading.value && homepageControllerMart.homePageMartModel.value.data != null
            ? RefreshIndicator(
                onRefresh: () async {
                 await homepageControllerMart.getHomePageData();
                },
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .03),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * .04,
                              ),
                              Text(
                                'Lets You Find Top Products',
                                style: GoogleFonts.quicksand(
                                    color: Color(0xffFFFFFF), fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: SizedBox(
                                  height: height * .07,
                                  child: TextField(
                                    maxLines: 1,
                                    controller: homepageControllerMart.searchController,
                                    style: const TextStyle(fontSize: 17),
                                    textAlignVertical: TextAlignVertical.center,
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) {
                                      Get.toNamed(SearchScreenData.searchScreen);
                                      FocusManager.instance.primaryFocus!.unfocus();
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            Get.to(const SearchScreenData());
                                            FocusManager.instance.primaryFocus!.unfocus();
                                            // Get.toNamed(MyRequestScreen.myRequestScreenOfMart);
                                          },
                                          icon: Container(
                                            height: 48,
                                            width: 38,
                                            decoration: BoxDecoration(
                                                color: Color(0xff0074D9), borderRadius: BorderRadius.circular(5)),
                                            child: const Icon(
                                              Icons.search_rounded,
                                              color: Color(0xffFFFFFF),
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
                                        fillColor: Colors.white,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: height * .03, horizontal: width * .03),
                                        hintText: 'Search Your Products',
                                        hintStyle: GoogleFonts.quicksand(
                                            fontSize: AddSize.font14,
                                            color: Color(0xff787777),
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .025,
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    autoPlay: true,
                                    onPageChanged: (value, _) {
                                      sliderIndex.value = value.toDouble();
                                    },
                                    autoPlayCurve: Curves.ease,
                                    height: height * .20),
                                items: List.generate(
                                    homepageControllerMart.homePageMartModel.value.data!.sliderData!.length,
                                    (index) => Container(
                                          width: width,
                                          margin: EdgeInsets.symmetric(horizontal: width * .01),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15), color: AppTheme.backgroundcolor),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child:
                                                // Image.asset("assets/images/slider.png" ,fit: BoxFit.cover,),
                                                CachedNetworkImage(
                                              imageUrl: homepageControllerMart
                                                  .homePageMartModel.value.data!.sliderData![index].image
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              errorWidget: (_, __, ___) => Image.asset(
                                                'assets/images/Ellipse 67.png',
                                              ),
                                              placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                                            ),
                                          ),
                                        )),
                              ),
                              SizedBox(
                                height: height * .012,
                              ),
                              Obx(() {
                                return Center(
                                  child: DotsIndicator(
                                    dotsCount: homepageControllerMart.homePageMartModel.value.data!.sliderData!.length,
                                    position: sliderIndex.value.toInt(),
                                    decorator: DotsDecorator(
                                      color: Colors.grey.shade300, // Inactive color
                                      activeColor: AppTheme.primaryColor,
                                      size: const Size.square(12),
                                      activeSize: const Size.square(12),
                                    ),
                                  ),
                                );
                              }),
                              addHeight(8),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: homepageControllerMart.homePageMartModel.value.data!.latestCategory!.length,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, index) {
                                    final category =
                                        homepageControllerMart.homePageMartModel.value.data!.latestCategory![index];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 7, right: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                category.name.toString().capitalizeFirst.toString(),
                                                style: GoogleFonts.quicksand(
                                                    color: Color(0xff000000), fontSize: 17, fontWeight: FontWeight.w700),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    Get.to(()=>ProductScreenOfMart(categoryId: category.id.toString()));
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/forwardArroow.png",
                                                    height: 22,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        addHeight(4),
                                        SizedBox(
                                          height: 300,
                                          child: GridView.builder(
                                              itemCount: category.products!.length,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 1,
                                                  crossAxisSpacing: 0,
                                                  mainAxisExtent: 200,
                                                  mainAxisSpacing: 0.0),
                                              scrollDirection: Axis.horizontal,
                                              physics: AlwaysScrollableScrollPhysics(),
                                              itemBuilder: (BuildContext context, i) {
                                                final product = category.products![i];
                                                return ProductWidget(products: product,);
                                              }),
                                        ),
                                        addHeight(12),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                          addHeight(18),
                        ],
                      )),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: Colors.green,
              )),
        bottomNavigationBar: myCartController.isDataLoaded.value
            ? myCartController
            .model.value.data!.cartItems!.isNotEmpty
            ? addCartSection()
            : null
            : const SizedBox(),
      );
    });
  }


}
