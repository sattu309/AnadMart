import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/screens/authentication_screens/LoginScreenMart.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../repositories/forgot_password_repo.dart';
import '../resources/app_assets.dart';
import '../resources/app_text.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';


class ChangePasswordScreen extends StatefulWidget {
  static var changePasswordScreen ="/changePasswordScreen";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var obscureText1 = true;
  var obscureText2 = true;
  var obscureText3 = true;
  // String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  top: 50,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Image.asset(
                        "assets/images/backArrow.png",
                        height: AddSize.size25,
                        color: Colors.green,
                      ),
                    ),
                  ),
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
                                child: Text('Change Password',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color:  Color(0xFF2B2E4C),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              addHeight(45),
                              Text("Old Password",
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
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF37C666).withOpacity(0.10),
                                        offset: const Offset(.1, .1,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child:  RegisterTextFieldWidget(
                                  controller: oldPasswordController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Please enter your old password'),
                                    // MinLengthValidator(8,
                                    //     errorText: 'Password must be at least 8 characters, with 1 special character & 1 numerical'),
                                    // PatternValidator(
                                    //     r"(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                                    //     errorText: "Password must be at least with 1 special character & 1 numerical"),
                                  ]),

                                  obscureText: obscureText3,
                                  hint: "Enter Old Password",
                                  suffix: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          obscureText3 =
                                          !obscureText3;
                                        });
                                      },
                                      child: obscureText3
                                          ? const Icon(
                                        Icons.visibility_off,
                                        color: Color(0xFF6A5454),
                                      )
                                          : const Icon(
                                          Icons.visibility,
                                          color: Color(
                                              0xFF6A5454))),

                                ),
                              ),
                              SizedBox(height: 12,),
                              Text("New Password",
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
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF37C666).withOpacity(0.10),
                                        offset: const Offset(.1, .1,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                    color: Colors.white
                                ),
                                child:  RegisterTextFieldWidget(
                                  controller: newPasswordController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Please enter your password'),
                                    MinLengthValidator(8,
                                        errorText: 'Password must be at least 8 characters, with 1 special character & 1 numerical'),
                                    PatternValidator(
                                        r"(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                                        errorText: "Password must be at least with 1 special character & 1 numerical"),
                                  ]),

                                  obscureText: obscureText2,
                                  hint: "Enter New Password",
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
                              Container(
                                width: screenWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF37C666).withOpacity(0.10),
                                      offset: const Offset(.1, .1,
                                      ),
                                      blurRadius: 20.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                  color: Colors.white
                                ),
                                child: RegisterTextFieldWidget(
                                  controller: confirmPasswordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Confirm password';
                                    }
                                    if (value.toString() ==
                                        newPasswordController.text) {
                                      return null;
                                    }
                                    return "Confirm password not matching with password";
                                  },

                                  obscureText: obscureText1,
                                  hint: "Enter Confirm Password",
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
                              ),
                              addHeight(45),
                              CommonButton(title: 'Send',onPressed: (){

                                if(_formKey.currentState!.validate()){
                                  changePasswordRepo(
                                    oldPassword: oldPasswordController.text,
                                      newPassword: newPasswordController.text,
                                      confirmPassword: confirmPasswordController.text,
                                      context: context).then((value){
                                    if(value.status == true){
                                      showToast(value.message);
                                      Get.back();
                                    }
                                    else{
                                      showToast(value.message);
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
