



import 'package:chat_app101/Controller/ContactController.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Model/ChatModel.dart';
import 'package:chat_app101/Model/ChatRoomModel.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:chat_app101/Model/audioCall.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = const Uuid();
  RxString SelectedImagePath = "".obs;
  ProfileController profileController = Get.put(ProfileController()); 
  ContactController contactController = Get.put(ContactController());

  User? get currentUser => auth.currentUser;

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReciver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
      return targetUser;
    } else {
      return currentUser;
    }
  }

  Future<void> sendMessage(
    String targetUserId, String message, UserModel targetUser) async {
    isLoading.value = true;
    String chatId = uuid.v4(); // Use v4 for UUID
    String roomId = getRoomId(targetUserId);
    Timestamp nowTime = Timestamp.now(); // Use Timestamp

    UserModel sender = getSender(profileController.currentUser.value, targetUser);
    UserModel receiver = getReciver(profileController.currentUser.value, targetUser);

    
    RxString imageUrl = "".obs;
    if (SelectedImagePath.value.isNotEmpty){
      imageUrl.value = 
          await profileController.uploadFileToFirebase(SelectedImagePath.value);
    }



var newChat = ChatModel(
  id: chatId,
  message: message,
  imageUrl: imageUrl.value,
  senderId: auth.currentUser!.uid,
  receiverId: targetUserId,
  senderName: profileController.currentUser.value.name,
  timestamp: Timestamp.now(), // Correct usage
);

var roomDetails = ChatRoomModel(
  id: roomId,
  lastMessage: message,
  lastMessageTimestamp: Timestamp.now(), // Use Timestamp for Firestore
  sender: sender,
  receiver: receiver,
  timestamp: Timestamp.now(), // Use Timestamp
  unReadMessNo: 0,
);
    try {
      await db
          .collection("chats")
          .doc(roomId)
          .collection("messages")
          .doc(chatId)
          .set(newChat.toJson());
          SelectedImagePath.value = "";
      
      await db
          .collection("chats")
          .doc(roomId)
          .set(roomDetails.toJson());

      await contactController.saveContact(targetUser);
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection("chats")
        .doc(roomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
          print("Fetched ${snapshot.docs.length} messages");
          return snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList();
        });
  
  }

  Stream<UserModel> getStatus(String uid) {
    return db.
    collection('users').doc(uid).snapshots().map(
      (snapshot) {
       return UserModel.fromJson(snapshot.data()!);
      },
    );

  
} 
Stream<List<AudioCallModel>> getCalls() {
  return db
      .collection("users") // Assuming "users" is correct
      .doc(auth.currentUser!.uid)
      .collection("calls")
      .orderBy("timestamp", descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AudioCallModel.fromJson(doc.data()))
          .toList()
      );
}


  }


// import 'package:chat_app101/Controller/ProfileController.dart';
// import 'package:chat_app101/Model/ChatModel.dart';
// import 'package:chat_app101/Model/ChatRoomModel.dart';
// import 'package:chat_app101/Model/UserModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:intl/date_time_patterns.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';


// class ChatController extends GetxController {
//   final auth = FirebaseAuth.instance;
//   final db = FirebaseFirestore.instance;
//   RxBool isLoading = false.obs;
//   var uuid = Uuid();
//   ProfileController controller = Get.put(ProfileController()); 

//   User? get currentUser => auth.currentUser;

//   String getRoomId(String targetUserId) {
//     String currentUserId = auth.currentUser!.uid;
//     if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
//       return currentUserId + targetUserId;
//     } else {
//       return targetUserId + currentUserId;
//     }
//   }


//   UserModel getSender(UserModel currentUser, UserModel targetUser) {
//       String currentUserId = currentUser.id!;
//       String targetUserId = targetUser.id!;
//       if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
//         return currentUser;
//       } else {
//         return targetUser;
//       }
//     }
  
//   UserModel getReciver(UserModel currentUser, UserModel targetUser) {
//       String currentUserId = currentUser.id!;
//       String targetUserId = targetUser.id!;
//       if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)){
//         return targetUser;
//       } else {
//         return currentUser;
//       }
//     }

//   Future<void> sendMessage(
//     String targetUserId, String message, UserModel targetUser) async {
//     isLoading.value = true;
//     String chatId = uuid.v6(); // Use v4 for UUID
//     String roomId = getRoomId(targetUserId);
//     DateTime timestamp = DateTime.now();
//     String nowTime = DateFormat('hh:mm a').format(timestamp);

//     UserModel sender = getSender(controller.currentUser.value , targetUser);
//     UserModel receiver = getReciver(controller.currentUser.value , targetUser);


//     var newChat = ChatModel(
//       id: chatId,
//       message: message,
//       senderId: auth.currentUser!.uid,
//       receiverId: targetUserId,
//       senderName: controller.currentUser.value.name,
//       timestamp: DateTime.now().toString(),
//     );

//     var roomDetails = ChatRoomModel(
//       id: roomId,
//       lastMessage: message,
//       lastMessageTimestamp: nowTime,
//       sender: sender,
//       receiver: receiver,
//       timestamp: DateTime.now().toString(),
//       unReadMessNo: 0,
     
//       );
//     try {
//       await db
//           .collection("chats")
//           .doc(roomId)
//           .collection("messages") // Changed to "messages"
//           .doc(chatId)
//           .set(
//             newChat.toJson()
//             ); 
//       await db
//           .collection("chats")
//           .doc(roomId)
//           .set(roomDetails.toJson(),
//           ); // Debug print
//     } catch (e) {
//       print(e);
//     }
//     isLoading.value = false;
//   }







//   Stream<List<ChatModel>> getMessages(String targetUserId) {
//     String roomId = getRoomId(targetUserId);
//     return db
//         .collection("chats")
//         .doc(roomId)
//         .collection("messages") // Ensure this matches with sendMessage
//         .orderBy("timestamp", descending: true)
//         .snapshots()
//         .map((snapshot) {
//           print("Fetched ${snapshot.docs.length} messages"); // Debug print
//           return snapshot.docs
//               .map((doc) => ChatModel.fromJson(doc.data() as Map<String, dynamic>))
//               .toList();
//         });



//   }







//   }

