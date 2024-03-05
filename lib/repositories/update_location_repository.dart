import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> updateLocation(
    {required latitude,required longitude}) async {
  var map = <String, dynamic>{};
  map['latitude'] = latitude;
  map['longitude'] = longitude;
  log(map.toString());
  SharedPreferences pref = await SharedPreferences.getInstance();
  ModelVerifyOtp? user =
  ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  http.Response response = await http.post(Uri.parse(ApiUrl.updateLocationUrl),
      body: jsonEncode(map), headers: headers);
  log("Hlllloooo"+ response.body.toString());
  if (response.statusCode == 200 ||response.statusCode == 400) {
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

