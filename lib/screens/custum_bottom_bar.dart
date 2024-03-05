import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fresh2_arrive/screens/AllCategories.dart';
import 'package:fresh2_arrive/screens/cart_screenOfMart.dart';
import 'package:fresh2_arrive/screens/customer_homepage.dart';
import 'package:fresh2_arrive/screens/wishListScreen.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/MyOrder_Controller.dart';
import '../controller/My_cart_controller.dart';
import '../controller/category_controller.dart';
import '../controller/location_controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/wishlist_data_controller.dart';
import '../model/zipcode_model.dart';
import '../repositories/add_address_repository.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import 'drawer.dart';
import 'myProfile.dart';
import 'notification_screen.dart';
import 'package:flutter/material.dart' hide Badge;

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
  }) : super(key: key);
  static var customNavigationBar = "/customNavigationBar";

  @override
  CustomNavigationBarState createState() => CustomNavigationBarState();
}

class CustomNavigationBarState extends State<CustomNavigationBar> {
  final myOrderController = Get.put(MyOrderController());
  final controller = Get.put(MainHomeController());
  final profileController = Get.put(ProfileController());
  final locationController = Get.put(LocationController());
  final myCartController = Get.put(MyCartDataListController());
  final notificationController = Get.put(NotificationController());
  final allCategoryController = Get.put(CategoryController());
  final wishListController = Get.put(FavoriteListController());
  final zipController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ZipcodeDataModel? zipcodeDataModel;
  String address = "select address";

  getAddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    address = pref.getString("user_address")!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      myCartController.getAddToCartList();
      profileController.getData();
      getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xfff3f3f3),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/newBG.png",
            ),
            alignment: Alignment.topRight,
            fit: BoxFit.contain,
          ),
        ),
        child: Obx(() {
          return Scaffold(
              backgroundColor: Colors.transparent,
              key: controller.scaffoldKey,
              drawer: const CustomDrawer(),
              appBar: controller.currentIndex.value == 2
                  ? AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leadingWidth: AddSize.size40,
                      leading: Padding(
                        padding: EdgeInsets.only(left: AddSize.padding10),
                        child: GestureDetector(
                          child: Image.asset(
                            AppAssets.drawerImage,
                            height: AddSize.size20,
                          ),
                          onTap: () {
                            controller.scaffoldKey.currentState!.openDrawer();
                            profileController.getData();
                          },
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding16,
                                            ),
                                            child: Form(
                                              key: formKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: AddSize.size20),
                                                  Image.asset(
                                                    "assets/images/zipcode.png",
                                                    height: 70,
                                                  ),
                                                  SizedBox(height: AddSize.size20),
                                                  Text(
                                                    "Find A Zip Code",
                                                    style: TextStyle(
                                                        color: Color(0xff000000),
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: AddSize.font22),
                                                  ),
                                                  SizedBox(height: AddSize.size20),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(child: Divider()),
                                                      Text(
                                                        " or enter US zip code ",
                                                        style: TextStyle(
                                                            color: Color(0xff000000),
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: AddSize.font14),
                                                      ),
                                                      Expanded(child: Divider()),
                                                    ],
                                                  ),
                                                  addHeight(17),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                                    decoration:
                                                        BoxDecoration(border: Border.all(color: Colors.grey.shade100)),
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding: EdgeInsets.only(top: 15),
                                                            height: 35,
                                                            child: TextFormField(
                                                              textAlign: TextAlign.center,
                                                              controller: zipController,
                                                              keyboardType: TextInputType.number,
                                                              decoration: InputDecoration(
                                                                  border: InputBorder.none,
                                                                  hintText: "Enter zip code",
                                                                  hintStyle: TextStyle(
                                                                    color: Colors.black26,
                                                                  )),
                                                            ),
                                                          ),
                                                        ),
                                                        addWidth(20),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (formKey.currentState!.validate()) {
                                                              sendZipcodeRepo(
                                                                      addressId: zipController.text, context: context)
                                                                  .then((value) async {
                                                                if (value.status == true) {
                                                                                                                                    zipcodeDataModel = value;
                                                                  SharedPreferences pref =
                                                                      await SharedPreferences.getInstance();
                                                                  pref.setString("user_address",
                                                                      zipcodeDataModel!.data!.address.toString());
                                                                  getAddress();
                                                                  showToast(value.message);
                                                                  Get.back();
                                                                  zipController.clear();
                                                                } else {
                                                                  showToast(value.message);
                                                                }
                                                              });
                                                            }
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                                            decoration: BoxDecoration(
                                                              color: Colors.green,
                                                            ),
                                                            child: Text("Submit",
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: Colors.white)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: AddSize.size50),
                                                ],
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                );
                              },
                              child:
                              Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      "assets/images/Layer 2.png",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      address,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 16, color: AppTheme.backgroundcolor, fontWeight: FontWeight.w500),
                                    ),
                                  ),

                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppTheme.backgroundcolor,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                            // Text(
                            //   locationController.locality.value.toString(),
                            //   style: const TextStyle(
                            //       fontSize: 14,
                            //       color: AppTheme.backgroundcolor,
                            //       fontWeight: FontWeight.w400),
                            // ),
                          ],
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon:
                              Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Badge(
                                    badgeStyle: const BadgeStyle(badgeColor: AppTheme.blackcolor),
                                    badgeContent: Obx(() {
                                      return Text(
                                        profileController.isDataLoading.value
                                            ? profileController.model.value.data!.notificationCount!.toString()
                                            : "0",
                                        style: TextStyle(color: Colors.white, fontSize: AddSize.font12),
                                      );
                                    }),
                                    child: const ImageIcon(
                                      AssetImage(AppAssets.notification),
                                      size: 22,
                                    ),
                                  )),
                          onPressed: () {
                            Get.toNamed(NotificationScreen.notificationScreen);
                          },
                        ),
                        addWidth(10),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                            onTap: () async {
                              Get.toNamed(MyProfileScreen.myProfileScreen);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Container(
                                  height: 38,
                                  width: 38,
                                  clipBehavior: Clip.antiAlias,
                                  // margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    // color: Colors.brown
                                  ),
                                  child: Obx(() {
                                    return (profileController.isDataLoading.value
                                                ? (profileController.model.value.data!.userData!.profileImage ?? "")
                                                    .toString()
                                                : "")
                                            .isNotEmpty
                                        ? CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: profileController.isDataLoading.value
                                                ? profileController.model.value.data!.userData!.profileImage!
                                                : '',
                                            height: AddSize.size30,
                                            width: AddSize.size30,
                                            errorWidget: (_, __, ___) => const Icon(
                                              Icons.person,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            placeholder: (_, __) => const SizedBox(),
                                          )
                                        : SizedBox.shrink();
                                  })),
                            ),
                          ),
                        )
                      ],
                    )
                  : AppBar(
                      toolbarHeight: 0,
                      backgroundColor: Color(0xffF3F3F3),
                      elevation: 0,
                      automaticallyImplyLeading: true,
                    ),
              bottomNavigationBar: Obx(() {
                return BottomAppBar(
                    color: Colors.white,
                    shape: const CircularNotchedRectangle(),
                    clipBehavior: Clip.hardEdge,
                    elevation: 0,
                    child: Theme(
                        data: ThemeData(
                            splashColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            bottomNavigationBarTheme:
                                const BottomNavigationBarThemeData(backgroundColor: Colors.white, elevation: 0)),
                        child: BottomNavigationBar(
                            unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                            selectedLabelStyle:
                                const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppTheme.primaryColor),
                            items: [
                              BottomNavigationBarItem(
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 08,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.onItemTap(0);
                                    },
                                    child: const ImageIcon(
                                      AssetImage(AppAssets.profile),
                                      size: 18,
                                    ),
                                  ),
                                ),
                                label: '',
                              ),
                              BottomNavigationBarItem(
                                  icon: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.0),
                                      child: Badge(
                                        badgeStyle: const BadgeStyle(badgeColor: AppTheme.blackcolor),
                                        badgeContent: Obx(() {
                                          return Text(
                                            myCartController.sum.value.toString(),
                                            style: TextStyle(color: Colors.white, fontSize: AddSize.font12),
                                          );
                                        }),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await myCartController.getAddToCartList();
                                          },
                                          child: const ImageIcon(
                                            AssetImage(AppAssets.cart),
                                            size: 20,
                                          ),
                                        ),
                                      )),
                                  // icon: Padding(
                                  //   padding: EdgeInsets.all(8.0),
                                  //   child: ImageIcon(
                                  //     AssetImage(AppAssets.cart),
                                  //     size: 20,
                                  //   ),
                                  // ),
                                  label: ''),
                              const BottomNavigationBarItem(
                                  icon: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 08,
                                      ),
                                      child: null),
                                  label: ''),
                              BottomNavigationBarItem(
                                icon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 08,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      controller.onItemTap(3);
                                      allCategoryController.getData();
                                    },
                                    child: const ImageIcon(
                                      AssetImage(AppAssets.oders),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                label: '',
                              ),
                              BottomNavigationBarItem(
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 08),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.onItemTap(4);
                                        wishListController.getWishListData();
                                      },
                                      child: const ImageIcon(
                                        AssetImage(AppAssets.wishlist),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  label: ''),
                            ],
                            type: BottomNavigationBarType.fixed,
                            currentIndex: controller.currentIndex.value,
                            selectedItemColor: AppTheme.primaryColor,
                            iconSize: 40,
                            onTap: controller.onItemTap,
                            elevation: 0)));
              }),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Visibility(
                visible: !keyboardIsOpened,
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppTheme.backgroundcolor, width: 2)),
                  child: GestureDetector(
                    child: const Center(
                      child: Icon(
                        Icons.home,
                        size: 30,
                        color: AppTheme.backgroundcolor,
                      ),
                    ),
                    onTap: () {
                      controller.onItemTap(2);
                      controller.scrollController.animateTo(
                        0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
              body: Center(
                child: Obx(() {
                  return IndexedStack(
                    index: controller.currentIndex.value,
                    children: const [
                      MyProfileScreen(),
                      CartScreenOfMart(),
                      CustomerHomepage(),
                      AllCategories(),
                      WishListScreen(),
                    ],
                  );
                }),
              ));
        }));
  }
}
