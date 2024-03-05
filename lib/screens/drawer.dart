import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/screens/change_password_screen.dart';
import 'package:fresh2_arrive/screens/authentication_screens/LoginScreenMart.dart';
import 'package:fresh2_arrive/screens/myProfile.dart';
import 'package:fresh2_arrive/screens/my_address.dart';
import 'package:fresh2_arrive/screens/notification_screen.dart';
import 'package:fresh2_arrive/screens/order/myOrdersOfMart.dart';
import 'package:fresh2_arrive/screens/static_chat_screen_ofMart.dart';
import 'package:fresh2_arrive/screens/support_screen_ofMart.dart';
import 'package:fresh2_arrive/screens/wishListScreen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/MyOrder_Controller.dart';
import '../controller/main_home_controller.dart';
import '../controller/profile_controller.dart';
import '../resources/app_theme.dart';
import 'cart_screenOfMart.dart';
import 'customer_support.dart';

class CustomDrawer extends StatefulWidget {
  // final void Function(int index) onItemTapped;

  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final controller = Get.put(MainHomeController());
  final profileController = Get.put(ProfileController());
  final myOrderController = Get.put(MyOrderController());

  ClientInformation? _clientInfo;

  Future<void> _getClientInformation() async {
    ClientInformation? info;
    try {
      info = await ClientInformation.fetch();
    } on PlatformException {}
    if (!mounted) return;

    setState(() {
      _clientInfo = info!;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceId', _clientInfo!.deviceId.toString());
  }

  @override
  void initState() {
    super.initState();
    profileController.getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;

    return Drawer(
        child:

        Obx(() {
          return Container(
            color: AppTheme.backgroundcolor,
            // height: SizeConfig.heightMultiplier * 100,
            // width: SizeConfig.widthMultiplier! * 80,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child:
              Column(
                children: <Widget>[
                  Container(
                    height: screenSize.height * 0.30,
                    width: screenSize.width,
                    color: AppTheme.primaryColor,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Get.to(navigationPage.elementAt(_currentPage))
                            // Get.to(MyProfile());
                          },
                          child: Card(
                              elevation: 3,
                              shape: const CircleBorder(),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                  margin: const EdgeInsets.all(4),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: const ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Colors.white,
                                  ),
                                  child:
                                  CachedNetworkImage(
                                    imageUrl:
                                    profileController.isDataLoading.value
                                        ? (profileController.model.value.data!
                                        .userData!.profileImage ??
                                        "")
                                        .toString()
                                        : "",
                                    height: screenSize.height * 0.12,
                                    width: screenSize.height * 0.12,
                                    errorWidget: (_, __, ___) => const Icon(Icons.person, size: 50,),
                                    placeholder: (_, __) => const SizedBox(),
                                    fit: BoxFit.cover,
                                  ))),
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Text(
                          // "Demo Singh",
                            profileController.isDataLoading.value
                                ? (profileController.model.value.data!.userData!.firstName ?? "")
                                .toString()
                                : "Demo Singh",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        Text(
                          // "demo@gmail.com",
                            profileController.isDataLoading.value
                                ? (profileController.model.value.data!.userData!.email ??
                                "")
                                .toString()
                                : "demo@gmail.com",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                        const SizedBox(
                          // height: SizeConfig.heightMultiplier! * 1.8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    // height: SizeConfig.heightMultiplier! * .5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        _drawerTile(
                            active: true,
                            title: "My Orders",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.op),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () {
                              Get.toNamed(MyOrdersOfMart.referAndEarnScreen);
                              // Get.toNamed(FeedBackScreen.feedbackScreen);
                              // myOrderController.getMyOrder();
                              // Get.back();
                              // controller.onItemTap(4);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "My Account",
                            icon: ImageIcon(
                              AssetImage(AppAssets.drawer_profile),
                              size: 22,
                              color: Colors.grey,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.toNamed(MyProfileScreen.myProfileScreen);
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Wishlist",
                            icon: ImageIcon(
                              AssetImage(AppAssets.favIcon),
                              size: 25,
                              // color: Colors.grey.shade100,
                            ),
                            onTap: () {
                              Get.toNamed(WishListScreen.wishListScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Notification",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_notification),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () {
                              Get.toNamed(NotificationScreen.notificationScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "My Address",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_location),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () {
                              Get.toNamed(MyAddress.myAddressScreen);
                              // Get.back();
                              // widget.onItemTapped(1);
                            }),
                        // const Divider(
                        //   height: 1,
                        // ),
                        // _drawerTile(
                        //     active: true,
                        //     title: "Refer and Earn",
                        //     icon: const ImageIcon(
                        //       AssetImage(AppAssets.drawer_refer),
                        //       size: 22,
                        //       color: AppTheme.primaryColor,
                        //     ),
                        //     onTap: () async {
                        //
                        //       // }
                        //     }),
                        // const Divider(
                        //   height: 1,
                        // ),
                        // _drawerTile(
                        //     active: true,
                        //     title: "My Wallet",
                        //     icon: const ImageIcon(
                        //       AssetImage(AppAssets.drawer_wallet),
                        //       size: 22,
                        //       color: AppTheme.primaryColor,
                        //     ),
                        //     onTap: () async {
                        //       Get.toNamed(WalletScreen.myWalletScreen);
                        //     }),

                        const Divider(
                          height: 1,
                        ),


                        _drawerTile(
                            active: true,
                            title: "My Cart",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.cartIcon),
                              size: 24,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.toNamed(CartScreenOfMart.cartScreenOfMart);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Message",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.msgIcon),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              // Get.toNamed(PrivacyPolicy.privacyPolicyScreen);
                              // Get.toNamed(AddNewCardScreenMart.addNewCardScreenMart);
                              Get.toNamed(StaticChatScreenMart.staticChatScreenMart);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Change Password",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.passwordIcon),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.toNamed(ChangePasswordScreen.changePasswordScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Contact Us",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.contactUs),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.toNamed(CustomerSupport.customerSupportScreen);
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Support",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.contactUs),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              Get.to(()=>SupportScreenOfMart());
                              // }
                            }),
                        const Divider(
                          height: 1,
                        ),
                        _drawerTile(
                            active: true,
                            title: "Logout",
                            icon: const ImageIcon(
                              AssetImage(AppAssets.drawer_logout),
                              size: 22,
                              // color: AppTheme.primaryColor,
                            ),
                            onTap: () async {
                              _getClientInformation();
                              Get.back();
                              SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                              await preferences.clear();
                              Get.offAllNamed(LoginScreenMart.loginScreenMart);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })

    );
  }

  // showDialog1() {
  //   var height = MediaQuery
  //       .of(context)
  //       .size
  //       .height;
  //   var width = MediaQuery
  //       .of(context)
  //       .size
  //       .width;
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //           insetPadding: EdgeInsets.all(15),
  //           child: Padding(
  //             padding: const EdgeInsets.all(28),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Center(
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         Get.back();
  //                       },
  //                       child: Container(
  //                           child: Image.asset(
  //                             'assets/images/cross_img.png',
  //                             height: 90,
  //                           )),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: height * .02,
  //                   ),
  //                   Text(
  //                     'Would You Like To Delete This Address?',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w600,
  //                       height: 1.6,
  //                     ),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   SizedBox(
  //                     height: height * .03,
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Expanded(
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             gradient: LinearGradient(
  //                               colors: [Color(0xFFFFA302), Color(0xFFFF5102)],
  //                             ),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           child: ElevatedButton(
  //                               onPressed: () {
  //                                 deleteUser(context).then((value) {
  //                                   showToast(value.message.toString());
  //                                   if (value.status == true) {
  //                                     showToast(value.message.toString());
  //                                     Get.to(const LoginScreen());
  //                                   }
  //                                 });
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                   backgroundColor: Colors.transparent,
  //                                   elevation: 0,
  //                                   minimumSize: Size(80, 40)),
  //                               child: Text('Yes, Delete This Address',
  //                                   style: TextStyle(
  //                                       fontSize: 14,
  //                                       fontWeight: FontWeight.w600,
  //                                       color: Colors.white))),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: width * .02,
  //                       ),
  //                       GestureDetector(
  //                         onTap: () {
  //                           Get.back();
  //                         },
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               border: Border.all(color: Color(0xFFF0433F))),
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(
  //                                 horizontal: 20, vertical: 13),
  //                             child: Center(
  //                                 child: Text('Cancel',
  //                                     style: TextStyle(
  //                                         fontSize: 14,
  //                                         fontWeight: FontWeight.w600,
  //                                         color: Color(0xFFFF5102)))),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  Widget _drawerTile({required bool active,
    required String title,
    required ImageIcon icon,
    required VoidCallback onTap}) {
    return ListTile(
      selectedTileColor: AppTheme.primaryColor,
      leading: icon,
      minLeadingWidth: 30,
      title: Text(
        title,
        style: GoogleFonts.quicksand(
          fontSize: 15,
          color: Color(0xff141414),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: active ? onTap : null,
    );
  }
}
