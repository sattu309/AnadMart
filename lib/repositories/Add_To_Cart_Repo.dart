import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fresh2_arrive/model/login_model.dart';
import 'package:fresh2_arrive/model/model_common_ressponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Add_To_Cart_Model.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<AddToCartData> addToCartRepo({required String variant_id,required String product_id,required String qty,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['variant_id'] = variant_id;
  map['product_id'] = product_id;
  map['qty'] = qty;
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
      LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  log(map.toString());
  try {
    final response = await http.post(Uri.parse(ApiUrl.addCartUrl),
        body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      log("Add To Cart Data...${response.body}");
      return AddToCartData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}


//cancel order
Future<ModelCommonResponse> cancelOrderRepo({required String orderId,required String status,required BuildContext context}) async {
  var map = <String, dynamic>{};
  map['order_id'] = orderId;
  map['status'] = status;

  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  log(map.toString());
  try {
    final response = await http.post(Uri.parse(ApiUrl.cancelOrderUrl),
        body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      log("Cencel order repoo...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<ModelCommonResponse> updateCartRepo(cartItemId, qty, context) async {
  var map = <String, dynamic>{};
  map['cart_id'] = cartItemId;
  map['qty'] = qty;
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  try {
    final response = await http.post(Uri.parse(ApiUrl.updateCartUrl),
        body: jsonEncode(map), headers: headers);
    print("Update Cart Data...${response.body}");
    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideShimmer(loader);
      print("Update Cart Data...${response.body}");
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<ModelCommonResponse> reOrderRepo(
    {required context,required id}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel? user =
  LoginModel.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // log(map.toString());
  http.Response response = await http.post(Uri.parse("${ApiUrl.reOrdersUrl}/$id"),headers: headers,);
  log("${ApiUrl.reOrdersUrl}$id");
  log(response.body.toString());
  if (response.statusCode == 200 || response.statusCode==400) {
    log(response.body.toString());
    Helpers.hideLoader(loader);
    return ModelCommonResponse.fromJson(json.decode(response.body));
  } else {
    log(response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}




