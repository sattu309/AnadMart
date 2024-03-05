import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../repositories/forgot_password_repo.dart';
import '../../resources/app_assets.dart';
import '../../resources/app_text.dart';
import '../../widgets/add_text.dart';
import 'otp_sreenofMart.dart';


class ForgotPasswordScreen extends StatefulWidget {
  static var forgotPasswordScreen ="/forgotPasswordScreen";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          // height: screenHeight,
          child: Stack(
              children:[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: SvgPicture.asset(AppAssets.anand),
                    )
                  ],
                ),
                Positioned(
                  top: 300,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text('Forgot Password',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color:  Color(0xFF2B2E4C),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              addHeight(45),
                              Text("Email",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color:Color(0xFF000000),
                                  // fontStyle: FontStyle.italic,
                                ),),
                              addHeight(7),
                              Container(
                                width: screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: const Color(0xFF37C666).withOpacity(0.10),
                                    //     offset: const Offset(.1, .1,
                                    //     ),
                                    //     blurRadius: 20.0,
                                    //     spreadRadius: 1.0,
                                    //   ),
                                    // ],
                                    //color: Colors.white
                                ),
                                child:   RegisterTextFieldWidget(
                                  controller: emailController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                        'Please enter your Email '),
                                    EmailValidator(errorText: "please enter valid mail")

                                  ]),
                                  hint: "Enter Email",
                                ),
                              ),
                              addHeight(45),
                              CommonButton(title: 'Send',onPressed: (){
                                print("THis is email for forgot"+ emailController.text);
                                if(_formKey.currentState!.validate()){
                                  forgotPasswordRepo(email: emailController.text, context: context,).then((value) {
                                    if(value.status == true){
                                      showToast(value.message.toString() + "${value.data}");
                                      Get.toNamed(OtpScreenOfMart.otpScreenOfMart, arguments: emailController.text);
                                    }else{
                                      showToast(value.message.toString());
                                    }
                                  });
                                }

                              },),
                            ],
                          ),
                        ),
                      )
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
