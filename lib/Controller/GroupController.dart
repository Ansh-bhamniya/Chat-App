import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Model/ChatModel.dart';
import 'package:chat_app101/Model/GroupModel.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:chat_app101/Pages/Home/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController{
  RxList<UserModel> groupMember  =<UserModel>[].obs;
  RxString SelectedImagePath = "".obs;

  final db = FirebaseFirestore.instance;  
  final auth = FirebaseAuth.instance;

  RxList<GroupModel> groupList = <GroupModel>[].obs;
  ProfileController profileController = Get.put(ProfileController());  

  var uuid = const Uuid();
  RxBool isLoading = false.obs;  

  
  @override
  void onInit() { 
    super.onInit();
    getGroups();
  }


  void selectMember(UserModel user){
    if (groupMember.contains(user)){
      groupMember.remove(user);

    }else {
      groupMember.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true; 
    String groupId = uuid.v4(); 
    groupMember.add(    UserModel(
      id: auth.currentUser!.uid,
      name: profileController.currentUser.value.name,
      profileImage: profileController.currentUser.value.profileImage,
      email: profileController.currentUser.value.email,
      role: "admin",

    ),);
    try {
      if (auth.currentUser == null) {
        Get.snackbar("Error", "You must be logged in to create a group.");
        return;
      }

      String imageUrl = await profileController.uploadFileToFirebase(imagePath);
      
      await db.collection("groups").doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMember.map((e) => e.toJson()).toList(),
        "createdAt" : DateTime.now().toString(),
        "createdBy": auth.currentUser!.uid,
        "timeStamp": Timestamp.now(),
      });

      Get.snackbar("Group Created", "Group created successfully");
      await getGroups(); // Fetch the updated groups
      Get.offAll(const HomePage());
    } catch (e) {
      print("Error creating group: $e");
      Get.snackbar("Error", "Failed to create group: ${e.toString()}");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }


  Future<void> getGroups() async {
  isLoading.value = true;
  List<GroupModel> tempGroup = [];
  
  await db.collection("groups").get().then(
    (value) {
      tempGroup = value.docs
          .map((e) {
            print("Group Data: ${e.data()}"); // Debugging
            return GroupModel.fromJson(e.data());
          })
          .toList();
    },
  );

  groupList.clear();
  groupList.value = tempGroup
  .where(
    (e) => e.members!.any(
      (element) => element.id == auth.currentUser!.uid
      ),
      )
      .toList();
  isLoading.value = false;
}

Future<void> sendGroupMessage(String message, String groupId, String imagePath) async {
  isLoading.value = true;
  var uuid = const Uuid(); // Proper UUID instance
  var chatId = uuid.v4(); // Correct UUID v4

  String imageUrl = await profileController.uploadFileToFirebase(SelectedImagePath.value);
  var newChat = ChatModel(
    id: chatId,
    message: message,
    imageUrl: imageUrl,
    senderId: auth.currentUser!.uid,
    senderName: profileController.currentUser.value.name, // Ensure this exists
    timestamp: Timestamp.now(),
  );

  await db.collection("groups")
      .doc(groupId)
      .collection("messages")
      .doc(chatId)
      .set(
        newChat.toJson(),
      );
      SelectedImagePath.value = "";
      isLoading.value = false;
}

Stream<List<ChatModel>> getGroupMessages(String groupId) {
  return db
      .collection("groups")
      .doc(groupId)
      .collection("messages")
      .orderBy("timestamp", descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());

}

Future<void> addMemberToGroup(String groupId, UserModel newMember) async {
    isLoading.value = true; // Show loading indicator

      // Update the 'members' array in Firestore
      await db.collection("groups")
          .doc(groupId)
          .update({
        "members": FieldValue.arrayUnion([newMember.toJson()]), // Add new member
      }
      );

      getGroups();
      isLoading.value = false;


    } 
  }

