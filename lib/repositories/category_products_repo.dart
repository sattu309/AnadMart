import 'dart:convert';
import 'dart:developer';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/login_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/category_products_model.dart';
import '../resources/helper.dart';

Future<ProductModel> categoryProductsData({id,page, pagination}) async {
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // if (context != null) {
  //   Overlay.of(context)!.insert(loader);
  // }
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user = LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  String url="${ApiUrl.categoriesProductsUrl}/$id?page=$page&pagination=10";
  log("<<<<<<<Category products url=======>${url}");
  http.Response response =
  await http.get(Uri.parse(url), headers: headers);
  // Helpers.hideLoader(loader);
    log("<<<<<<<Category products repository=======>${response.body}");

  if (response.statusCode == 200) {
    return ProductModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}