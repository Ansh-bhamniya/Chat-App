



import 'package:chat_app101/Model/ChatModel.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Timestamp

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<ChatModel> messages;
  int? unReadMessNo;
  String? lastMessage;
  Timestamp? lastMessageTimestamp; // Change this to Timestamp
  Timestamp? timestamp; // Change this to Timestamp

  ChatRoomModel({
    this.id,
    this.sender,
    this.receiver,
    List<ChatModel>? messages,
    this.unReadMessNo,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.timestamp,
  }) : messages = messages ?? [];

  // Updated fromJson method to handle Timestamps
  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : messages = (json["messages"] as List? ?? [])
            .map((i) => ChatModel.fromJson(i))
            .toList() {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["sender"] is Map) {
      sender = json["sender"] == null ? null : UserModel.fromJson(json["sender"]);
    }
    if (json["receiver"] is Map) {
      receiver = json["receiver"] == null ? null : UserModel.fromJson(json["receiver"]);
    }
    if (json["unReadMessNo"] is int) {
      unReadMessNo = json["unReadMessNo"];
    }
    if (json["lastMessage"] is String) {
      lastMessage = json["lastMessage"];
    }
    if (json["lastMessageTimestamp"] is Timestamp) {
      lastMessageTimestamp = json["lastMessageTimestamp"]; // Use Timestamp
    }
    if (json["timestamp"] is Timestamp) {
      timestamp = json["timestamp"]; // Use Timestamp
    }
  }

  // Updated toJson method to handle Timestamps
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    if (sender != null) {
      data["sender"] = sender?.toJson();
    }
    if (receiver != null) {
      data["receiver"] = receiver?.toJson();
    }
    data["messages"] = messages.map((m) => m.toJson()).toList();
    data["unReadMessNo"] = unReadMessNo;
    data["lastMessage"] = lastMessage;
    data["lastMessageTimestamp"] = lastMessageTimestamp; // Store as Timestamp
    data["timestamp"] = timestamp; // Store as Timestamp
    return data;
  }
}

// import 'package:chat_app101/Model/ChatModel.dart';
// import 'package:chat_app101/Model/UserModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatRoomModel {
//   String? id;
//   UserModel? sender;
//   UserModel? receiver;
//   List<ChatModel> messages;
//   int? unReadMessNo;
//   String? lastMessage;
//   Timestamp? lastMessageTimestamp;
//   Timestamp? timestamp;

//   ChatRoomModel({
//     this.id,
//     this.sender,
//     this.receiver,
//     List<ChatModel>? messages,
//     this.unReadMessNo,
//     this.lastMessage,
//     this.lastMessageTimestamp,
//     this.timestamp,
//   }) : messages = messages ?? [];

//   ChatRoomModel.fromJson(Map<String, dynamic> json)
//       : messages = (json["messages"] as List? ?? []).map((i) => ChatModel.fromJson(i)).toList() {
//     if (json["id"] is String) {
//       id = json["id"];
//     }
//     if (json["sender"] is Map) {
//       sender = json["sender"] == null ? null : UserModel.fromJson(json["sender"]);
//     }
//     if (json["receiver"] is Map) {
//       receiver = json["receiver"] == null ? null : UserModel.fromJson(json["receiver"]);
//     }
//     if (json["unReadMessNo"] is int) {
//       unReadMessNo = json["unReadMessNo"];
//     }
//     if (json["lastMessage"] is String) {
//       lastMessage = json["lastMessage"];
//     }
//     if (json["lastMessageTimestamp"] is String) {
//       lastMessageTimestamp = json["lastMessageTimestamp"];
//     }
//     if (json["timestamp"] is String) {
//       timestamp = json["timestamp"];
//     }
//   }
  

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     if (sender != null) {
//       _data["sender"] = sender?.toJson();
//     }
//     if (receiver != null) {
//       _data["receiver"] = receiver?.toJson();
//     }
//     if (messages != null) {
//       _data["messages"] = messages;
//     }
//     _data["unReadMessNo"] = unReadMessNo;
//     _data["lastMessage"] = lastMessage;
//     _data["lastMessageTimestamp"] = lastMessageTimestamp;
//     _data["timestamp"] = timestamp;
//     return _data;
//   }
// }

// class Receiver{
//   Receiver();

//   Receiver.fromJson(Map<String, dynamic> json){

//   }

//   Map<String,dynamic> toJson(){
//     final Map<String, dynamic> _data = <String, dynamic>{};

//     return _data;
//   }
// }

// class Sender{
//   Sender();

//   Sender.fromJson(Map<String, dynamic> json){

//   }

//   Map<String,dynamic> toJson(){
//     final Map<String, dynamic> _data = <String, dynamic>{};

//     return _data;
//   }
// }