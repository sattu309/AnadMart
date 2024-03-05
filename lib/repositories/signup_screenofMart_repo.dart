import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/resources/helper.dart';
import 'package:http/http.dart' as http;

import '../model/model_common_ressponse.dart';
import '../resources/api_url.dart';


Future<ModelCommonResponse> register(
    fName,
    mName,
    lName,
    email,
    mobileNumber,
    password,
    confirmPassword,
    type,
    BuildContext context) async {
  var map = <String, dynamic>{};
  map['first_name'] = fName;
  map['middle_name'] = mName;
  map['last_name'] = lName;
  map['email'] = email;
  map['phone'] = mobileNumber;
  map['password'] = password;
  map['confirm_password'] = confirmPassword;
  map['type'] = type;

log(map.toString());

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrl.registrationApi),
      body: jsonEncode(map), headers: headers);
  log(map.toString());
  log(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.hideLoader(loader);
    // NewHelper.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}
//
// Future<ModelVerifyOtp> verifyOTPPassword(
//     userEmail, otp,roleText, BuildContext context) async {
//   var map = <String, dynamic>{};
//   map["phone"] = userEmail;
//   map["otp"] = otp;
//   map["role"] = roleText;
//   OverlayEntry loader = NewHelper.overlayLoader(context);
//   Overlay.of(context).insert(loader);
//   log(map.toString());
//   log(map.toString());
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//   };
//   http.Response response = await http.post(Uri.parse(ApiUrl.otpApi),
//       body: jsonEncode(map), headers: headers);
//   if (response.statusCode == 200 || response.statusCode == 400) {
//     NewHelper.hideLoader(loader);
//     return ModelVerifyOtp.fromJson(json.decode(response.body));
//   } else {
//     // NewHelper.createSnackBar(context, response.statusCode.toString());
//     NewHelper.hideLoader(loader);
//     throw Exception(response.body);
//   }
// }
//
// Future<ForgotPasswordModel> forgotPassword(
//     String username, BuildContext context) async {
//   var map = <String, dynamic>{};
//   map['email'] = username;
//
//   OverlayEntry loader = Helpers.overlayLoader(context);
//   Overlay.of(context)!.insert(loader);
//
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//   };
//
//   http.Response response = await http.post(Uri.parse(ApiUrl.forgotPasswordUrl),
//       body: jsonEncode(map), headers: headers);
//
//   if (response.statusCode == 200  || response.statusCode == 400) {
//     Helpers.hideLoader(loader);
//     log("::::::::::username forgot password:::::::::::${response.body}");
//     return ForgotPasswordModel.fromJson(json.decode(response.body));
//   } else {
//     Helpers.createSnackBar(context, response.statusCode.toString());
//     Helpers.hideLoader(loader);
//     throw Exception(response.body);
//   }
// }
//
// Future<ForgotPasswordModel> resendOtp(
//     String username, BuildContext context) async {
//   var map = <String, dynamic>{};
//   map['email'] = username;
//
//   OverlayEntry loader = Helpers.overlayLoader(context);
//   Overlay.of(context)!.insert(loader);
//
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//   };
//
//   http.Response response = await http.post(Uri.parse(ApiUrl.resendOtpUrl),
//       body: jsonEncode(map), headers: headers);
//
//   if (response.statusCode == 200  || response.statusCode == 400) {
//     Helpers.hideLoader(loader);
//     log("::::::::::Resend Otp:::::::::::${response.body}");
//     return ForgotPasswordModel.fromJson(json.decode(response.body));
//   } else {
//     Helpers.createSnackBar(context, response.statusCode.toString());
//     Helpers.hideLoader(loader);
//     throw Exception(response.body);
//   }
// }
//
// Future<ModelCommonResponse> changePassword(
//     email, password, confirmPassword, BuildContext context) async {
//   var map = <String, dynamic>{};
//   map['email'] = email;
//   map['password'] = password;
//   map['confirm_password'] = confirmPassword;
//
//   OverlayEntry loader = Helpers.overlayLoader(context);
//   Overlay.of(context)!.insert(loader);
//
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//   };
//   print(map);
//   http.Response response = await http.post(Uri.parse(ApiUrl.resetPasswordUrl),
//       body: jsonEncode(map), headers: headers);
//   print(response.body);
//   if (response.statusCode == 200 || response.statusCode == 400) {
//     Helpers.hideLoader(loader);
//     return ModelCommonResponse.fromJson(json.decode(response.body));
//   } else {
//     Helpers.hideLoader(loader);
//     Helpers.createSnackBar(context, response.statusCode.toString());
//     throw Exception(response.body);
//   }
// }

