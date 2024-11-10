import 'package:chat_app101/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Timestamp

class GroupModel {
  String? id;
  String? name;
  String? description;
  String? profileUrl;
  List<UserModel>? members;
  String? createdAt;
  String? createdBy;
  String? status;
  String? lastMessage;
  Timestamp? lastMessageTime; // Use Timestamp for Firestore
  String? lastMessageBy;
  int? unReadCount;
  Timestamp? timeStamp; // Use Timestamp for Firestore

  GroupModel({
    this.id,
    this.name,
    this.description,
    this.profileUrl,
    this.members,
    this.createdAt,
    this.createdBy,
    this.status,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageBy,
    this.unReadCount,
    this.timeStamp,
  });

  // Factory constructor to create a GroupModel object from JSON
  GroupModel.fromJson(Map<String, dynamic> json){
      
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["profileUrl"] is String) {
      profileUrl = json["profileUrl"];
    }
    // if (json["members"] is Map) {
    //   json["members"] == null ? null : UserModel.fromJson(json["members"]);
    // }    
    
    if (json["members"] != null) {
      members =List<UserModel>.from(
        json["members"].map((memberJson) => UserModel.fromJson(memberJson)),
      );
    }
    else {
      members =[];
    }
        

    if (json["CreatedAt"] is String) {
      createdAt = json["CreatedAt"];
    }
    if (json["CreatedBy"] is String) {
      createdBy = json["CreatedBy"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["lastMessage"] is String) {
      lastMessage = json["lastMessage"];
    }
    if (json["lastMessageTime"] is Timestamp) {
      lastMessageTime = json["lastMessageTime"]; // Use Timestamp
    }
    if (json["lastMessageBy"] is String) {
      lastMessageBy = json["lastMessageBy"];
    }
    if (json["unReadCount"] is int) {
      unReadCount = json["unReadCount"];
    }
    if (json["TimeStamp"] is Timestamp) {
      timeStamp = json["TimeStamp"]; // Use Timestamp
    }
  }

  // Method to convert a GroupModel object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

      data["id"] = id;
      data["name"] = name;
      data["description"] = description;
      data["profileUrl"] = profileUrl;
      if (members !=null){
        data["members"] = members;
      }
      data["CreatedAt"] = createdAt;
      data["CreatedBy"] = createdBy;
      data["status"] = status;
      data["lastMessage"] = lastMessage;
      data["lastMessageTime"] = lastMessageTime; // Store as Timestamp
      data["lastMessageBy"] = lastMessageBy;
      data["unReadCount"] = unReadCount;
      data["TimeStamp"] = timeStamp; // Store as Timestamp
    return data;
  }
}
