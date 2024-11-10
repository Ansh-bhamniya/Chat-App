import 'package:chat_app101/Config/Stings.dart';
import 'package:chat_app101/Controller/ChatController.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatelessWidget {
  final UserModel target;
  const AudioCallPage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
   ProfileController profileController = Get.put(ProfileController());
  ChatController chatController = Get.put(ChatController());
  var callId = chatController.getRoomId(target.id!);
  return ZegoUIKitPrebuiltCall(
    appID: ZegoCloudConfig.appId, 
    appSign: ZegoCloudConfig.appSing,
    userID: profileController.currentUser.value.id ??  "root",
    userName: profileController.currentUser.value.name ??  "root",
    callID: callId,
    config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
  );
}
}