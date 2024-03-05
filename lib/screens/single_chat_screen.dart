import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';
import '../model/chat_message_model.dart';
import '../repositories/chat_image_repo.dart';
import '../resources/api_url.dart';
import '../resources/app_theme.dart';
import '../resources/helper.dart';
import '../widgets/add_text.dart';
import 'chat_bubble_screen.dart';


class ChatDetailScreen extends StatefulWidget {
  final String chatRoom;
  final String otherId;
  final String myId;
  final String orderId;
  final String otherProfileImage;
  final String otherName;
  const ChatDetailScreen({
    super.key,
    required this.chatRoom,
    required this.otherId,
    required this.otherProfileImage,
    required this.otherName,
    required this.myId,
    required this.orderId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final TextEditingController textEditingController = TextEditingController();
  final profileController = Get.put(ProfileController());
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool playing = false;

  String pathToAudio = "";
  bool isRecorderReady = false;
  String myUserId = "";
  File? selectedImage;
  String? base64Image;
  String? profileImage;

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 30);
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        image = File(result.files.single.path.toString());
      }
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        //profileImage = base64Decode(base64Image.toString()) as String?;
        // sendImage(context,base64Image!);
        OverlayEntry loader = Helpers.overlayLoader(context);
        Overlay.of(context)?.insert(loader);
        sendImage(
          fieldName1: "image",
          file1: selectedImage!,
        ).then((value) {
          log("00000000000000${selectedImage}");
          if (value.status == true) {
            log("55555555555${value.data!.image.toString()}");
            sendMessageImage(url: value.data!.image);
            Helpers.hideLoader(loader);
          } else {
            log("55555555555${value.data!.image.toString()}");
            Helpers.hideLoader(loader);
            showToast(value.status);
          }
        });
        print("object$base64Image");
      });
    }
  }

  sendNewMessage() async {
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    myUserId = (await getUserId()).toString();
    print("dfjkdhf");
    Map<String, dynamic> updates = {};
    Map<String, dynamic> newMessageMap = {};
    newMessageMap["message"] = textEditingController.text.trim();
    newMessageMap["message_type"] = "text";
    newMessageMap["timeStamp"] = currentTimeStamp;
    newMessageMap["sender_id"] = myUserId;
    // newMessageMap["receiver_id"] = widget.instructorId.toString();

    Map<String, dynamic> recentMessage = {};
    recentMessage["last_message"] = textEditingController.text.trim();
    recentMessage["name"] = widget.otherName;
    recentMessage["message_type"] = "text";
    recentMessage["timeStamp"] = currentTimeStamp;
    recentMessage["sender_id"] = myUserId;
    recentMessage["other_id"] = widget.otherId.toString();
    recentMessage["my_last_seen"] = currentTimeStamp;

    Map<String, dynamic> recentMessageOther = {};
    recentMessageOther["last_message"] = textEditingController.text.trim();
    recentMessageOther["name"] = profileController.model.value.data!.userData!.firstName ?? "";
    recentMessageOther["message_type"] = "text";
    recentMessageOther["timeStamp"] = currentTimeStamp;
    recentMessageOther["sender_id"] = myUserId;
    recentMessageOther["other_id"] = myUserId;
    recentMessageOther["my_last_seen"] = currentTimeStamp;
    updateRecentMessagesMy(recentMessage);
    updateRecentMessagesOther(recentMessageOther);

    updates["chat_rooms/${widget.chatRoom}/$currentTimeStamp"] = newMessageMap;
    firebaseDatabase.ref().update(updates).then((value) {
      log("Firebase message updated...........");
      textEditingController.clear();
    });
  }

  sendMessageImage({required url}) async {
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    myUserId = (await getUserId()).toString();
    Map<String, dynamic> updates = {};
    Map<String, dynamic> newMessageMap = {};
    newMessageMap["message"] = url;
    newMessageMap["message_type"] = "doc";
    newMessageMap["timeStamp"] = currentTimeStamp;
    newMessageMap["sender_id"] = myUserId;
    // newMessageMap["receiver_id"] = widget.instructorId.toString();

    Map<String, dynamic> recentMessage = {};
    recentMessage["last_message"] = url;
    recentMessage["name"] = widget.otherName;
    recentMessage["message_type"] = "doc";
    recentMessage["timeStamp"] = currentTimeStamp;
    recentMessage["sender_id"] = myUserId;
    recentMessage["other_id"] = widget.otherId.toString();
    recentMessage["my_last_seen"] = currentTimeStamp;

    Map<String, dynamic> recentMessageOther = {};
    recentMessageOther["last_message"] = url;
    recentMessageOther["name"] = profileController.model.value.data!.userData!.firstName ?? "";
    recentMessageOther["message_type"] = "doc";
    recentMessageOther["timeStamp"] = currentTimeStamp;
    recentMessageOther["sender_id"] = myUserId;
    recentMessageOther["other_id"] = myUserId;
    recentMessageOther["my_last_seen"] = currentTimeStamp;
    // updateRecentMessagesMy(recentMessage);
    //updateRecentMessagesOther(recentMessageOther);

    updates["chat_rooms/${widget.chatRoom}/$currentTimeStamp"] = newMessageMap;
    firebaseDatabase.ref().update(updates).then((value) {
      log("Firebase message updated...........");
      textEditingController.clear();
    });
  }

  updateRecentMessagesMy(Map<String, dynamic> recentMessage) async {
    String myUserId = (await getUserId()).toString();
    Map<String, dynamic> updates = {};
    // recentMessage["my_last_seen"] = ;
    if (recentMessage.isNotEmpty) {
      updates["chat_list/$myUserId/${widget.chatRoom}"] = recentMessage;
      firebaseDatabase.ref().update(updates).then((value) {
        log("Firebase recent message updated...........");
        textEditingController.clear();
      });
    } else {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref("chat_list/$myUserId/${widget.chatRoom}");
      await ref.update({
        "my_last_seen": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  updateRecentMessagesOther(Map<String, dynamic> recentMessage) async {
    Map<String, dynamic> updates = {};
    // recentMessage["my_last_seen"] = ;
    if (recentMessage.isNotEmpty) {
      updates["chat_list/${widget.otherId}/${widget.chatRoom}"] = recentMessage;
      firebaseDatabase.ref().update(updates).then((value) {
        log("Firebase recent message updated...........");
        textEditingController.clear();
      });
    } else {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref("chat_list/${widget.otherId}/${widget.chatRoom}");
      await ref.update({
        "my_last_seen": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateRecentMessagesMy({});
    updateRecentMessagesOther({});
    getMyUserId();
    print(widget.chatRoom);
  }

  getMyUserId() async {
    myUserId = (await getUserId()).toString();
    setState(() {});
  }

  @override
  void dispose() {
    updateRecentMessagesMy({});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: backAppBar(title: widget.otherName.toString(), context: context),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: firebaseDatabase
                    .ref("chat_rooms/${widget.chatRoom}")
                    .onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasData) {
                    List<ChatMessage> message = [];
                    print(snapshot
                          .data!.snapshot.children.map((e) => e.value.toString()));
                    message = chatModelListFromJson(snapshot
                        .data!.snapshot.children
                        .map((e) => jsonEncode(e.value))
                        .toList()
                        .toString())
                        .reversed
                        .toList();
                    return ListView.builder(
                      reverse: true,

                      itemCount: message.length,
                      itemBuilder: (context, index) {
                        final item = message[index];
                        return ChatBubble(
                            message: item.message!.toString(),
                            message_type: item.message_type!,
                            myImage: "",
                            // item.sender_id.toString() == myUserId
                            //     ? profileController
                            //     .model.value.data!.profileImage!
                            //     : widget.otherProfileImage,
                            otherImage: "",
                            timeStamp: item.timeStamp!,
                            //imageOther:"data:image/jpg;base64,${base64Image}",
                            isCurrentUser:
                            item.sender_id.toString() == myUserId);
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin:
            const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 12),
            decoration: BoxDecoration(
                color: const Color(0xffEEEFFC),
                borderRadius: BorderRadius.circular(50)),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: deviceHeight * 0.02,
                              ),
                              const Text('Tap below Option to Pic image'),
                              SizedBox(
                                height: deviceHeight * 0.02,
                              ),
                              TextButton(
                                  onPressed: () {
                                    chooseImage('camera');
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Camera')),
                              TextButton(
                                  onPressed: () {
                                    chooseImage('Gallery');
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Gallery')),
                              SizedBox(
                                height: deviceHeight * 0.05,
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.attach_file_outlined)),
                // buildStart(),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    controller: textEditingController,
                    obscureText: false,
                    autofocus: false,
                    minLines: 1,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: 'Write a message...',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                    onTap: () {
                      if (textEditingController.text.trim().isNotEmpty) {
                        sendNewMessage();
                      }
                    },
                    child: const Icon(
                      Icons.telegram_sharp,
                      color: Colors.deepPurpleAccent,
                      size: 45,
                    )),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
