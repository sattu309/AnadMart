import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../model/social_login_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<LoginModel> createLogin(
    {required String userEmail,
    required String userPassword,
      required String deviceToken,
      required String role,
    //required String fcmToken,
    required BuildContext context}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var map = <String, dynamic>{};
  map['email'] = userEmail;
  map['password'] = userPassword;
  map['role'] = role;
  map['device_token'] = deviceToken;
  map['device_id'] =pref.getString('deviceId');
  log(map.toString());


  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrl.loginApi),
      body: jsonEncode(map), headers: headers);
  log("response.body....      "+response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return LoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}


Future<SocialLoginModel> socialLogin(
    {required String provider,
      required String token,
      required String role,
      required BuildContext context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};
  map['provider'] = provider;
  map['token'] = token;
  map['role'] = "4";
  var fcmToken = await FirebaseMessaging
      .instance
      .getToken();
  map['device_token'] = fcmToken;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  //print('REQUEST ::${jsonEncode(map)}');
  // log(pref.getString('deviceId')!);
  http.Response response = await http.post(Uri.parse(ApiUrl.socialLoginUrl),
      body: jsonEncode(map), headers: headers);
  log(map.toString());
  log(response.statusCode.toString());
  log(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return SocialLoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
