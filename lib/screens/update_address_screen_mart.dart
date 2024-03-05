import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/repositories/common_repo/repository.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/MyAddress_controller.dart';
import '../model/get_myaddress_model.dart';
import '../repositories/add_address_repository.dart';
import '../resources/app_text.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import '../widgets/editprofile_textfield.dart';
import 'my_address.dart';

class UpdateAddressScreenMart extends StatefulWidget {
  final String addressId;
  final String addressType;
  const UpdateAddressScreenMart({Key? key, required this.addressId, required this.addressType}) : super(key: key);
  static var customerSupportScreen = "/customerSupportScreen";
  @override
  State<UpdateAddressScreenMart> createState() => _UpdateAddressScreenMartState();
}

class _UpdateAddressScreenMartState extends State<UpdateAddressScreenMart> {
  final formKey= GlobalKey<FormState>();
  final addressController = Get.put(MyAddressController());
  final address1Controller=TextEditingController();
  final address2Controller=TextEditingController();
  final cityController=TextEditingController();
  final stateController=TextEditingController();
  final zipcodeController=TextEditingController();
  final otherController=TextEditingController();
  final addressTypeController=TextEditingController();
  final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  RxString selectedChip = "Home".obs;

  Repositories repositories = Repositories();
  SingleAddressModel? singleAddressModel;

  getAddressData(){
    repositories.getApi(url: "${ApiUrl.singleAddressUrl}/${widget.addressId}").then((value){
      singleAddressModel = SingleAddressModel.fromJson(jsonDecode(value));
      address1Controller.text= singleAddressModel!.data!.address1.toString();
      address2Controller.text= singleAddressModel!.data!.address2.toString();
      cityController.text= singleAddressModel!.data!.city.toString();
      stateController.text= singleAddressModel!.data!.state.toString();
      zipcodeController.text= singleAddressModel!.data!.zipCode.toString();
      otherController.text= singleAddressModel!.data!.otherInstruction.toString();
      selectedChip.value = singleAddressModel!.data!.addressType ?? "Home";
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddressData();
  }
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar2(title: 'Update Address', context: context),
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
                        Text('Address Type',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              choiceAddress.length,
                                  (index) => chipList(choiceAddress[index]),
                            )
                        ),
                        addHeight(20.0),
                        Text('Address 1',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: address1Controller,
                          hint: 'Address 1',
                          onTap: (){},
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please enter your address '),]),
                        ),
                        addHeight(20.0),
                        Text('Address 2',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: address2Controller,
                          hint: 'Address 2',
                          onTap: (){},
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please enter your address '),
                          ]),

                        ),
                        addHeight(20.0),
                        Text('City',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: cityController,
                          hint: 'Enter your city',
                          length: 10,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter your city';
                            }
                            return null;
                          },

                        ),
                        addHeight(20.0),
                        Text('State',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: stateController,
                          hint: 'state',
                          onTap: (){},
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Enter your state '),]),


                        ),
                        addHeight(20.0),
                        Text('Zipcode',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: zipcodeController,
                          hint: 'zipcode',
                          onTap: (){},
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Enter your zipcode '),]),


                        ),
                        addHeight(20.0),
                        Text('Other instructions',style: GoogleFonts.quicksand(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),),
                        addHeight(7.0),
                        EditProfileTextFieldWidget(
                          controller: otherController,
                          hint: 'Other instructions',
                          onTap: (){},


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
          child: CommonButton1(title: 'UPDATE',onPressed: (){
            if(formKey.currentState!.validate()){
              editAddress(
                  address1: address1Controller.text,
                  address2: address2Controller.text,
                  city: cityController.text,
                  state: stateController.text,
                  zipCode: zipcodeController.text,
                  addressType: selectedChip.value,
                  otherInstruction: otherController.text,
                id: widget.addressId,
                  context: context, )
                  .then((value) {
                showToast(value.message);
                if (value.status == true) {
                  Get.toNamed(MyAddress
                      .myAddressScreen);
                  addressController
                      .getAddress();
                  Get.back();
                  Get.back();
                }
              });


            }
          }),
        ),
      ),
    );
  }
  chipList(
      title,
      ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Column(
        children: [
          ChoiceChip(

            padding: EdgeInsets.symmetric(
                horizontal: width * .01, vertical: height * .01),
            backgroundColor: AppTheme.backgroundcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: title != selectedChip.value
                        ? Colors.grey.shade300
                        : const Color(0xff4169E2))),
            label: Text("$title",
                style: TextStyle(
                    color: title != selectedChip.value
                        ? Colors.grey.shade600
                        : const Color(0xff4169E2),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500)),
            selected: title == selectedChip.value,
            selectedColor: const Color(0xff4169E2).withOpacity(.3),
            onSelected: (value) {
              selectedChip.value = title;
              log(selectedChip.value);
              setState(() {});
            },
          )
        ],
      );
    });
  }
}
