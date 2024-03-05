import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/screens/authentication_screens/reset_password_screenofMart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../repositories/forgot_password_repo.dart';
import '../../resources/app_text.dart';
import '../../widgets/add_text.dart';


class OtpScreenOfMart extends StatefulWidget {
  static var otpScreenOfMart ="/otpScreenOfMart";
  const OtpScreenOfMart({Key? key}) : super(key: key);

  @override
  State<OtpScreenOfMart> createState() => _OtpScreenOfMartState();
}

class _OtpScreenOfMartState extends State<OtpScreenOfMart> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  RxBool hasError1 = false.obs;
  String text = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
                print("Email is "+text);
                verifyOtpRepo(email: text, otp: otpController.text, context: context, forgot_password: 'forgot_password').then((value){
                  if(value.status == true){
                    showToast(value.message);
                    Get.toNamed(ResetPasswordScreen.resetPasswordScreen, arguments: text);
                  }else{
                    showToast(value.message);
                  }
                });


              },),
              addHeight(25),
              Center(
                child: GestureDetector(
                  onTap: (){
                    resendOtpRepo(email: text,context: context).then((value){
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
