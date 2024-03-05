// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../model/login_model.dart';
// import '../model/single_product_mart_model.dart';
// import '../resources/api_url.dart';
//
// Future<SingleProductModel> singleProductScreenRepo({required id}) async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   LoginModel? user =
//   LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
//   };
//
//   // try {
//   final response = await http.get(
//       Uri.parse("${ApiUrl.singleProductScreenUrl}/$id"),
//       headers: headers);
//   if (response.statusCode == 200) {
//     log("Single Product of Mart.....${response.body}");
//     return SingleProductModel.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception(response.body);
//   }
//   // } catch (e) {
//   // }
// }