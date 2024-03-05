import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/category_model.dart';
import 'package:fresh2_arrive/model/login_model.dart';
import 'package:fresh2_arrive/resources/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sub_category_ofCategory_model.dart';
import '../resources/helper.dart';

Future<CategoryModel> categoryData({page, pagination, BuildContext? context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  if (context != null) {
    Overlay.of(context)!.insert(loader);
  }
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  http.Response response =
      await http.get(Uri.parse("${ApiUrl.categoriesUrl}?page=$page&pagination=$pagination"), headers: headers);
  Helpers.hideLoader(loader);

  if (response.statusCode == 200) {
    print("<<<<<<<All CategoryList from repository=======>${response.body}");
    return CategoryModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}

// for subcategory
Future<SubCategoryModel> subCategoryRepo({required id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };

  // try {
  final response = await http.get(
      Uri.parse("${ApiUrl.subCategoryUrl}/$id"),
      headers: headers);
  if (response.statusCode == 200) {
    log("subcategory list of category...${response.body}");
    return SubCategoryModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
  // } catch (e) {
  // }
}
