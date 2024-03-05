import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/sub_category_ofCategory.dart';
import 'package:fresh2_arrive/screens/products_screen.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:get/get.dart';
import '../controller/My_cart_controller.dart';
import '../controller/category_controller.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final categoryController = Get.put(CategoryController());

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      categoryController.getData(isFirstTime: true, context: context)
          .then((value) => setState(() {}));
    }
  }


  final myCartController = Get.put(MyCartDataListController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        appBar: backAppBar2(title: "Category", context: context),
        backgroundColor: Colors.grey.shade100,
        body:
        Obx(() {
          return
          categoryController.isDataLoading.value ?
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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: AddSize.size20,),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: categoryController.model.value.data!.length,
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 16.0,
                              mainAxisExtent: 140,
                              mainAxisSpacing: 5.0),
                          itemBuilder: (context, i) {
                            var itemdata = categoryController.model.value.data![i];
                            return GestureDetector(
                              onTap: () {
                                if(itemdata.subCategory!.isNotEmpty){
                                  categoryController.subCategoryId.value = itemdata.id.toString();
                                  print("subCategory id is" +categoryController.subCategoryId.value);
                                  Get.toNamed(SubCategoryOfCategory.subCategoryOfCategory);
                                }
                              else{
                                  Get.to(()=>ProductScreenOfMart(categoryId: categoryController.model.value.data![i].id.toString()));
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
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
                                          ),
                                        ],
                                      )),
                                  addHeight(6),
                                  Expanded(
                                    child: Text(
                                      // "Watch",
                                      itemdata.name.toString().capitalizeFirst!,
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
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
    );
  }
}