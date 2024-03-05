import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/repositories/common_repo/repository.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/contact_reason_model.dart';
import '../repositories/privacy_policy_repo.dart';
import '../resources/app_text.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import '../widgets/editprofile_textfield.dart';

class NewRequestScreen extends StatefulWidget {
  final Function() update;
  const NewRequestScreen({Key? key, required this.update}) : super(key: key);
  static var customerSupportScreen = "/customerSupportScreen";
  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  final formKey= GlobalKey<FormState>();
  final messageController=TextEditingController();

  @override
  void initState() {
    super.initState();
    getReasonList();
  }
  bool value = false;
  String? selectedTime;

  Repositories repositories= Repositories();
  ContactReasonModel? contactReasonModel;
  getReasonList(){
    repositories.getApi(url: ApiUrl.contactReasonUrl).then((value){
      contactReasonModel = ContactReasonModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar2(title: 'Add New Requests', context: context),
        body:
        contactReasonModel != null ?
        SingleChildScrollView(
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

                        borderRadius: BorderRadius.circular(10),
                 ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select Reason',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
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
                              value: selectedTime,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF000000),
                              ),
                              items: contactReasonModel!.data!.map((value) {
                                return DropdownMenuItem(

                                  value: value.id.toString(),
                                  child: Text(
                                    value.name.toString(),
                                    style: TextStyle(
                                      fontSize: AddSize.font14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedTime =
                                  newValue as String?;
                                log(selectedTime.toString());
                                });
                              },
                            ),
                          ),
                        ),
                        addHeight(20),
                        Text('Content',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: messageController,
                          hint: 'Text...',
                          onTap: (){},
                          maxLines: 3,
                          minLines: 3,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please share your experience '),]),


                        ),

                        addHeight(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30,),
                          child: CommonButton1(title: 'SUBMIT',onPressed: (){
                            if(formKey.currentState!.validate()){
                              sendRequestToAdmin(
                                reasonId: selectedTime.toString(),
                                  message: messageController.text,
                                  context: context,
                              ).then((value){
                                if(value.status==true){
                                  showToast(value.message);
                                  widget.update();
                                  Get.back();
                                }else{
                                  showToast(value.message);
                                }
                              });

                            }
                          }),
                        ),

                      ],
                    ),
                  ),

                  // addHeight(100),




                ],
              ),
            ),
          ),
        ):Center(child: CircularProgressIndicator(color: Colors.green,),),


      ),
    );
  }
}
