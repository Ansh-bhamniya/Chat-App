import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? id;
  String? message;
  String? senderName;
  String? senderId;
  String? receiverId;
  Timestamp? timestamp; // Change to Timestamp
  String? readStatus;
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  String? documentUrl;
  List<String>? reactions;
  List<dynamic>? replies;

  ChatModel({
    this.id,
    this.message,
    this.senderName,
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.readStatus,
    this.imageUrl,
    this.videoUrl,
    this.audioUrl,
    this.documentUrl,
    this.reactions,
    this.replies,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["message"] is String) {
      message = json["message"];
    }
    if (json["senderName"] is String) {
      senderName = json["senderName"];
    }
    if (json["senderId"] is String) {
      senderId = json["senderId"];
    }
    if (json["receiverId"] is String) {
      receiverId = json["receiverId"];
    }
    if (json["timestamp"] is Timestamp) {
      timestamp = json["timestamp"]; // Ensure it's a Timestamp
    }
    if (json["readStatus"] is String) {
      readStatus = json["readStatus"];
    }
    if (json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
    if (json["videoUrl"] is String) {
      videoUrl = json["videoUrl"];
    }
    if (json["audioUrl"] is String) {
      audioUrl = json["audioUrl"];
    }
    if (json["documentUrl"] is String) {
      documentUrl = json["documentUrl"];
    }
    if (json["reactions"] is List) {
      reactions = List<String>.from(json["reactions"]);
    }
    if (json["replies"] is List) {
      replies = List<dynamic>.from(json["replies"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["message"] = message;
    data["senderName"] = senderName;
    data["senderId"] = senderId;
    data["receiverId"] = receiverId;
    data["timestamp"] = timestamp; // Store as Timestamp
    data["readStatus"] = readStatus;
    data["imageUrl"] = imageUrl;
    data["videoUrl"] = videoUrl;
    data["audioUrl"] = audioUrl;
    data["documentUrl"] = documentUrl;
    data["reactions"] = reactions;
    data["replies"] = replies;
    return data;
  }
}

// class ChatModel {
//   String? id;
//   String? message;
//   String? senderName;
//   String? senderId;
//   String? receiverId;
//   String? timestamp;
//   String? readStatus;
//   String? imageUrl;
//   String? videoUrl;
//   String? audioUrl;
//   String? documentUrl;
//   List<String>? reactions;
//   List<dynamic>? replies;

//   ChatModel( {
//     this.id,
//     this.message,
//     this.senderName,
//     this.senderId,
//     this.receiverId,
//     this.timestamp,
//     this.readStatus,
//     this.imageUrl,
//     this.videoUrl,
//     this.audioUrl,
//     this.documentUrl,
//     this.reactions,
//     this.replies, 
//   });

//   ChatModel.fromJson(Map<String, dynamic> json) {
//     if (json["id"] is String) {
//       id = json["id"];
//     }
//     if (json["message"] is String) {
//       message = json["message"];
//     }
//     if (json["senderName"] is String) {
//       senderName = json["senderName"];
//     }
//     if (json["senderId"] is String) {
//       senderId = json["senderId"];
//     }
//     if (json["receiverId"] is String) {
//       receiverId = json["receiverId"];
//     }
//     if (json["timestamp"] is String) {
//       timestamp = json["timestamp"];
//     }
//     if (json["readStatus"] is String) {
//       readStatus = json["readStatus"];
//     }
//     if (json["imageUrl"] is String) {
//       imageUrl = json["imageUrl"];
//     }
//     if (json["videoUrl"] is String) {
//       videoUrl = json["videoUrl"];
//     }
//     if (json["audioUrl"] is String) {
//       audioUrl = json["audioUrl"];
//     }
//     if (json["documentUrl"] is String) {
//       documentUrl = json["documentUrl"];
//     }
//     if (json["reactions"] is List) {
//       reactions = List<String>.from(json["reactions"]);
//     }
//     if (json["replies"] is List) {
//       replies = List<dynamic>.from(json["replies"]);
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> _data = <String, dynamic>{};
//     _data["id"] = id;
//     _data["message"] = message;
//     _data["senderName"] = senderName;
//     _data["senderId"] = senderId;
//     _data["receiverId"] = receiverId;
//     _data["timestamp"] = timestamp;
//     _data["readStatus"] = readStatus;
//     _data["imageUrl"] = imageUrl;
//     _data["videoUrl"] = videoUrl;
//     _data["audioUrl"] = audioUrl;
//     _data["documentUrl"] = documentUrl;
//     _data["reactions"] = reactions;
//     _data["replies"] = replies;
//     return _data;
//   }
// }
