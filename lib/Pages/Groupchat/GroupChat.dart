import 'dart:io';
import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/GroupController.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Model/ChatModel.dart';
import 'package:chat_app101/Model/GroupModel.dart';
import 'package:chat_app101/Pages/Chat/Widget/ChatBubble.dart';
import 'package:chat_app101/Pages/GroupInfo/GroupInfo.dart';
import 'package:chat_app101/Pages/Groupchat/GroupTypeMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class GroupChatPage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChatPage ({super.key, required this.groupModel});


  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ProfileController profileController = Get.put(ProfileController());
    
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            splashColor: Colors.transparent;
            highlightColor: Colors.transparent;

            // Get.to(UserProfilePage(
            //   userModel: userModel,
            // ));

          },
child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                groupModel.profileUrl == "" 
                ? AssetsImage.defaultProfileUrl 
                : groupModel.profileUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red); // Error widget
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Display image once loaded
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(), // Placeholder while loading
                    );
                  }
                },
              ),
            ),
          ),
        ),

        
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(GroupInfo(
              groupModel: groupModel,
            ));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(groupModel.name ?? "Group Name",
                      style: Theme.of(context).textTheme.bodyLarge),
                  Text("online", style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
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
                    stream: groupController.getGroupMessages(groupModel.id!),
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
                              isComing: snapshot.data![index].senderId !=
                                  profileController.currentUser.value.id,
                              status: chatMessage.readStatus ?? "unread",
                              time: formattedTime,
                            );
                          },
                        );
                      }
                    },
                  ),
                  Obx(() => ( groupController.SelectedImagePath.value!="") ?
                   Positioned(
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
                                File(groupController.SelectedImagePath.value)
                              ),
                              fit: BoxFit.contain,
                            ),
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(15)
                                                
                            ),
                            height: 500,
                          
                          ),
                          Positioned( right :0, child: IconButton(
                            onPressed: (){
                              groupController.SelectedImagePath.value ="";
                            }, icon: const Icon(Icons.close),),),
                        ],
                    )
                    )
                    
                    : Container(),
                    )

                ],
              ),
              
            ),
            // TypeMessage at the bottom
            GroupTypeMessage(
              groupModel: groupModel,
            ),
          ],
        ),
      ),
    );
  }
}
