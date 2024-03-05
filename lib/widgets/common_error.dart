import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';



class CommonErrorWidget extends StatelessWidget {
  final String errorText;
  final VoidCallback onTap;
  const CommonErrorWidget({Key? key, required this.errorText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorText,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),

          )

          // CustomOutlineButton(
          //   title: "Refresh",
          //   backgroundColor: Colors.white,
          //   onPressed: onTap,
          //   textColor: AppTheme.primaryColor,
          // )
        ],
      ),
    );
  }
}
