import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/ContactController.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Pages/Chat/ChatPage.dart';
import 'package:chat_app101/Pages/Home/Widget/Chattile.dart'; // Ensure Chattile is correctly imported
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());

    return RefreshIndicator(
      onRefresh: () {
        return contactController.getChatRoomList(); // Ensure this method exists in ContactController
      },
      child: Obx(
        () => ListView(
          children: contactController.chatRoomList
              .map(
                (e) => InkWell(
                  onTap: () {
                    Get.to(
                      ChatPage(
                        userModel: (e.receiver!.id ==
                                profileController.currentUser.value.id
                            ? e.sender
                            : e.receiver)!,
                      ),
                    );
                  },
                  child: Chattile( // Using Chattile here
                    imageUrl: (e.receiver!.id ==
                            profileController.currentUser.value.id
                        ? e.sender!.profileImage
                        : e.receiver!.profileImage) ??
                        AssetsImage.defaultProfileUrl,
                    name: (e.receiver!.id ==
                            profileController.currentUser.value.id
                        ? e.sender!.name
                        : e.receiver!.name)!,
                    lastChat: e.lastMessage ?? "Last Message", // Match Chattile property
                    lastTime: e.lastMessageTimestamp != null
                        ? e.lastMessageTimestamp!.toDate().toString() // Ensure lastMessageTimestamp is a Timestamp
                        : "Time not available",
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
