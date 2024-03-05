
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/screens/authentication_screens/LoginScreenMart.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../repositories/signup_screenofMart_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_text.dart';
import '../../resources/app_theme.dart';
import 'otp_screen_forLogin.dart';
class SignupScreenMart extends StatefulWidget {
  static var signUpScreenMart="/signUpScreenMart";
  const SignupScreenMart({super.key});

  @override
  State<SignupScreenMart> createState() => _SignupScreenMartState();
}

class _SignupScreenMartState extends State<SignupScreenMart> {

  final formSignup = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var obscureText1 = true;
  var obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double doubleVar;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formSignup,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*.06,),
                  Center(child: SvgPicture.asset(AppAssets.anand,height:130,width: size.width,)),
                  SizedBox(height: size.height*.04,),
                  Center(
                    child: Text("Create Account",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: AppTheme.secondaryColor,
                        // fontStyle: FontStyle.italic,
                      ),),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text("Create A New Account",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color:Color(0xFF33354B),
                        // fontStyle: FontStyle.italic,
                      ),),
                  ),
                  SizedBox(height: size.height*.03,),
                  Text("First Name",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color:Color(0xFF000000),
                      // fontStyle: FontStyle.italic,
                    ),),
                  SizedBox(height: 7,),
                  RegisterTextFieldWidget(
                    controller: firstNameController,
                    validator: MultiValidator([
                    RequiredValidator(
                    errorText:
                    'Please enter your first name '),]),
                    hint: "Enter First Name",
                  ),
                  SizedBox(height: size.height*.03,),
                  Text("Middle Name",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color:Color(0xFF000000),
                      // fontStyle: FontStyle.italic,
                    ),),
                  SizedBox(height: 7,),
                  RegisterTextFieldWidget(
                    controller: middleNameController,
                    // validator: MultiValidator([
                    //   RequiredValidator(
                    //       errorText:
                    //       'Please enter your middle name '),]),
                    hint: "Enter Middle Name",
                  ),
                  SizedBox(height: size.height*.03,),
                  Text("Last Name",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color:Color(0xFF000000),
                      // fontStyle: FontStyle.italic,
                    ),),
                  SizedBox(height: 7,),
                  RegisterTextFieldWidget(
                    controller: lastNameController,
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText:
                          'Please enter your last name '),]),
                    hint: "Enter Last Name",
                  ),
                  SizedBox(height: 12,),
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
                    validator: (value) {
                      if (emailController.text.isEmpty) {
                        return "Please enter your email";
                      } else if (emailController.text.contains('+') || emailController.text.contains(' ')) {
                        return "Email is invalid";
                      } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text)) {
                        return null;
                      } else {
                        return 'Please type a valid email address';
                      }
                    },
                    hint: "Enter Email",
                  ),
                  SizedBox(height: 12,),
                  Text("Phone Number",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color:Color(0xFF000000),
                      // fontStyle: FontStyle.italic,
                    ),),
                  SizedBox(height: 7,),
                  RegisterTextFieldWidget(
                    controller: phoneController,
                    keyboardType:
                    const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(
                          RegExp('[0-9]')),
                    ],
                    onChanged: (value) =>
                    doubleVar = double.parse(value),
                    validator: MultiValidator([
                      RequiredValidator(
                          errorText:
                          'Please enter your contact number '),
                      MinLengthValidator(10,
                          errorText:
                          'Please enter minumum  10 digit number'),
                      MaxLengthValidator(10,
                          errorText:
                          'Please enter 10 digit number'),
                      PatternValidator(
                          r'(^(?:[+0]9)?[0-9]{10,12}$)',
                          errorText: '')
                    ]),
                    hint: "Enter Phone Number",
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
                          errorText: 'Please enter your password'),
                      MinLengthValidator(8,
                          errorText: 'Password must be at least 8 characters, with 1 special character & 1 numerical'),
                      PatternValidator(
                          r"(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                          // r'^(?=.*[A-Z])(?=.*\d).{8,}$',
                          errorText: "Password must be at least with 1 special character & 1 numerical"),
                    ]),

                    obscureText: obscureText1,
                    hint: "Enter Password",
                    suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText1 =
                            !obscureText1;
                          });
                        },
                        child: obscureText1
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
                  Text("Confirm Password",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color:Color(0xFF000000),
                      // fontStyle: FontStyle.italic,
                    ),),
                  SizedBox(height: 7,),
                  RegisterTextFieldWidget(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Confirm password';
                      }
                      if (value.toString() ==
                          passwordController.text) {
                        return null;
                      }
                      return "Confirm password not matching with password";
                    },

                    obscureText: obscureText2,
                    hint: "Enter Confirm Password",
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

                  SizedBox(height: size.height*.06,),
                  CommonButtonGreen(title: "SIGN UP",onPressed: (){

                    if (formSignup.currentState!.validate()) {

                      register(
                        firstNameController.text,
                        middleNameController.text,
                        lastNameController.text,
                        emailController.text,
                        phoneController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                        5,
                        context
                      ).then((value){
                        if(value.status == true){
                          showToast(value.message);
                          Get.to(()=> OtpScreenForLogin(
                            emailAddress: emailController.text,
                          ));
                          // Get.toNamed(OtpScreenForLogin.otpScreenForLogin, arguments: emailController.text);
                        }
                        else{
                          showToast(value.message);
                        }
                      });


                    }

                  },),


                  SizedBox(height: size.height*.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?",
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Color(0xFF1C2550),
                          // fontStyle: FontStyle.italic,
                        ),),
                      InkWell(
                        onTap: (){
                          Get.toNamed(LoginScreenMart.loginScreenMart);
                        },
                        child: Text(" Login",
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
}
