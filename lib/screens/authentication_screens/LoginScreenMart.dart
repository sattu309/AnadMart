
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/screens/customer_homepage.dart';
import 'package:fresh2_arrive/screens/authentication_screens/forgot_password_Screen.dart';
import 'package:fresh2_arrive/screens/authentication_screens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repositories/login_repository.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_text.dart';
import '../../resources/app_theme.dart';
import '../../widgets/add_text.dart';
import '../custum_bottom_bar.dart';
import '../homepage.dart';
class LoginScreenMart extends StatefulWidget {
  static var loginScreenMart="/loginScreenMart";
  const LoginScreenMart({super.key});

  @override
  State<LoginScreenMart> createState() => _LoginScreenMartState();
}

class _LoginScreenMartState extends State<LoginScreenMart> {

  final formLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var obscureText1 = true;
  var obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formLogin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*.06,),
                  Center(child: SvgPicture.asset(AppAssets.anand,height:130,width: size.width,)),
                  SizedBox(height: size.height*.04,),
              Center(
                child: Text("Welcome Back",
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    color: AppTheme.secondaryColor,
                    // fontStyle: FontStyle.italic,
                  ),),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Sign To Continue",
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color:Color(0xFF33354B),
                    // fontStyle: FontStyle.italic,
                  ),),
              ),
                  SizedBox(height: size.height*.03,),
                  Text("Email",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color:Color(0xFF000000),
                      // fontStyle: FontStyle.italic,
                    ),),
                  SizedBox(height: 7,),
                  RegisterTextFieldWidget(
                    controller: emailController,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText:
                          'Please enter your email '),
                      EmailValidator(errorText: "please enter valid mail")

                    ]),
                           hint: "Enter Email",
                        ),
                  SizedBox(height: 12,),
                  Text("Password",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color:Color(0xFF000000),
                      // fontStyle: FontStyle.italic,
                    ),),
                  SizedBox(height: 7,),
                  RegisterTextFieldWidget(
                    controller: passwordController,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText: 'Please Enter Your Password'),
                    ]),

                    obscureText: obscureText2,
                    hint: "Enter Password",
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText2 =
                            !obscureText2;
                          });
                        },
                        child: obscureText2
                            ? const Icon(
                          Icons.visibility_off,
                          color: Color(0xFF6A5454),
                        )
                            : const Icon(
                            Icons.visibility,
                            color: Color(
                                0xFF6A5454))),

                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(ForgotPasswordScreen.forgotPasswordScreen);
                        },
                        child: Text("Forget Password",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                            // fontStyle: FontStyle.italic,
                          ),),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*.06,),
                  CommonButtonGreen(title: "LOG IN",onPressed: () async {

              if (formLogin.currentState!.validate()) {
                var fcmToken= await FirebaseMessaging.instance.getToken();
                createLogin(
                    userEmail: emailController.text,
                   userPassword: passwordController.text,
                  deviceToken: fcmToken!,
                    context: context,
                  role: '5',)
                    .then((value) async {
                  showToast(value.message.toString());
                  if (value.status == true) {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    pref.setString("user_info", jsonEncode(value));
                    showToast(value.message.toString());
                    Get.offAllNamed(
                        CustomNavigationBar.customNavigationBar);
                  }
                });


                 }
                  },),

                  SizedBox(height: size.height*.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/apple.svg"),
                      SizedBox(width: 20,),
                      SvgPicture.asset("assets/images/facebook.svg"),
                      SizedBox(width: 20,),
                      GestureDetector(
                              onTap: (){
                                signInWithGoogle();
                              },
                          child: SvgPicture.asset("assets/images/google.svg")),


                    ],
                  ),
                  SizedBox(height: size.height*.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t you have an account? ",
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Color(0xFF1C2550),
                          // fontStyle: FontStyle.italic,
                        ),),
                      InkWell(
                        onTap: (){
                          Get.toNamed(SignupScreenMart.signUpScreenMart);
                        },
                        child: Text("Signup Now!",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: AppTheme.primaryColor,
                            // fontStyle: FontStyle.italic,
                          ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((e){
      throw Exception(e);
    });

    log(googleUser!.email.toString());

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final value = await FirebaseAuth.instance.signInWithCredential(credential);

    log("Tokenisss -------${value.credential!.accessToken}");
    // log(value.additionalUserInfo!.a);
    socialLogin(
        provider: "google",
        token: value.credential!.accessToken!,
        context: context,
        role: "5",
    ).then((value) async {
      if (value.status == true) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user_info', jsonEncode(value));
        showToast(value.message);
        Get.offAllNamed(
            CustomNavigationBar.customNavigationBar);
      } else {
        showToast(value.message);
      }
    });
  }
}
