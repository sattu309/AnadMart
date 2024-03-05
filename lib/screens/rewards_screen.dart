import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';


class RewardsScreen extends StatefulWidget {

  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {

  final TextEditingController tipController=TextEditingController();
  @override

  bool statusChanged = true;

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
        appBar: backAppBar2(title: "Rewards", context: context),
        body: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 8,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisExtent: 180,
                      mainAxisSpacing: 8.0),
                  itemBuilder: (context, i) {
                    // var itemdata = categoryController.model.value.data![i];
                    return Container(
                          width: width,
                        decoration: BoxDecoration(
                            color: Color(0xffF6F6F6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            addHeight(10),
                            SizedBox(
                              height: AddSize.size50 * 1.5,
                              width: AddSize.size50 * 1.5,
                              child:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                   imageUrl: "https://img.freepik.com/free-photo/cute-woman-bright-hat-purple-blouse-is-leaning-stand-with-dresses-posing-with-package-isolated-background_197531-17610.jpg",
                                  // imageUrl: itemdata.image.toString(),
                                  errorWidget: (_, __, ___) => const SizedBox(),
                                  placeholder: (_, __) => const SizedBox(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            addHeight(6),
                            Text(
                              "2km Free",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff010101),
                                  fontSize: AddSize.font14,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "For 1000 Points",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xffA99F9F),
                                  fontSize: AddSize.font12,
                                  fontWeight: FontWeight.w500),
                            ),
                            addHeight(6),
                            GestureDetector(
                              onTap: (){
                                showDialog(context: context, builder:(BuildContext context){
                                  return Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: AddSize.size20),
                                        Image.asset(
                                          "assets/images/reward.png",
                                          height: 120,
                                        ),
                                        addHeight(8),
                                        Text(
                                          "Comparte can 10 amigos Y recibe bonificacion",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                              color: Color(0xff3C4242),
                                              fontSize: AddSize.font16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        addHeight(8),
                                        Padding(
                                          padding: const EdgeInsets.all(30.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: DottedBorder(
                                              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                                              strokeWidth: 2,
                                              // strokeCap: StrokeCap.butt,
                                              dashPattern: [10,10],
                                              color: Colors.green,
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "FTE563TRE",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.quicksand(
                                                          color: Color(0xff000000),
                                                          fontSize: AddSize.font14,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    addWidth(6),
                                                    VerticalDivider(
                                                      color: Colors.green,
                                                      thickness: 2,
                                                    ),
                                                    addWidth(6),
                                                    Icon(Icons.copy),
                                                    addWidth(4),
                                                    Text(
                                                      "Code Copy",
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.quicksand(
                                                          color: Color(0xff000000),
                                                          fontSize: AddSize.font14,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: AddSize.size5),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                                          child: SizedBox(
                                            height: 52,
                                            width: double.maxFinite,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                  backgroundColor: Colors.green),
                                              onPressed: (){},
                                                child:    Text(
                                                  "DONE",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontSize: AddSize.font16,
                                                      fontWeight: FontWeight.w600),
                                                ),),
                                          ),
                                        ),
                                        SizedBox(height: AddSize.size10),

                                      ],
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(
                                  "Redeem Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AddSize.font12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                    addHeight(10)
                          ],
                        ));
                  }),
            ],
          ),
        )

    );

  }

}
