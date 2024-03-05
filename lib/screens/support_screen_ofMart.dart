import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/my_request_ofMart.dart';
import 'package:fresh2_arrive/screens/rewards_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/my_request_model.dart';
import '../repositories/common_repo/repository.dart';
import '../resources/api_url.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';


class SupportScreenOfMart extends StatefulWidget {
  static var supportScreenOfMart = "/supportScreenOfMart";
  const SupportScreenOfMart({Key? key}) : super(key: key);

  @override
  State<SupportScreenOfMart> createState() => _SupportScreenOfMartState();
}

class _SupportScreenOfMartState extends State<SupportScreenOfMart> {

  final TextEditingController tipController=TextEditingController();
  var currentDrawer = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: DefaultTabController(
        length:3,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.green,
              surfaceTintColor: Colors.white,
              toolbarHeight: 180,
              elevation: 1,
              title:  Column(
                children: [
                  addHeight(10),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     GestureDetector(
                       onTap: (){
                         Get.back();
                       },
                       child: Image.asset(
                         "assets/images/backArrow.png",
                         height: AddSize.size25,
                         color: Colors.white,
                       ),
                     ),

                   ],
                 ),
                  Text(
                    "Ask us anything" ,style:  GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600, fontSize: 30, color: Color(0xffFFFFFF)),
                    // controller.model.value.data!.latestProducts![index].buttonCount.value
                    //     .toString(),
                  ),
                  addHeight(10),
                  Text(
                    "Have any questions? We're here to assist you." ,style:  GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xffFFFFFF)),
                    // controller.model.value.data!.latestProducts![index].buttonCount.value
                    //     .toString(),
                  ),
                  addHeight(20),
                  SizedBox(
                    height: height * .047,
                    width: 310,
                    child: TextField(
                      maxLines: 1,
                      //controller: searchController,
                      style: const TextStyle(fontSize: 17),
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) => {},
                      decoration: InputDecoration(
                          filled: true,

                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(18))),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: height * .016,
                              horizontal: width * .02),
                          hintText: 'Search here',
                          prefixIcon: Icon(Icons.search_rounded,),
                          hintStyle: GoogleFonts.quicksand(
                              fontSize: AddSize.font14,
                              color: Color(0xff787777),
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppTheme.primaryColor,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 15),
                // automaticIndicatorColorAdjustment: true,
                onTap: (value) {
                  currentDrawer = 0;
                  setState(() {});
                },
                tabs: [
                  Tab(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(()=>MyRequestScreen());
                      },
                      child: Text(
                        "My Requests",
                        style: currentDrawer == 0
                            ? GoogleFonts.quicksand(fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFFFFFF))
                            : GoogleFonts.poppins(color: AppTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),

                  ),
                  Tab(
                    child: Text(

                      "Orders",
                      style: currentDrawer == 1
                          ? GoogleFonts.quicksand(fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFFFFFF))
                          : GoogleFonts.poppins(color: Color(0xffFFFFFF), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>RewardsScreen());
                    },
                    child: Tab(
                      child: Text(
                        "Accounts",
                        style: currentDrawer == 1
                            ? GoogleFonts.quicksand(fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFFFFFF))
                            : GoogleFonts.poppins(color: Color(0xffFFFFFF), fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body:
            TabBarView(
              children: [

                SingleChildScrollView(
                  child: Container(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                        ],
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                          Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Card(
                                color: Color(0xffFFFFFF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      addHeight(10),
                                      Container(
                                        // padding: EdgeInsets.all(8),
                                        // margin: EdgeInsets.all(5),
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff4DBA4D).withOpacity(.10),
                                          // image: DecorationImage(
                                          //   image: AssetImage(
                                          //
                                          //     AppAssets.wishlistIconnns,),
                                          // )
                                        ),
                                        child: Icon(Icons.mail_outline_rounded,size: 18,color: Colors.green,),
                                      ),
                                      addHeight(10),
                                      Text(
                                        "How do I change my account email?",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),
                                      Text(
                                        "You can log in to your account and change it from your Profile > Edit Profile. Then go to the general tab to change your email.",
                                        // homeController1.model.value
                                        //     .data!.recommendedStore![index].name
                                        //     .toString(),
                                        style: GoogleFonts.inter(fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff53686A)),),
                                      addHeight(10),

                                    ],
                                  ),
                                )),
                          ),
                          addHeight(8),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

            )

        ),
      ),
    );

  }

}
