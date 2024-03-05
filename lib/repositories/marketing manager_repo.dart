import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/model_common_ressponse.dart';
import '../model/verify_otp_model.dart';
import '../resources/api_url.dart';
import '../resources/helper.dart';

Future<ModelCommonResponse> marketingPartnerRegistrationRepo({
  mapData,
  required Map<String,File> imageMap,
  required context,
}) async {
  try {
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiUrl.managerNetwork));
    SharedPreferences pref = await SharedPreferences.getInstance();
    ModelVerifyOtp? user =
    ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
    };
    request.headers.addAll(headers);
    request.fields.addAll(mapData);

    imageMap.entries.forEach((element) async {
      if(element.value.path.isNotEmpty){
        request.files.add(await multipartFile(element.key, element.value));
      }
    });

    log(request.fields.toString());
    log(request.files.map((e) => e.filename).toList().toString());
    final response = await request.send();
    if (response.statusCode == 200 || response.statusCode == 400) {
      return ModelCommonResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      return ModelCommonResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    }
  } on SocketException {
    return ModelCommonResponse(message: "No Internet Access", status: false);
  } catch (e) {
    return ModelCommonResponse(message: e.toString(), status: false);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}



// Future<ModelCommonResponse> vendorInformationEditRepo(
//     {required storeName, required location, required BuildContext context}) async {
//   var map = <String, dynamic>{};
//   map['store_name'] = storeName;
//   map['location'] = location;
//   log(map.toString());
//   OverlayEntry loader = Helpers.overlayLoader(context);
//   Overlay.of(context)!.insert(loader);
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   ModelVerifyOtp? user =
//   ModelVerifyOtp.fromJson(jsonDecode(pref.getString('user_info')!));
//   final headers = {
//     HttpHeaders.contentTypeHeader: 'application/json',
//     HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
//   };
//   http.Response response = await http.post(Uri.parse(ApiUrl.vendorInformationEditUrl),
//       body: jsonEncode(map), headers: headers);
//   print(response.body);
//   if (response.statusCode == 200) {
//     Helpers.hideLoader(loader);
//     return ModelCommonResponse.fromJson(json.decode(response.body));
//   } else {
//     Helpers.createSnackBar(context, response.body.toString());
//     Helpers.hideLoader(loader);
//     throw Exception(response.body);
//   }
// }
