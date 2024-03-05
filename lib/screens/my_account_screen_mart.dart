import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/all_chatlist_model.dart';
import '../repositories/common_repo/repository.dart';
import '../repositories/privacy_policy_repo.dart';
import '../resources/api_url.dart';
import '../widgets/add_text.dart';

class MyAccountScreen extends StatefulWidget {
  final String reasonId;
  final String reasonName;
  const MyAccountScreen({Key? key, required this.reasonId, required this.reasonName}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final TextEditingController msgController = TextEditingController();
  @override
  final formKey = GlobalKey<FormState>();
  Repositories repositories = Repositories();
  AllChatLIstModel? allChatLIstModel;

  getUserChat() {
      Timer.periodic(Duration(microseconds: 1000), (timer) {
        repositories.getApi(url: "${ApiUrl.allChatListUrl}?service_ticket_id=${widget.reasonId}").then((value) {
          allChatLIstModel = AllChatLIstModel.fromJson(jsonDecode(value));
          setState(() {});
        });
      });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserChat();
    });
  }

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: backAppBar2(title: widget.reasonName, context: context),
      body: Column(
            children: [
              if(allChatLIstModel != null)
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 17, right: 12),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "You",
                            //   style:
                            //       GoogleFonts.quicksand(fontSize: 17,
                            //       fontWeight: FontWeight.w600,
                            //       color: Color(0xff000000))
                            //
                            // ),
                            // addHeight(6),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 70),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 18),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.only(
                            //         topRight: Radius.circular(10),
                            //         topLeft: Radius.circular(10),
                            //         bottomRight: Radius.circular(10),
                            //       ),
                            //       color: Colors.grey.withOpacity(.10)
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(6.0),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(
                            //               "Hello, Good morning.",
                            //               style:
                            //               GoogleFonts.quicksand(fontSize: 16,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Color(0xff717171))
                            //
                            //           ),
                            //           Text(
                            //               "09:41",
                            //               style:
                            //               GoogleFonts.quicksand(fontSize: 12,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Color(0xff717171))
                            //
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // addHeight(10),
                            // Text(
                            //     "You",
                            //     style:
                            //     GoogleFonts.quicksand(fontSize: 17,
                            //         fontWeight: FontWeight.w600,
                            //         color: Color(0xff000000))
                            //
                            // ),
                            // addHeight(6),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 70),
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 10,vertical: 18),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.only(
                            //           topRight: Radius.circular(10),
                            //           topLeft: Radius.circular(10),
                            //           bottomRight: Radius.circular(10),
                            //         ),
                            //         color: Colors.grey.withOpacity(.10)
                            //     ),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(6.0),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Text(
                            //               "I Need Your Help.",
                            //               style:
                            //               GoogleFonts.quicksand(fontSize: 16,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Color(0xff717171))
                            //
                            //           ),
                            //           Text(
                            //               "09:41",
                            //               style:
                            //               GoogleFonts.quicksand(fontSize: 12,
                            //                   fontWeight: FontWeight.w500,
                            //                   color: Color(0xff717171))
                            //
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // addHeight(10),

                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: allChatLIstModel!.data!.length,
                                itemBuilder: (BuildContext context, index) {
                                  final msgData = allChatLIstModel!.data![index];

                                  return Column(
                                    crossAxisAlignment: msgData.userId != "" ? CrossAxisAlignment.start: CrossAxisAlignment.end,
                                    children: [
                                      msgData.userId == ""
                                          ? Padding(
                                            padding: const EdgeInsets.only(right: 5),
                                            child: Text("Admin",
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xff000000))),
                                          )
                                          : Text("You",
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xff000000))),
                                      addHeight(6),
                                      Column(
                                        crossAxisAlignment: msgData.userId != "" ? CrossAxisAlignment.start: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: msgData.userId != "" ? EdgeInsets.only(right: 70) : EdgeInsets.only(left: 70),
                                            child: Container(


                                              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                                              decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(10),
                                                    topLeft: Radius.circular(10),
                                                    bottomRight: Radius.circular(10),
                                                  ),
                                                  color: Colors.grey.withOpacity(.10)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(msgData.message.toString(),
                                                          style: GoogleFonts.quicksand(
                                                              fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff717171))),
                                                    ),
                                                    Text(msgData.time.toString(),
                                                        style: GoogleFonts.quicksand(
                                                            fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff717171))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                            // SizedBox(height: height *.35,),
                          ],
                        ),
                      ),
                    ),
                  ),
              )
              else
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/images/link-2.png"),
                                addWidth(5),
                                Image.asset("assets/images/gallery.png"),
                                addWidth(5),
                                Expanded(
                                    child: TextFormField(
                                      controller: msgController,
                                      decoration: InputDecoration(border: InputBorder.none, hintText: "Write a message..."),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        addWidth(20),
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              saveChatRepo(
                                reasonId: widget.reasonId,
                                message: msgController.text,
                                context: context,
                              ).then((value) {
                                if (value.status == true) {
                                  showToast(value.message);
                                  getUserChat();
                                  msgController.clear();
                                  // Get.back();
                                } else {
                                  showToast(value.message);
                                }
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                            child: Text("Send",
                                style: GoogleFonts.quicksand(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.green)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
      // bottomNavigationBar: ,
    );
  }
}
