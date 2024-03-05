import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/products_screen.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class SubCategoryOfCategory extends StatefulWidget {
  const SubCategoryOfCategory({Key? key}) : super(key: key);

  @override
  State<SubCategoryOfCategory> createState() => _SubCategoryOfCategoryState();
  static var subCategoryOfCategory= "/subCategoryOfCategory";
}

class _SubCategoryOfCategoryState extends State<SubCategoryOfCategory> {
  final subCategoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    subCategoryController.getSubCategoryData().then((value){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        appBar: backAppBar2(title: "Sub Category", context: context),
        backgroundColor: Colors.grey.shade100,
        body:
        Obx(() {
          return
            subCategoryController.isSubCategoryDataLoaded.value && subCategoryController.subCatModel.value.data != null ?
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AddSize.padding12),
                  child: SingleChildScrollView(
                    // controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: AddSize.size20,),
                        GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: subCategoryController.subCatModel.value.data!.subCategory!.length,
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 16.0,
                                mainAxisExtent: 140,
                                mainAxisSpacing: 0.0),
                            itemBuilder: (context, index) {
                              var itemdata = subCategoryController.subCatModel.value.data!.subCategory![index];
                              return GestureDetector(

                                onTap: () {
                                  // categoryProductController.categoryId.value = itemdata.id.toString();
                                  // log("sub category id "+ categoryProductController.categoryId.value);
                                  // Get.toNamed(ProductScreenOfMart.productScreen);
                                  Get.to(()=>ProductScreenOfMart(categoryId: itemdata.id.toString()));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      //height: 100,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding10,
                                            // vertical: AddSize.padding10
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF6F6F6),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: AddSize.size50 * 1.5,
                                              width: AddSize.size50 * 2,
                                              child:
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  // imageUrl: "https://img.freepik.com/free-photo/cute-woman-bright-hat-purple-blouse-is-leaning-stand-with-dresses-posing-with-package-isolated-background_197531-17610.jpg",
                                                  imageUrl: itemdata.image.toString(),
                                                  errorWidget: (_, __, ___) => const SizedBox(),
                                                  placeholder: (_, __) => const SizedBox(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              //Image.asset("assets/images/bottleIMG.png",)
                                            ),
                                          ],
                                        )),
                                    addHeight(6),
                                    Expanded(
                                      child: Text(
                                        // "Watch",
                                        itemdata.name.toString().capitalizeFirst!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppTheme.subText,
                                            fontSize: AddSize.font14,
                                            fontWeight: FontWeight.w500),
                                      ),

                                    ),
                                    addHeight(12)
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ): Center(child: CircularProgressIndicator(),);
        })
      // : const Center(
      // child: CircularProgressIndicator(
      //   color: AppTheme.primaryColor,
      // ));
      // }),
      // extendBody: true,
      // bottomNavigationBar: myCartController.isDataLoaded.value
      //     ? myCartController
      //     .model.value.data!.cartItems!.isNotEmpty
      //     ? addCartSection()
      //     : null
      //     : const SizedBox(),
    );
  }
}