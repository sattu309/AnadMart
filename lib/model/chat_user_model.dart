import 'dart:convert';

List<ChatUsers> chatUsersListFromJson(String str) =>
    List<ChatUsers>.from(json.decode(str).map((x) => ChatUsers.fromJson(x)));

class ChatUsers {
  int? timeStamp;
  String? receiverId;
  String? lastMessage;
  String? messageType;
  int? myLastSeen;
  String? senderId;
  String? other_id;
  String? name;

  ChatUsers(
      {this.timeStamp,
        this.receiverId,
        this.lastMessage,
        this.messageType,
        this.myLastSeen,
        this.senderId,
        this.other_id,
        this.name,
      });

  ChatUsers.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    receiverId = json['receiver_id'];
    lastMessage = json['last_message'];
    messageType = json['message_type'];
    myLastSeen = json['my_last_seen'];
    senderId = json['sender_id'];
    other_id = json['other_id'];
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeStamp'] = timeStamp;
    data['receiver_id'] = receiverId;
    data['last_message'] = lastMessage;
    data['message_type'] = messageType;
    data['my_last_seen'] = myLastSeen;
    data['sender_id'] = senderId;
    data['other_id'] = other_id;
    data['name'] = name;
    return data;
  }
}
