import 'dart:convert';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import '../model/user_profile_model.dart';


class FirebaseService{
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  Future<Data> getUserDetails({required userId}) async {
    final item =await firebaseDatabase.ref("users/$userId/user_details").get();
    log("Getting user data from Firebase..........      ${item.value}");
    if(item.exists){
      return Data.fromJson(jsonDecode(jsonEncode(item.value)));
    } else {
      return Data();
    }
  }

}