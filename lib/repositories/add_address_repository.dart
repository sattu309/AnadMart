import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:fresh2_arrive/widgets/add_text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../model/verify_otp_model.dart';
import '../model/zipcode_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> addAddress(
    {required address1,
    required address2,
    required city,
    required state,
    required zipCode,
    required addressType,
    required otherInstruction,
    required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['address_1'] = address1;
  map['address_2'] = address2;
  map['city'] = city;
  map['state'] = state;
  map['zip_code'] = zipCode;
  map['address_type'] = addressType;
  map['other_instruction'] = otherInstruction;
  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
      ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {

    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.addAddressUrl),
      body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200 ||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ModelCommonResponse> editAddress(
    {required address1, required otherInstruction, required address2,required city,required state,required addressType, required zipCode, required id, required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['address_1'] = address1;
  map['address_2'] = address2;
  map['city'] = city;
  map['state'] = state;
  map['zip_code'] = zipCode;
  map['address_type'] = addressType;
  map['other_instruction'] = otherInstruction;
  map['id'] = id;
  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.editAddressUrl),
      body: jsonEncode(map), headers: headers);
  print(response.body);
  if (response.statusCode == 200 ||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}



Future<ModelCommonResponse> removeAddress(
    {required addressId,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['address_id'] = addressId;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.removeAddressUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200 ||response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ModelCommonResponse> chooseOrderAddress(
    {required addressId,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['address_id'] = addressId;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.chooseOrderAddressUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

Future<ZipcodeDataModel> sendZipcodeRepo(
    {required addressId,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['zip'] = addressId;
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.sendZipcodeUrl),headers: headers,body:jsonEncode(map));
  log(response.body.toString());
  log(response.statusCode.toString());
  if (response.statusCode == 200 || response.statusCode == 404 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return ZipcodeDataModel.fromJson(json.decode(response.body));
  } else {
    showToast(response.body.toString());
    // Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}