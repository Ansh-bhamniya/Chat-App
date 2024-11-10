import 'package:chat_app101/Model/ChatRoomModel.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList(); // Fetch chat room list when controller is initialized
  }

  // Method to get the user list from Firestore
  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      userList.clear();
      QuerySnapshot<Map<String, dynamic>> snapshot = await db.collection("users").get();
      userList.value = snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
    } catch (ex) {
      print("Error fetching user list: $ex");
      // Handle error as needed, e.g., show error message
    } finally {
      isLoading.value = false;
    }
  }

  // Method to get chat room list from Firestore
  Future<void> getChatRoomList() async {
    try {
      // chatRoomList.clear();
      List<ChatRoomModel> tempChatRoom = [];
      await db
          .collection("chats")
          .orderBy("timestamp", descending: true)
          .get()
          .then((value) {
        tempChatRoom = value.docs
            .map((e) => ChatRoomModel.fromJson(e.data()))
            .toList();
      });

      chatRoomList.value = tempChatRoom.where(
        (e) => e.id!.contains(auth.currentUser!.uid),
      ).toList();

      print("Fetched chat rooms: ${chatRoomList.length}");
    } catch (ex) {
      print("Error fetching chat room list: $ex");
    }

  }

  Future<void> saveContact(UserModel user) async{
    try{
      await db 
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("contacts")
        .doc(user.id)
        .set(user.toJson());
    } catch (ex) {
      if (kDebugMode){
      print("Error while saving Contact$ex");
    
    
      }
    }
  }
Stream<List<UserModel>> getContacts() {
  return db
      .collection("users")
      .doc(auth.currentUser!.uid)
      .collection("contacts")
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data()))
          .toList(),
          );
}  
}

// import 'package:chat_app101/Controller/AuthController.dart';
// import 'package:chat_app101/Model/UserModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// class ContactController extends GetxController{
//   final db = FirebaseFirestore.instance;
//   final auth = FirebaseAuth.instance;
//   RxBool isLoading = false.obs;
//   RxList<UserModel> userList = <UserModel>[].obs;



//   void onInit() async{
//     super.onInit();
//     await getUserList();
//   }



//   Future<void> getUserList()async {
//     isLoading.value = true;
//     try {
//       userList.clear();
//       await db.collection("user").get().then(
//         (value) =>{
//           userList.value = value.docs
//           .map(
//             (e) => UserModel.fromJson(e.data()),

//           )
//           .toList(),

//         },
//       );
//     } catch(ex){
//       print(ex);

//     }
//     isLoading.value = false;
//   }
  
// }