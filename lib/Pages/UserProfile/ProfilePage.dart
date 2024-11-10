import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/AuthController.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:chat_app101/Pages/UserProfile/Widgets/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final UserModel userModel;
  const UserProfilePage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Get.toNamed("/updateProfilePage");
        //       },
        //       icon: Icon(Icons.edit))
        // ],
      ),
      body: Padding(

        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            LoginUserInfo(
              profileImage : 
                userModel.profileImage ?? AssetsImage.defaultProfileUrl,
              userName: userModel.name ?? "User",
              userEmail: userModel.email ?? "",
            ),
            const Spacer(),
            // ElevatedButton(onPressed: () {
            //   authController.logoutUser();
            // }, child: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
