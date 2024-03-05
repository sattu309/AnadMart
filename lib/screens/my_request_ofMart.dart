import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/repositories/common_repo/repository.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/my_request_model.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';
import 'add_new_request.dart';
import 'my_account_screen_mart.dart';

class MyRequestScreen extends StatefulWidget {
  static var myRequestScreenOfMart = "/myRequestScreenOfMart";
  const MyRequestScreen({Key? key}) : super(key: key);

  @override
  State<MyRequestScreen> createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  final TextEditingController tipController = TextEditingController();
  Repositories repositories = Repositories();
  MyRequestModel? myRequestModel;

  getMyRequestData(){
    repositories.getApi(url: "${ApiUrl.myRequestUrl}").then((value){
      myRequestModel= MyRequestModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    getMyRequestData();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Image.asset(
                "assets/images/backArrow.png",
                height: AddSize.size20,
              ),
            ),
          ),
          elevation: 0,
          title: Text(
            "My Requests",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>NewRequestScreen(update: () { getMyRequestData(); },));
                },
                child: Container(
                  // height: 15,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                      color: Colors.green, border: Border.all(color: const Color(0xFFEEEEEE))),
                  child:
                  Center(child: Text("Add New", style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),))
                ),
              ),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            child:
            myRequestModel != null ? myRequestModel!.data!.supportTicketData!.isNotEmpty ?
            Column(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: myRequestModel!.data!.supportTicketData!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, index){
                          final myRequestData= myRequestModel!.data!.supportTicketData![index];
                          return
                            Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Get.to(()=>MyAccountScreen(
                                  reasonId: myRequestData.id.toString(),
                                  reasonName: myRequestData.contactReason.toString(),

                                ));
                              },
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          myRequestData.contactReason.toString(),
                                          style: GoogleFonts.quicksand(fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff000000)),),
                                        Text(
                                          "#${myRequestData.id.toString()}",
                                          style: GoogleFonts.quicksand(fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff4DBA4D)),),
                                        Text(
                                          myRequestData.createdAt.toString(),
                                          style: GoogleFonts.quicksand(fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff000000)),),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: myRequestData.status == "Panding" ?  Color(0xffFFAB07):Color(0xff4DBA4D),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                                            child: Text(
                                              myRequestData.status.toString(),
                                              style: GoogleFonts.quicksand(fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,),
                                            ),
                                          ),
                                        )],
                                    ),
                                  ),
                                  Divider(),
                                  addHeight(5),

                                ],
                              ),
                            ),
                                                      );
                        }),
                  ),
                )

              ],
            ): Center(child: Text("No request yet", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),)): Center(child: CircularProgressIndicator(color: Colors.green,))
        ));
  }
}
