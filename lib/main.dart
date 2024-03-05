import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh2_arrive/resources/app_theme.dart';
import 'package:fresh2_arrive/routers/my_router.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: ThemeData.light(),
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      initialRoute: "/splashScreen",
      getPages: MyRouter.route,
      theme: ThemeData(
          useMaterial3: false,
          fontFamily: 'Poppins',
          bottomAppBarTheme:
              const BottomAppBarTheme(color: Colors.transparent, elevation: 0),
          primaryColor: AppTheme.primaryColor,
          scaffoldBackgroundColor: const Color(0xffF6F6F6),
          // highlightColor: AppTheme.primaryColor,
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor: MaterialStateProperty.all(AppTheme.primaryColor),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: AppTheme.primaryColor)),
      themeMode: ThemeMode.light,
    );
  }
}
