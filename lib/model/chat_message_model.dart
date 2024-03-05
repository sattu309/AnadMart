import 'dart:convert';

List<ChatMessage> chatModelListFromJson(String str) => List<ChatMessage>.from(
    json.decode(str).map((x) => ChatMessage.fromJson(x)));

class ChatMessage {
  String? message;
  String? message_type;
  int? timeStamp;
  String? sender_id;
  String? receiver_id;
  ChatMessage(
      {this.message,
        this.message_type,
        this.receiver_id,
        this.sender_id,
        this.timeStamp});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    message_type = json["message_type"];
    timeStamp = json["timeStamp"];
    sender_id = json["sender_id"];
    receiver_id = json["receiver_id"];
  }
}
