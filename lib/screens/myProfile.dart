import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fresh2_arrive/repositories/common_repo/repository.dart';
import 'package:fresh2_arrive/repositories/update_profile_repository.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:fresh2_arrive/resources/app_assets.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';
import '../resources/app_text.dart';
import '../resources/new_helper.dart';
import '../widgets/add_text.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);
  static var myProfileScreen = "/myProfileScreen";

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final controller = Get.put(ProfileController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Repositories repositories = Repositories();

  getAddressData(){
    repositories.getApi(url: ApiUrl.myAddressUrl).then((value){

    });
  }

  showUploadWindow() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AddSize.padding16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AddSize.size10),
                    Text("Choose From Which",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: AddSize.font16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text("Gallery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font14)),
                          onPressed: () {
                            NewHelper().addFilePicker().then((value) {
                              controller.image.value = value!;
                              print("this is from gallery"+controller.image.value.path);
                            });
                            Get.back();
                          },
                        ),
                        TextButton(
                          child: Text("Camera",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.primaryColor,
                                  fontSize: AddSize.font14)),
                          onPressed: () {
                            NewHelper()
                                .addImagePicker(imageSource: ImageSource.camera)
                                .then((value) {
                              controller.image.value = value!;
                              print(controller.image.value.path);
                            });
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AddSize.size20,
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Obx(() {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.all(15),
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(bottom: 50),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.white)
                              ),
                              child: Image.asset('assets/images/profileBg.png')),
                          Positioned(
                            top: 90,
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10000),
                                  child: Container(

                                    height: 120,
                                    width: 120,
                                    // clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xffFAAF40),
                                      border: Border.all(
                                          color: const Color(0xffFE7E73),
                                          width: 6),
                                      // borderRadius: BorderRadius.circular(5000),
                                      // color: Colors.brown
                                    ),
                                    child:
                                    controller.image.value.path == "" ?
                                    controller.model.value.data!.userData!.profileImage ==
                                        '' ?
                                    const SizedBox(
                                      height: 100,
                                      width: 100,
                                    ) :
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        controller.model.value.data!.userData!
                                            .profileImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 70,
                                      ),
                                    )
                                    //ClipOval(child: Image.asset('assets/images/image 13.png',height: 98,))
                                        : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                        controller.image.value,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                                                        ),
                                        ),
                                    // Image.asset('assets/images/man.png',height: 70,width:40,fit: BoxFit.fill,)
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 170,
                            left: 210,
                            right: 122,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              // clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xff04666E),
                               // borderRadius: BorderRadius.circular(90),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showUploadWindow();
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 30,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                                  child: Image.asset(
                                    "assets/images/backArrow.png",
                                    height: AddSize.size25,
                                  ),
                                ),
                              ),
                         )
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            controller.isDataLoading.value ?
                          controller.model.value.data!.userData!
                              .firstName
                              .toString() :
                          "Alex Zander",
                          // profileData.userName.toString(),
                          style: GoogleFonts.poppins(
                              color: AppTheme.registortext,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Profile",
                          // profileData.email.toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Name',
                              style: GoogleFonts.poppins(
                                  color: AppTheme.registortext,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RegisterTextFieldWidget(
                                controller: controller.fNameController,
                                validator: RequiredValidator(
                                    errorText:
                                    'Please enter your First name'),
                                hint:
                                "First Name"

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Middle Name',
                              style: GoogleFonts.poppins(
                                  color: AppTheme.registortext,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RegisterTextFieldWidget(
                                controller: controller.mNameController,
                                validator: RequiredValidator(
                                    errorText:
                                    'Please enter your Middle name'),
                                hint:
                                "Middle Name"

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Last name",
                              style: GoogleFonts.poppins(
                                  color: AppTheme.registortext,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RegisterTextFieldWidget(
                                controller:  controller.lNameController,
                                validator: RequiredValidator(
                                    errorText: 'Please enter your Last name '),
                                // keyboardType: TextInputType.number,
                                // textInputAction: TextInputAction.next,
                                hint:
                                "Last name"

                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Email",
                              style: GoogleFonts.poppins(
                                  color: AppTheme.registortext,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RegisterTextFieldWidget(
                              controller: controller.emailController,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Please enter your email'),
                                EmailValidator(
                                    errorText: 'Enter a valid email address'),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              // textInputAction: TextInputAction.next,
                              hint: "demo@yopmail.com"
                              ,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Mobile Number",
                              style: GoogleFonts.poppins(
                                  color: AppTheme.registortext,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RegisterTextFieldWidget(
                              controller: controller.mobileController,
                              length: 10,
                              validator: RequiredValidator(
                                  errorText: 'Please enter your Mobile Number '),
                              keyboardType: TextInputType.number,
                              // textInputAction: TextInputAction.next,
                              hint: "Mobile Number"
                              ,
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            CommonButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                Map<String,String> mapData = {
                                  'first_name' : controller.fNameController.text,
                                  'middle_name' : controller.mNameController.text,
                                  'last_name' : controller.lNameController.text,
                                  'email' : controller.emailController.text,
                                  'phone' : controller.mobileController.text,
                                };
                                editUserProfileRepo(
                                  context: context,
                                  mapData: mapData,
                                    fieldName1: "profile_image",
                                file1: controller.image.value,

                                ).then((value){
                                  if(value.status == true){
                                    showToast(value.message);
                                    controller.getData();
                                    Get.back();
                                  }
                                  else{
                                    showToast(value.message);
                                  }
                                });
                                }
                              },
                              title: 'SAVE',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
