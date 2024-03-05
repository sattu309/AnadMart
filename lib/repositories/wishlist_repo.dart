import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/model_common_ressponse.dart';
import '../model/wishlist_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> wishlistRepo({required productId, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  var map =  <String,dynamic>{};
  map ['product_id'] = productId;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  print(map);

  final response = await http.post(Uri.parse(ApiUrl.wishlistUrl),
    headers: headers,body: jsonEncode(map),);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    log("Wishlist Repository...${response.body}");
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(jsonDecode(response.body));
  }
}

// wishlist data list
Future<WishListModel> favoriteData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  log(user.authToken.toString());
  http.Response response =
  await http.get(Uri.parse(ApiUrl.favoriteListUrl), headers: headers);
  if (response.statusCode == 200) {
    log("<<<<<<<favorite Data=======>${response.body}");
    return WishListModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}