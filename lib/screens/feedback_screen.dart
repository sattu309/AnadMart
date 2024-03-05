import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fresh2_arrive/repositories/common_repo/repository.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/feedback_list_model.dart';
import '../resources/api_url.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';


class FeedBackScreen extends StatefulWidget {
  final String productId;

  const FeedBackScreen({Key? key, required this.productId}) : super(key: key);
  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  double fullRating = 0;
  bool isExpanded = false;
  Repositories repositories= Repositories();
  FeedbackListModel? feedbackListModel;
  getFeedbackList(){
    repositories.getApi(url: "${ApiUrl.feedbackLIstUrl}/${widget.productId}").then((value){
      feedbackListModel = FeedbackListModel.fromJson(jsonDecode(value));
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    print(widget.productId);
    getFeedbackList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: backAppBar2(title: 'Feedback', context: context),
      body:feedbackListModel != null ?
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
        child:
        feedbackListModel!.data != null ?
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(feedbackListModel!.data!.avgRating.toString(),style: TextStyle(
                  color: Color(0xFF1B233A),
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                ),),
                addWidth(26),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: double.parse(feedbackListModel!.data!.avgRating.toString()),
                      minRating: 1,
                      unratedColor: const Color(0xFFECE3D0),
                      itemCount: 5,
                      itemSize: 16.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      updateOnDrag: true,
                      ignoreGestures: true,
                      itemBuilder: (context, index) =>
                          Image.asset('assets/images/star.png',
                            color: Colors.amber,
                          ),
                      onRatingUpdate: (ratingvalue) {
                        setState(() {
                          fullRating = ratingvalue;
                        });
                      },
                    ),
                    addHeight(3),
                     Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 4.0),
                      child:  Text(
                        "based on ${feedbackListModel!.data!.avgRatingCount.toString()} reviews",style: TextStyle(
                        color: Color(0xFF969AA3),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ],
                ),
              ],
            ),
            addHeight(20),
            const Divider(
              height: 1,
              thickness: 1.5,
              color: Color(0xFFE8F2EC),
            ),
            addHeight(20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: feedbackListModel!.data!.feedback!.length,
                itemBuilder: (context, index) {
                  final feedBackData= feedbackListModel!.data!.feedback![index];
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(4),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(),
                                color: Colors.white,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: feedBackData.image.toString(),
                                height: 65,
                                width: 65,
                                errorWidget: (_, __, ___) =>   Image.asset('assets/images/Ellipse 67.png',height: 50,),
                                placeholder: (_, __) => const SizedBox(),
                                fit: BoxFit.cover,
                              )),

                          addWidth(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(
                                    feedBackData.userName.toString(),
                                    style: GoogleFonts.quicksand(
                                      color: Color(0xff1B233A),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                ),
                                addHeight(10),
                                RatingBar.builder(
                                  initialRating: double.parse(feedBackData.rating.toString()),
                                  minRating: 1,
                                  unratedColor: const Color(0xFFECE3D0),
                                  itemCount: 5,
                                  itemSize: 16.0,
                                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  updateOnDrag: true,
                                  ignoreGestures: true,
                                  itemBuilder: (context, index) =>
                                      Image.asset('assets/images/star.png',
                                        color: Colors.amber,
                                      ),
                                  onRatingUpdate: (ratingvalue) {
                                    setState(() {
                                      fullRating = ratingvalue;
                                    });
                                  },
                                ),
                                addHeight(7),
                                Padding(
                                  padding: const  EdgeInsets.symmetric(horizontal: 5.0),
                                  child: RichText(
                                    text:  TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "${feedBackData.review.toString()}...",
                                              style: TextStyle(
                                                color: Color(0xFF969AA3),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,

                                              )),
                                          // if(!isExpanded)
                                          // TextSpan(
                                          //     text: 'read more',
                                          //     style: TextStyle(
                                          //         fontSize: 13,
                                          //         fontWeight: FontWeight.w400,
                                          //         color: Color(0xFF567DF4)),
                                          //   recognizer: TapGestureRecognizer()
                                          //     ..onTap = () {
                                          //       setState(() {
                                          //         isExpanded = true;
                                          //       });
                                          //     },
                                          // ),
                                          // if(isExpanded)
                                          //   TextSpan(
                                          //     text: 'read less',
                                          //     style: TextStyle(
                                          //         fontSize: 13,
                                          //         fontWeight: FontWeight.w400,
                                          //         color: Color(0xFF567DF4)),
                                          //     recognizer: TapGestureRecognizer()
                                          //       ..onTap = () {
                                          //         setState(() {
                                          //           isExpanded = false;
                                          //         });
                                          //       },
                                          //   )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const Spacer(),
                           Padding(
                            padding:  EdgeInsets.symmetric(vertical: 3.0),
                            child:  Text(
                              feedBackData.createdAt.toString(),style: TextStyle(
                              color: Color(0xFF969AA3),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                      index != 2
                          ? const Divider()
                          : const SizedBox(),
                      SizedBox(
                        height: AddSize.size5,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ):Center(child:     Text("No feedback yet",style: TextStyle(
          color: Color(0xFF1B233A),
          fontSize: 48,
          fontWeight: FontWeight.w600,
        ),),),
      ): Center(child: CircularProgressIndicator(color: Colors.green,),),
    );
  }
}
