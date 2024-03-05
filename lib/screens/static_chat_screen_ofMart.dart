// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../controller/privacy_policy_controller.dart';
//
// class StaticChatScreenMart extends StatefulWidget {
//   const StaticChatScreenMart({Key? key}) : super(key: key);
//   static var staticChatScreenMart = "/staticChatScreenMart";
//
//   @override
//   State<StaticChatScreenMart> createState() => _StaticChatScreenMartState();
// }
//
// class _StaticChatScreenMartState extends State<StaticChatScreenMart> {
//   final privacyController = Get.put(PrivacyController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.grey.shade50,
//         elevation: 0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//                 onTap: (){
//                   Get.back();
//                 },
//                 child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
//             Container(
//               // padding: EdgeInsets.all(8),
//               // margin: EdgeInsets.all(5),
//               height: 35,
//               width: 35,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white,
//               ),
//               child: Icon(Icons.favorite_border,size: 17,color: Colors.black,),
//             ),
//
//             Icon(Icons.more_vert)
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }



import 'package:flutter/material.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../resources/app_theme.dart';

class StaticChatScreenMart extends StatefulWidget {
  const StaticChatScreenMart({super.key});
  static var staticChatScreenMart = "/staticChatScreenMart";

  @override
  State<StaticChatScreenMart> createState() => _StaticChatScreenMartState();
}

class _StaticChatScreenMartState extends State<StaticChatScreenMart> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return  Scaffold(
      // backgroundColor: ,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
            Text(
              "Williams Jones" ,style:  GoogleFonts.poppins(
                fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xff303D48)),
            ),
            Icon(Icons.more_vert,color: Colors.black,)
          ],
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addHeight(15),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
              decoration: BoxDecoration(
                color:const Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Today" ,style:  GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xff717171)),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    addHeight(15),
                    Align(alignment: Alignment.topLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text("6:13 PM"),
                              Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color:Color(0xffE6E6E6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:  Text(
                                      'Hello, Good morning.',
                                      style: GoogleFonts.quicksand(
                                          color: Color(0xFF5A5A5A),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500))),])),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("6:13 PM"),
                          Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color:const Color(0xffE6E6E6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Text(
                                  'Can you tell me the problem\n you are having? so i can help\n sole it',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("6:13 PM"),
                          Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Text(
                                  'Hi, I’m having problems with\n my payment.',
                                  style: GoogleFonts.quicksand(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(alignment: Alignment.topRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("6:13 PM"),
                          Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Text(
                                  'Can you help me?.',
                                  style: GoogleFonts.quicksand(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("6:13 PM"),
                          Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color:const Color(0xffE6E6E6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child:  Text(
                                  'Yes Please Tell Me',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))),
                        ],
                      ),),

                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:  Colors.grey.shade200,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [

                  Image.asset('assets/images/smile.png',height: 40,),
                  const SizedBox(
                    width: 15,
                  ),
               Text(
                  'Type a message...',
                  style: GoogleFonts.poppins(
                      color: Color(0xFF9E9E9E),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                         // hintText: 'Write a message',

                          suffixIcon:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset('assets/images/attach.png'),
                              addWidth(15),
                              Image.asset('assets/images/send.png'),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],),
    );
  }
}