import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/MyAddress_controller.dart';
import '../repositories/add_address_repository.dart';
import '../resources/app_text.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import '../widgets/editprofile_textfield.dart';
import 'my_address.dart';

class AddressScreenMart extends StatefulWidget {
  const AddressScreenMart({Key? key}) : super(key: key);
  static var customerSupportScreen = "/customerSupportScreen";
  @override
  State<AddressScreenMart> createState() => _AddressScreenMartState();
}

class _AddressScreenMartState extends State<AddressScreenMart> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: backAppBar2(title: 'Add New Address', context: context),
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
          child: CommonButton1(title: 'SAVE',onPressed: (){
            if(formKey.currentState!.validate()){
              addAddress(
                  address1: address1Controller.text,
                  address2: address2Controller.text,
                  city: cityController.text,
                  state: stateController.text,
                  zipCode: zipcodeController.text,
                  addressType: selectedChip.value,
                  otherInstruction: otherController.text,
                  context: context)
                  .then((value) {
                showToast(value.message);
                if (value.status == true) {
                  Get.toNamed(MyAddress
                      .myAddressScreen);
                  addressController
                      .getAddress();
                }
                Get.back();
                Get.back();
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
