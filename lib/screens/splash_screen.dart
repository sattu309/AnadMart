import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_assets.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  userCheck() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user_info') != null) {
     Get.offAllNamed(CustomNavigationBar.customNavigationBar);
    }
    else{
      Get.offAllNamed(OnBoardingScreen.onboardingScreen);
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      userCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(15),
            child: SvgPicture.asset(AppAssets.anand),
          )),

        ],
      ),
    );
  }
}
