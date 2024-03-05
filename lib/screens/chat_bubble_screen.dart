import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../resources/app_theme.dart';
import '../resources/helper.dart';
import 'loading_indicator.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    Key? key,
    required this.message,
    required this.message_type,
    required this.timeStamp,
    required this.myImage,
    required this.otherImage,
    required this.isCurrentUser,
  }) : super(key: key);
  final String message;
  final String message_type;
  final int timeStamp;
  final String myImage;
  final String otherImage;
  final bool isCurrentUser;

  // "age" (Done)
  // "gender" (Done)
  // "problem" (Done)
  // "country" (Done)
  // "dob" (Done)
  // "weight" (Done)

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool playing = false;
  static List imageTypes = [
    "jpeg",
    "jpg",
    "png",
    "gif",
    "bmp",
    "webp",
    "svg+xml",
    "tiff",
    "x-icon",
    "vnd.microsoft.icon",
    "vnd.adobe.photoshop",
    "xcf",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.transparent,
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: InteractiveViewer(
                      child: CachedNetworkImage(
                        imageUrl: widget.message,
                        fit: BoxFit.contain,
                        errorWidget: (_, __, ___) => const SizedBox(),
                        placeholder: (_, __) => const SizedBox(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextButton(
                            onPressed: () async {
                              showLoadingIndicatorDialog(context);
                              try {
                                var httpClient = HttpClient();
                                var request1 = await httpClient
                                    .getUrl(Uri.parse(widget.message));
                                var response = await request1.close();
                                var bytes =
                                await consolidateHttpClientResponseBytes(
                                    response);
                                String dir =
                                    (await getApplicationDocumentsDirectory())
                                        .path;
                                File file = File(
                                    '$dir/${widget.message.split("/").last.replaceAll("%", " ")}');
                                await file.writeAsBytes(bytes);
                                if (mounted) {
                                  Navigator.pop(context);
                                  OpenFilex.open(file.path);
                                }
                              } catch (e) {
                                Navigator.pop(context);
                              }
                              // _launchUrl(imageUrl);
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: const Text("Save")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: const Text(
                              "Close",
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(widget.isCurrentUser ? 64.0 : 16.0, 15, widget.isCurrentUser ? 16.0 : 64.0, 4,
        ),
        child: widget.isCurrentUser == true
            ? Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.message_type.toString() == "text"
                    ? Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: widget.isCurrentUser
                          ? AppTheme.primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          widget.message,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color: widget.isCurrentUser
                                  ? Colors.white
                                  : Colors.black87),
                        )),
                  ),
                )
                    : imageTypes.contains(
                    widget.message.toString().split(".").last)
                    ? GestureDetector(
                    onTap: () {
                      showDialogue();
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl: widget.message,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) =>
                          const SizedBox(),
                          placeholder: (_, __) =>
                          const SizedBox(),
                        ),
                      ),
                    ))
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          OverlayEntry loader =
                          Helpers.overlayLoader(context);
                          Overlay.of(context)!.insert(loader);
                          var httpClient = HttpClient();
                          var request1 =
                          await httpClient.getUrl(
                              Uri.parse(widget.message));
                          var response =
                          await request1.close();
                          var bytes =
                          await consolidateHttpClientResponseBytes(
                              response);
                          String dir =
                              (await getApplicationDocumentsDirectory())
                                  .path;
                          File file = File(
                              '$dir/${widget.message.split("/").last.replaceAll("%", " ")}');
                          await file.writeAsBytes(bytes);
                          Helpers.hideLoader(loader);
                          OpenFilex.open(file.path);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 7.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons
                                    .picture_as_pdf_outlined,
                                color:
                                AppTheme.primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.message
                                    .split("/")
                                    .last
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    color: AppTheme
                                        .primaryColor),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 0,
                      height: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.myImage,
                          errorWidget: (_, __, ___) => const SizedBox(),
                          placeholder: (_, __) => const SizedBox(),
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.only(top: 1),
                    //     child: Text(
                    //       DateFormat("hh:mm").format(
                    //           DateTime.fromMillisecondsSinceEpoch(
                    //               widget.timeStamp)),
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyText1!
                    //           .copyWith(
                    //               color: widget.isCurrentUser
                    //                   ? Colors.black
                    //                   : Colors.black87),
                    //     )),
                  ],
                ),
              ],
            ))
            : Align(
            alignment: Alignment.topRight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 0,
                      height: 25,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.myImage,
                          errorWidget: (_, __, ___) => const SizedBox(),
                          placeholder: (_, __) => const SizedBox(),
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //         padding: const EdgeInsets.all(1),
                    //         child: Text(
                    //           DateFormat("hh:mm").format(
                    //               DateTime.fromMillisecondsSinceEpoch(
                    //                   widget.timeStamp)),
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText1!
                    //               .copyWith(
                    //                   color: widget.isCurrentUser
                    //                       ? Colors.black
                    //                       : Colors.black87),
                    //         )),
                    //   ],
                    // ),
                  ],
                ),
                widget.message_type.toString() == "text"
                    ? Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: widget.isCurrentUser
                          ? AppTheme.primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.message,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                          color: widget.isCurrentUser
                              ? Colors.white
                              : Colors.black87),
                    ),
                  ),
                )
                    : imageTypes.contains(
                    widget.message.toString().split(".").last)
                    ? GestureDetector(
                    onTap: () {
                      showDialogue();
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl: widget.message,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) =>
                          const SizedBox(),
                          placeholder: (_, __) =>
                          const SizedBox(),
                        ),
                      ),
                    ))
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          OverlayEntry loader =
                          Helpers.overlayLoader(context);
                          Overlay.of(context)!.insert(loader);
                          var httpClient = HttpClient();
                          var request1 =
                          await httpClient.getUrl(
                              Uri.parse(widget.message));
                          var response =
                          await request1.close();
                          var bytes =
                          await consolidateHttpClientResponseBytes(
                              response);
                          String dir =
                              (await getApplicationDocumentsDirectory())
                                  .path;
                          File file = File(
                              '$dir/${widget.message.split("/").last.replaceAll("%", " ")}');
                          await file.writeAsBytes(bytes);
                          Helpers.hideLoader(loader);
                          OpenFilex.open(file.path);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 7.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons
                                    .picture_as_pdf_outlined,
                                color:
                                AppTheme.primaryColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.message
                                    .split("/")
                                    .last
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                    color: AppTheme
                                        .primaryColor),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            )));
  }
}
