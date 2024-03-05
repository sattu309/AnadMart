import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/forgot_password_repo.dart';
import '../../resources/app_text.dart';
import '../../widgets/add_text.dart';


class OtpScreenForLogin extends StatefulWidget {
  const OtpScreenForLogin({Key? key, required this.emailAddress}) : super(key: key);
  final String emailAddress;
  @override
  State<OtpScreenForLogin> createState() => _OtpScreenForLoginState();
}

class _OtpScreenForLoginState extends State<OtpScreenForLogin> {
  final TextEditingController otpController = TextEditingController();
  RxBool hasError1 = false.obs;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * .15,
              ),
              Center(
                child: Text('Please Enter customer verify \nyour OTP',
                  style: GoogleFonts.quicksand(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color:  Color(0xFF2B2E4C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: screenHeight * .08,
              ),
              Center(
                child: Text('Enter your pin',
                  style: GoogleFonts.quicksand(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color:  Color(0xFF41435C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              addHeight(35),
              PinCodeTextField(
                appContext: context,
                textStyle: const TextStyle(color: Colors.grey),
                controller: otpController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                pastedTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.isEmpty) {
                    return "OTP code Required";
                  } else if (v.length != 4) {
                    return "Enter complete OTP code";
                  }
                  return null;
                },
                length: 4,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    // borderRadius: BorderRadius.circular(5),
                    fieldWidth: 60,
                    fieldHeight: 50,
                    activeFillColor: Colors.black,
                    inactiveColor:  Colors.grey.shade300,
                    inactiveFillColor: Colors.green,
                    selectedFillColor: Colors.deepPurple,
                    selectedColor: Colors.green,
                    activeColor: Colors.black
                ),
                cursorColor: Colors.green,
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  setState(() {
                    // currentText = v;
                  });
                },
              ),
              addHeight(45),
              CommonButton(title: 'CONFIRM',onPressed: (){
                print("Email is "+widget.emailAddress);
                verifyOtpForLoginRepo(email: widget.emailAddress, otp: otpController.text, context: context).then((value) async {
                  if(value.status == true){
                   SharedPreferences pref = await SharedPreferences.getInstance();
                   pref.setString("user_info", jsonEncode(value));
                    showToast(value.message);
                    Get.toNamed(CustomNavigationBar.customNavigationBar);
                  }else{
                    showToast(value.message);
                  }
                });
        
        
              },),
              addHeight(25),
              Center(
                child: GestureDetector(
                  onTap: (){
                    resendOtpRepo(email: widget.emailAddress,context: context).then((value){
                      if(value.status==true){
                        showToast(value.message);
                      }else{
                        showToast(value.message);
                      }
                    });
                  },
                  child: Text('Resent OTP',
                    style: GoogleFonts.quicksand(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color:  Color(0xFF4169E2),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
