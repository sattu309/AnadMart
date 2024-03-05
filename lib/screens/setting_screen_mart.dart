

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import '../resources/app_theme.dart';
import '../widgets/add_text.dart';
import '../widgets/dimensions.dart';


class SettingScreenMart extends StatefulWidget {
  static var settingScreenOfMart = "/settingScreenOfMart";
  const SettingScreenMart({Key? key}) : super(key: key);

  @override
  State<SettingScreenMart> createState() => _SettingScreenMartState();
}

class _SettingScreenMartState extends State<SettingScreenMart> {

  final TextEditingController tipController=TextEditingController();
  @override

  bool statusChanged = true;

  @override
  Widget build(BuildContext context) {
    var height= MediaQuery.of(context).size.height;
    var width= MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: backAppBar2(title: "Settings", context: context),
        body: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              Card(
                  color: Color(0xffFFFFFF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .03,
                      vertical: height * .02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Push Notifications",
                          // homeController1.model.value
                          //     .data!.recommendedStore![index].name
                          //     .toString(),
                          style: GoogleFonts.quicksand(fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1A2E33)),),

                        FlutterSwitch(
                          width: AddSize.size30 * 2.2,
                          height: AddSize.size20 * 1.4,
                          valueFontSize: AddSize.font12,
                          activeTextFontWeight: FontWeight.w600,
                          inactiveText: "",
                          activeText: "",
                          inactiveTextColor: AppTheme.backgroundcolor,
                          activeTextColor: AppTheme.backgroundcolor,
                          inactiveTextFontWeight: FontWeight.w600,
                          inactiveColor: Colors.grey.shade400,
                          activeColor: AppTheme.primaryColor,
                          value: statusChanged,
                          borderRadius: 30.0,
                          showOnOff: false,
                          onToggle: (val) {
                            statusChanged=val;
                            setState(() {

                            });
                          },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )

    );

  }

}
