import 'dart:io';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final store = FirebaseStorage.instance;
  RxBool isLoading = false.obs;

  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      final uid = auth.currentUser?.uid;
      if (uid != null) {
        final doc = await db.collection("users").doc(uid).get();
        if (doc.exists) {
          final data = doc.data();
          if (data != null) {
            currentUser.value = UserModel.fromJson(data);
          } else {
            print("User document is empty");
          }
        } else {
          print("User document does not exist");
        }
      } else {
        print("No user is currently signed in");
      }
    } catch (e) {
      print("Error getting user details: $e");
    }
  }

  Future<void> updateProfile(
    String imageUrl,
    String name,
    String about,
    String number,
  ) async {
    isLoading.value = true;
    try {
      final uid = auth.currentUser?.uid;
      final email = auth.currentUser?.email;
      if (uid != null && email != null) {
        final imageLink = imageUrl.isEmpty ? currentUser.value.profileImage : await uploadFileToFirebase(imageUrl);
        final updatedUser = UserModel(
          id: uid,
          email: email,
          name: name,
          About: about,
          profileImage: imageLink,
          phoneNumber: number,
        );
        await db.collection("users").doc(uid).set(updatedUser.toJson());
        await getUserDetails();
      } else {
        print("No user is currently signed in or email is null");
      }
    } catch (ex) {
      print("Error updating profile: $ex");
    } finally {
      isLoading.value = false;
    }
  }

  
Future<String> uploadFileToFirebase(String imagePath) async {
  if (imagePath.isNotEmpty) {
    try {
      final path = "file/$imagePath";
      final file = File(imagePath);

      // Reference to Firebase Storage
      final ref = store.ref().child(path);

      // Start the upload task
      final uploadTask = await ref.putFile(file);

      // Wait for completion and get the download URL
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      print("DownloadImageUrl: $downloadUrl");

      return downloadUrl;
    } catch (ex) {
      print("Error uploading file: $ex");
      return "";
    }
  } else {
    print("Invalid image path");
    return "";
  }
}

  void addMemberToGroup(String groupId, UserModel newMember) {}
}
  

//   Future<String> uploadFileToFirebase(String imagePath) async {
//     final path = "files/${imagePath}";
//     final file = File(imagePath!);
//     if (imagePath != ""){
//       try {
//       final ref = store.ref().child(path).putFile(file);
//       final uploadTask = await ref.whenComplete(() {});
//       final downloadUrl = await uploadTask.ref.getDownloadURL();
//       print("DownloadImageUrl");
//       return downloadUrl;
//     }

//     } catch (ex) {
//       print("ex");
//       return "";
//     }
//   }
  
// }


// import 'dart:ffi';
// import 'dart:io';

// import 'package:chat_app101/Controller/AuthController.dart';
// import 'package:chat_app101/Model/UserModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';

// class ProfileController extends GetxController {
//   final auth = FirebaseAuth.instance;
//   final db = FirebaseFirestore.instance;
//   final store = FirebaseStorage.instance;
//   RxBool isLoading = false.obs;

//   Rx<UserModel> currentUser = UserModel().obs;

//   void onInit() async {
//     super.onInit();
//     await getUserDetails();
//   }

//   Future<void> getUserDetails() async {
//     await db.collection("users").doc(auth.currentUser!.uid).get().then(
//           (value) => {
//             currentUser.value = UserModel.fromJson(
//               value.data()!,
//             ),
//           },
//         );
//   }

//   Future<void> updateProfile(
//     String imageUrl,
//     String name,
//     String about,
//     String number,
//   ) async {
//     isLoading.value = true;
//     try{

//      final imageLink = await uploadFileToFirebase(imageUrl);
//     final updatedUser = UserModel(
//       id: auth.currentUser!.uid,
//       email: auth.currentUser!.email,
//       name: name,
//       About: about,
//       profileImage: imageUrl == "" ? currentUser.value.profileImage : imageLink,
//       phoneNumber: number,
//     );
//     await db.collection("users").doc(auth.currentUser!.uid).set(
//           updatedUser.toJson(),
//         );
//         await getUserDetails();

//     } catch(ex){
//       print(ex);
//     }
//     isLoading.value = false;
//   }

//   Future<String> uploadFileToFirebase(String imagePath) async {
//     final path = "files/${imagePath}";
//     final file = File(imagePath!);
//     if (imagePath != "") {
//       try {
//         final ref = FirebaseStorage.instance.ref().child(path).putFile(file);
//         final uploadTask = await ref.whenComplete(() {});
//         final downaloadImageUrl = await uploadTask.ref.getDownloadURL();
//         print(downaloadImageUrl);
//         return downaloadImageUrl;
//       } catch (ex) {
//         print(ex);
//         return "";
//       }
//     }
//     return "";
//   }
// }
