import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fresh2_arrive/model/login_model.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:fresh2_arrive/resources/helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/forgot_password_model.dart';
import '../model/verifyOtpForMart.dart';
import '../resources/api_url.dart';

Future<ForgotPasswordModel> forgotPasswordRepo(
    {required String email,
      // required String fcmToken,
      required BuildContext context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email'] = email;
  //map['role'] = roleText;

  log("Forgot password Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse('${ApiUrl.forgotPasswordUrl}'),body: jsonEncode(map),
        headers: headers, );

    if (response.statusCode == 200||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return ForgotPasswordModel.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
// verify otp
Future<ModelCommonResponse> verifyOtpRepo(
    {required String email,
      required String otp,
      required String forgot_password,
      required BuildContext context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email'] = email;
  map['otp'] = otp;
  map['type'] = forgot_password;

  log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrl.verifyOtpOfMart),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// verify otp for login
Future<VerityOtpModel> verifyOtpForLoginRepo(
    {required String email,
      required String otp,
      required BuildContext context
    }) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  // print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email'] = email;
  map['otp'] = otp;

  log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      // HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };

    http.Response response = await http.post(Uri.parse(ApiUrl.verifyOtpForLoginOfMart),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return VerityOtpModel.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// resend otp
Future<ForgotPasswordModel> resendOtpRepo(
    {required String email,
      required BuildContext context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel? user =
  // LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email'] = email;
  // map['device_id'] = pref.getString('deviceId');
  // map['device_token'] = fcmToken;

  log("Login Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(Uri.parse(ApiUrl.resendOtpOfMart),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return ForgotPasswordModel.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// reset password
Future<ModelCommonResponse> resetPasswordRepo(
    {required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel? user =
  // LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['email'] = email;
  map['password'] = password;
  map['confirm_password'] = confirmPassword;
  log("Reset password Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      // HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    http.Response response = await http.post(Uri.parse(ApiUrl.resetPasswordOfMart),
        body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// change password
Future<ModelCommonResponse> changePasswordRepo(
    {
      required String oldPassword,
      required String newPassword,
      required String confirmPassword,
      required BuildContext context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  //print("These are details.....${pref}");
  var map = <String, dynamic>{};
  map['old_password'] = oldPassword;
  map['new_password'] = newPassword;
  map['confirm_password'] = confirmPassword;
  log("Change password Data map$map");
  try {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer ${user.authToken}"
    };
    http.Response response = await http.post(Uri.parse(ApiUrl.changePasswordOfMart),
        body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}