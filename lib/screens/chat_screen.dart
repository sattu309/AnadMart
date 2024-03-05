import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/screens/single_chat_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/add_text.dart';
import '../controller/profile_controller.dart';
import '../model/chat_user_model.dart';
import '../model/user_profile_model.dart';
import '../repositories/get_user_details.dart';
import '../resources/api_url.dart';
import '../resources/app_theme.dart';
import '../widgets/dimensions.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final profileController = Get.put(ProfileController());
  String myUserId = "";
  bool loaded = false;

  getMyUserId() async {
    myUserId = await getUserId();
    loaded = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMyUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AddSize.size100 * .82),
        child: backAppBar(
          title: 'Messages',
          context: context
        ),
      ),
      body: loaded
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: AddSize.padding14),
        decoration: BoxDecoration(boxShadow: blurBoxShadow),
        child: StreamBuilder(
            stream: profileController.firebaseDatabase
                .ref("chat_list/$myUserId")
                .onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (snapshot.hasData) {
                print("Stream Response... ...                 ${jsonEncode(snapshot.data!.snapshot.children.first.value)}");
                // // print("Stream Response... ...                 ${profileController.userId}");
                // // Map map = snapshot.data!.snapshot.children.map((e) => e.value).toSet() as Map;
                // List<ChatUsers> user = chatUsersListFromJson(snapshot
                //     .data!.snapshot.children
                //     .map((e) => jsonEncode(e.value))
                //     .toList()
                //     .toString());
                // if (kDebugMode) {
                //   print("Stream Response... ...                 $user");
                // }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                  EdgeInsets.symmetric(vertical: AddSize.padding20),
                  shrinkWrap: true,
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    // return messages(user[index]);
                    return SizedBox();
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }),
      )
          : const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  messages(ChatUsers item) {
    Data model = Data();
    return GestureDetector(
      onTap: () async {
        String chatNode = "";
        int otherID = int.parse(item.other_id!);
        int chatMyUserID = int.parse(myUserId);

        if (chatMyUserID > otherID) {
          chatNode = myUserId.toString() + otherID.toString();
        } else {
          chatNode = otherID.toString() + myUserId.toString();
        }
        Get.to(() => ChatDetailScreen(
          chatRoom: chatNode,
          otherId: otherID.toString(),
          otherProfileImage: model.userData!.profileImage ?? "",
          otherName: item.name!, myId: '', orderId: '',
        ));
      },
      child: Container(
        decoration:
        BoxDecoration(boxShadow: blurBoxShadow, color: Colors.white),
        margin: EdgeInsets.only(bottom: AddSize.padding18),
        padding: EdgeInsets.all(AddSize.padding16),
        child: Row(
          children: [
            //
            Container(
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              height: AddSize.size30 * 2,
              width: AddSize.size30 * 2,
              child: FutureBuilder<Data>(
                  future: FirebaseService()
                      .getUserDetails(userId: item.other_id)
                      .then((value) {
                    model = value;
                    return value;
                  }),
                  builder: (context, snapshot) {
                    // log(snapshot.toString());
                    if (snapshot.hasData) {
                      log(jsonEncode(snapshot.data));
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          width: AddSize.size50,
                          height: AddSize.size50,
                          fit: BoxFit.cover,
                          imageUrl: snapshot.data!.userData!.profileImage ?? "",
                        ),

                        // Image.network(snapshot.data!.profileImage ?? "",
                        //   errorBuilder: (_, __, ___) => const SizedBox(),),
                      );
                    }
                    if (snapshot.data == null) {
                      return const Center(child: Icon(Icons.person));
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
            ),
            SizedBox(
              width: AddSize.size14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddText(
                        text: item.name,
                        color: AppTheme.userText,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font18,
                      ),
                      AddText(
                        text: DateFormat("hh:mm a").format(
                            DateTime.fromMillisecondsSinceEpoch(
                                item.timeStamp!)),
                        color: AppTheme.userText.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AddSize.size10,
                  ),
                  AddText(
                    text: item.lastMessage.toString(),
                    maxLines: 1,
                    color: AppTheme.userText.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: AddSize.font16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
