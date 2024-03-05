import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/login_model.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../resources/api_url.dart';
import '../resources/helper.dart';


Future<ModelCommonResponse> supportRepo({
  required name,
  required email,
  required phone,
  required reasonId,
  required message,
  required context,}) async {
  var map=<String, dynamic>{};
  map['name']=name;
  map['contact_us_reason_id']=reasonId;
  map['email']=email;
  map['phone_number']=phone;
  map['company']=message;
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

  try {
    final response = await http.post(
        Uri.parse("${ApiUrl.supportUrl}"),
        headers: headers,body: jsonEncode(map));

    print("Contact Support...${response.body}");
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print("Contact Support...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<ModelCommonResponse> sendRequestToAdmin({

  required reasonId,
  required message,
  required context,}) async {
  var map=<String, dynamic>{};
  map['contact_reason_id']=reasonId;
  map['message']=message;
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

  try {
    final response = await http.post(
        Uri.parse("${ApiUrl.sendRequestUrl}"),
        headers: headers,body: jsonEncode(map));


    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print("Send Request...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<ModelCommonResponse> saveChatRepo({

  required reasonId,
  required message,
  required context,}) async {
  var map=<String, dynamic>{};
  map['service_ticket_id']=reasonId;
  map['message']=message;
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

  try {
    final response = await http.post(
        Uri.parse("${ApiUrl.saveChatUrl}"),
        headers: headers,body: jsonEncode(map));


    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print("Save chat request...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}