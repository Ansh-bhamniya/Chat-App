

// import 'package:chat_app101/Controller/AuthController.dart';
// import 'package:chat_app101/Model/UserModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// class Dbcontroller extends GetxController{
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
//       await db.collection("users").get().then(
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

import 'package:chat_app101/Model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DbController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserList();
  }


  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      await db.collection("users").get().then(
        (value)=> {
          userList.value = value.docs
          .map(
            (e) => UserModel.fromJson(e.data()),
            )
            .toList(),
        },
      );

  } catch (ex){
    print(ex);
  }
  isLoading.value = false;
}

Stream<List<UserModel>> get userStream {
  return db.collection("users").snapshots().map(
  (event) => event.docs
  .map(
    (e)=> UserModel.fromJson(e.data())
  )
  .toList(),
  );
}


}










//   Future<void> getUserList() async {
//     isLoading.value = true;
//     try {
//       QuerySnapshot snapshot = await db.collection("users").get();
//       userList.value = snapshot.docs
//           .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
//           .toList();
//     } catch (ex) {
//       print(ex);
//     }
//     isLoading.value = false;
//   }
// }
