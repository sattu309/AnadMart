
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/app_assets.dart';
import '../resources/app_theme.dart';
import 'authentication_screens/LoginScreenMart.dart';
import 'onboarding_list.dart';

class OnBoardingScreen extends StatefulWidget {
  static var onboardingScreen = "/onboardingScreen";
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  final RxInt _pageIndex = 0.obs;
  bool loginLoaded = false;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  int currentIndex = 0;
  RxInt currentIndex12 = 0.obs;
  RxBool currentIndex1 = false.obs;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          PageView.builder(
              itemCount: OnBoardingData.length ,
              controller: controller,
              physics: loginLoaded ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
              pageSnapping: true,
              onPageChanged: (index) {
                setState(() {
                  _pageIndex.value = index;
                  if (OnBoardingData.length == index) {
                    loginLoaded = true;
                  } else {
                    loginLoaded = false;
                  }
                });
              },
              itemBuilder: (context, index) {
                if (OnBoardingData.length == index) {
                  loginLoaded = true;
                  // return const LoginScreen();
                }

                loginLoaded = false;
                return OnboardContent(
                  controller: controller,
                  indexValue: _pageIndex.value,
                  image: OnBoardingData[index].image.toString(),
                  title: OnBoardingData[index].title.toString(),
                  description: OnBoardingData[index].description.toString(),
                );
              }),
        ],
      ),
    ));
  }
}

class CustomIndicator extends StatelessWidget {
  final bool isActive;

  const CustomIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: isActive ? 25 : 10,
          height: 7,
          decoration: BoxDecoration(

              color: isActive ? const Color(0xff000000) : const Color(0xff666666),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
        ));
  }
}

class OnboardContent extends StatelessWidget {
  final String image, title, description;
  final int indexValue;
  PageController controller = PageController();

  OnboardContent(
      {Key? key,
      required this.controller,
      required this.image,
      required this.title,
      required this.description,
      required this.indexValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(children: [
      Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Flexible(
                child: SizedBox(
              height: height * 3,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children:[ Image.asset(
                    height: height * 3,
                    width: width,
                    image,
                    fit: BoxFit.fill,
                  ),
                    Positioned(
                        right: 18,
                        top: 10,

                        child: InkWell(
                          onTap: (){
                            // controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                            //         if (indexValue == 2) {
                                  Get.toNamed(LoginScreenMart.loginScreenMart);
                                    // }
                          },
                          child: Text("Skip",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppTheme.onboardingColor,
                              // fontStyle: FontStyle.italic,
                            ),),
                        ))
                ]),
              ),
            )),

            Column(
              children: [


                SizedBox(
                  height: height * .01,
                ),
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    color: AppTheme.onboardingColor,
                    // fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    description,
                    style:  GoogleFonts.quicksand(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppTheme.onboardingDescColor,
                      // fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * .06,
                ),
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 28.0,right: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
                OnBoardingData.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CustomIndicator(
                    isActive: index == indexValue,
                  ),
                )),
            Spacer(),
            InkWell(

                onTap: (){
                  controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                            if (indexValue == 2) {
                               Get.toNamed(LoginScreenMart.loginScreenMart);
                            }
                },
                child: SvgPicture.asset(AppAssets.arrow)),
          ],
        ),
      ),

      // Container(
      //     height: height * .08,
      //     width: width * .95,
      //     decoration: const BoxDecoration(
      //       shape: BoxShape.circle,
      //     ),
      //     child: ElevatedButton(
      //         onPressed: () {
      //           controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
      //           if (indexValue == 2) {
      //             // Get.toNamed(MyRouters.loginScreen);
      //           }
      //         },
      //         style: ElevatedButton.styleFrom(
      //             shape: CircleBorder(),
      //             primary: const Color(0xFF3B5998),
      //             textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      //      child: Image.asset(height:23,width: 23,'assets/icons/arrow.png'),)),
      SizedBox(
        height: height * .07,
      ),
    ]);
  }
}
