import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/contactus_option_model.dart';
import '../repositories/common_repo/repository.dart';
import '../repositories/privacy_policy_repo.dart';
import '../resources/api_url.dart';
import '../resources/app_text.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import '../widgets/editprofile_textfield.dart';

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({Key? key}) : super(key: key);
  static var customerSupportScreen = "/customerSupportScreen";
  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  final formKey= GlobalKey<FormState>();
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final phoneController=TextEditingController();
  final messageController=TextEditingController();
  String? selectedReason;

  Repositories repositories= Repositories();
  ContactUsOptionModel? contactUsOptionModel;
  getReasonList(){
    repositories.getApi(url: ApiUrl.contactReasonOptionUrl).then((value){
      contactUsOptionModel = ContactUsOptionModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReasonList();
  }
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar2(title: 'Contact us', context: context),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.black12,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addHeight(7.0),
                        if(contactUsOptionModel != null)
                        Container(
                          // height: 15,
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white, border: Border.all(color: const Color(0xFFEEEEEE))),
                          child:
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              style: const TextStyle(
                                color: Color(0xFF697164),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              hint: Text(
                                'Select Reason',
                                style: TextStyle(
                                    color: AppTheme.userText,
                                    fontSize: AddSize.font14,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              ),
                              value: selectedReason,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF000000),
                              ),
                              items: contactUsOptionModel!.data!.reasons!.map((value) {
                                return DropdownMenuItem(

                                  value: value.id.toString(),
                                  child: Text(
                                    value.title.toString(),
                                    style: TextStyle(
                                      fontSize: AddSize.font14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedReason =
                                  (newValue as String?)!;
                                  log(selectedReason.toString());
                                });
                              },
                            ),
                          ),
                        ),
                        addHeight(20),
                        Text('Name',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(

                          controller: nameController,
                          hint: 'Arlene Mccoy',
                          onTap: (){},
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter your name";
                            }
                            return null;
                          },
                        ),
                        addHeight(20.0),
                        Text('Email',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          hint: 'Enter your email',
                          onTap: (){},
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please enter your email '),
                            EmailValidator(errorText: "please enter valid mail")

                          ]),

                        ),
                        addHeight(20.0),
                        Text('Phone Number',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: phoneController,
                          hint: 'Enter your phone number',
                          length: 10,
                          keyboardType: TextInputType.number,
                          validator: (value){
                            if(value!.isEmpty || value.length<10){
                              return 'Please enter 10 digit number';
                            }
                            return null;
                          },

                        ),
                        addHeight(20.0),
                        Text('Massage',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: messageController,
                          hint: 'type...',
                          onTap: (){},
                          maxLines: 3,
                          minLines: 3,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please share your experience '),]),


                        ),


                        addHeight(20),

                      ],
                    ),
                  ),

                  // addHeight(100),




                ],
              ),
            ),
          ),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
          child: CommonButton1(title: 'SEND MASSAGE',onPressed: (){
            if(formKey.currentState!.validate()){
              supportRepo(
                  name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
                message: messageController.text,
                reasonId: selectedReason.toString(),
                  context: context,
              ).then((value){
                if(value.status==true){
                  showToast(value.message);
                  Get.back();
                }else{
                  showToast(value.message);
                }
              });

            }
      }),
        ),
      ),
    );
  }

  // details(key, value, icon, onTap) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Expanded(
  //           child: Row(
  //             children: [
  //               Icon(icon),
  //               Text(
  //                 key,
  //                 style: Theme.of(context).textTheme.headline5!.copyWith(
  //                     fontWeight: FontWeight.w500, fontSize: AddSize.font16),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           child: Text(
  //             value,
  //             style: Theme.of(context).textTheme.headline5!.copyWith(
  //                 fontWeight: FontWeight.w500, color:AppTheme.primaryColor, fontSize: AddSize.font16),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
