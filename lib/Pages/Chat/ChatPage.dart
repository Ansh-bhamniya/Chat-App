import 'dart:io';
import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/CallController.dart';
import 'package:chat_app101/Controller/ChatController.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Model/ChatModel.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:chat_app101/Pages/CallPage/AudioCallPage.dart';
import 'package:chat_app101/Pages/Chat/Widget/ChatBubble.dart';
import 'package:chat_app101/Pages/Chat/Widget/TypeMessage.dart';
import 'package:chat_app101/Pages/UserProfile/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    ProfileController profileController = Get.put(ProfileController());
    CallController callController = Get.put(CallController());

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(
              userModel: userModel,
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                userModel.profileImage ?? AssetsImage.defaultProfileUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(
              userModel: userModel,
            ));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userModel.name ?? "User",
                      style: Theme.of(context).textTheme.bodyLarge),
                  StreamBuilder(
                      stream: chatController.getStatus(userModel.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text(".......");
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data?.Status ?? "", // Handling potential null values
                            style: TextStyle(
                              fontSize: 12,
                              color: snapshot.data?.Status == "Online"
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          );
                        } else {
                          return const Text("Status not available");
                        }
                      })
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AudioCallPage(target: userModel));
              // Added the type argument to callAction
              callController.callAction(
                  userModel, profileController.currentUser.value, "audio");
            },
            icon: const Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 1, top: 1, left: 1, right: 1),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  StreamBuilder<List<ChatModel>>(
                    stream: chatController.getMessages(userModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error: ${snapshot.error}"),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("No messages"),
                        );
                      } else {
                        return ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            DateTime timestamp =
                                snapshot.data![index].timestamp!.toDate();
                            String formattedTime =
                                DateFormat('hh:mm a').format(timestamp);
                            var chatMessage = snapshot.data![index];
                            return ChatBubble(
                              message: chatMessage.message!,
                              imageUrl: chatMessage.imageUrl ?? "",
                              isComing: snapshot.data![index].receiverId ==
                                  profileController.currentUser.value.id,
                              status: chatMessage.readStatus ?? "unread",
                              time: formattedTime,
                            );
                          },
                        );
                      }
                    },
                  ),
                  Obx(
                    () => chatController.SelectedImagePath.value != ""
                        ? Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                          File(chatController.SelectedImagePath.value)),
                                      fit: BoxFit.contain,
                                    ),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 500,
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      chatController.SelectedImagePath.value = "";
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(), // Added null check for SelectedImagePath
                  ),
                ],
              ),
            ),
            // TypeMessage at the bottom
            TypeMessage(
              userModel: userModel,
            ),
          ],
        ),
      ),
    );
  }
}
