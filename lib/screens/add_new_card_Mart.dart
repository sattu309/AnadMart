import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/app_text.dart';
import '../widgets/dimensions.dart';
import '../widgets/editprofile_textfield.dart';

class AddNewCardScreenMart extends StatefulWidget {
  const AddNewCardScreenMart({Key? key}) : super(key: key);
  static var addNewCardScreenMart = "/addNewCardScreenMart";

  @override
  State<AddNewCardScreenMart> createState() => _AddNewCardScreenMartState();
}

class _AddNewCardScreenMartState extends State<AddNewCardScreenMart> {
  // final privacyController = Get.put(PrivacyController());

  @override
  void initState() {
    super.initState();
    // privacyController.getData();
  }

  @override
  bool showErrorMessage = false;
  bool value = false;
  RxBool checkboxColor = false.obs;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar2(title: 'Add New Card', context: context),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          // BoxShadow(
                          //   color:Colors.black12,
                          //   offset: const Offset(
                          //     5.0,
                          //     5.0,
                          //   ),
                          //   blurRadius: 10.0,
                          //   spreadRadius: 2.0,
                          // ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/images/newCard.png"),
                        addHeight(22.0),
                        Text('Card Name',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          hint: 'Andrew Ainsley',
                          onTap: (){},
                        ),
                        addHeight(20),
                        Text('Card Number',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          hint: '2345 4633 7865 9876',
                          onTap: (){},
                        ),
                        addHeight(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Exp. Date ',style: GoogleFonts.quicksand(
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),),
                                  addHeight(7),
                                  EditProfileTextFieldWidget(
                                    hint: '09/10/2028',
                                    onTap: (){},
                                  ),
                                ],
                              ),
                            ),
                            addWidth(29.88),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('CVV ',style: GoogleFonts.quicksand(
                                        color: const Color(0xFF000000),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),),


                                      addHeight(7),
                                      EditProfileTextFieldWidget(
                                        hint: '5135',
                                        onTap: (){},
                                      ),
                                    ]) )


                          ],
                        ),


                        addHeight(20),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
          child: CommonButton1(title: 'ADD',onPressed: (){
            // if (value != true) {
            //   setState(() {
            //     showErrorMessage = true;
            //     ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(
            //           content: Text(
            //               "Agree to our terms of Service"),
            //         ));
            //   }
            //   );
            // }
            // else {
            //   setState(() {
            //     showErrorMessage = false;
            //     // Get.toNamed(MyRouters.emailVerificationScreen);
            //   });
            // }
          }),
        ),
      ),
    );
  }

}
