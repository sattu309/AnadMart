import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/screens/single_chat_screen.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:fresh2_arrive/widgets/dimensions.dart';
import 'package:fresh2_arrive/widgets/registration_form_textField.dart';
import 'package:get/get.dart';

import '../resources/api_url.dart';

class CompliantOrder extends StatefulWidget {
final dynamic otherId;
final dynamic myId;
final dynamic orderId;
final dynamic otherProfileImage;
final dynamic otherName;
final dynamic chatRoom;
   const CompliantOrder(
      {Key? key,
      required this.otherId,
      required this.myId,
      required this.orderId,
      required this.otherProfileImage,
      required this.otherName,
        required this.chatRoom
      })
      : super(key: key);
  static var compliantOrder = "/compliantOrder";
  @override
  State<CompliantOrder> createState() => _CompliantOrderState();
}

class _CompliantOrderState extends State<CompliantOrder> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  sendNewMessage() async {
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    // widget.myId = (await getUserId()).toString();
    Map<String, dynamic> updates = {};
    Map<String, dynamic> newMessageMap = {};
    newMessageMap["message"] = message.text.trim();
    newMessageMap["message_type"] = "text";
    newMessageMap["timeStamp"] = currentTimeStamp;
    newMessageMap["sender_id"] = (await getUserId()).toString();
    // newMessageMap["receiver_id"] = widget.instructorId.toString();
    print(newMessageMap);

    Map<String, dynamic> recentMessageOther = {};
    recentMessageOther["last_message"] = message.text.trim();
    recentMessageOther["name"] =  "";
    recentMessageOther["message_type"] = "text";
    recentMessageOther["timeStamp"] = currentTimeStamp;
    recentMessageOther["sender_id"] = widget.myId;
    recentMessageOther["other_id"] =widget.otherId;
    recentMessageOther["my_last_seen"] = currentTimeStamp;
    updateRecentMessagesOther(recentMessageOther);

    updates["chat_rooms/${widget.chatRoom}/$currentTimeStamp"] = newMessageMap;
    firebaseDatabase.ref().update(updates).then((value) {
      log("Firebase message updated...........");
      message.clear();
    });
  }

  updateRecentMessagesOther(Map<String, dynamic> recentMessage) async {
    Map<String, dynamic> updates = {};
    // recentMessage["my_last_seen"] = ;
    if (recentMessage.isNotEmpty) {
      updates["chat_list/${widget.otherId}/${widget.chatRoom}"] = recentMessage;
      firebaseDatabase.ref().update(updates).then((value) {
        log("Firebase recent message updated...........");
        message.clear();
      });
    } else {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref("chat_list/${widget.otherId}/${widget.chatRoom}");
      await ref.update({
        "my_last_seen": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }


  final message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: backAppBar(title: "Compliant Order", context: context),
        body: Padding(
          padding: EdgeInsets.all(AddSize.padding16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "please Enter your compliant",
              style: TextStyle(
                  fontSize: AddSize.font14, color: AppTheme.blackcolor),
            ),
            SizedBox(height: AddSize.size10),
            MessageField(
              controller: message,
              minLines: null,
              maxLines: null,
              hint: "Enter message",
            ),
            SizedBox(height: AddSize.size20),
            ElevatedButton(
                onPressed: () async {
                  // Get.toNamed(CompliantOrder.compliantOrder);
                  sendNewMessage();
                  // String chatNode = "";
                  int instructorId = int.parse(widget.otherId.toString());
                  int myUserId = int.parse(await getUserId());
                  int orderId = int.parse(widget.orderId.toString());
                  // if (myUserId > instructorId) {
                  //   chatNode = myUserId.toString() + instructorId.toString();
                  // } else {
                  //   chatNode = instructorId.toString() + myUserId.toString();
                  // }
                  Get.off(() => ChatDetailScreen(
                        chatRoom: widget.chatRoom,
                        otherId: instructorId.toString(),
                        myId: myUserId.toString(),
                        orderId: orderId.toString(),
                        otherProfileImage: "",
                        otherName: "",
                      ));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 60),
                    backgroundColor: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AddSize.size10)),
                    textStyle: TextStyle(
                        fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                child: Text(
                  "SEND",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: AppTheme.backgroundcolor,
                      fontWeight: FontWeight.w500,
                      fontSize: AddSize.font18),
                )),
          ]),
        ));
  }
}
