

import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/ChatController.dart';
import 'package:chat_app101/Controller/ContactController.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Pages/Chat/ChatPage.dart';
import 'package:chat_app101/Pages/ContactPage/Widget/ContactSearch.dart';
import 'package:chat_app101/Pages/ContactPage/Widget/NewContactTile.dart';
import 'package:chat_app101/Pages/Groups/NewGroup/NewGroup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Home/Widget/ChatTile.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    ContactController contactController =Get.put(ContactController());
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select contact",
        ),
        actions: [
          Obx(() => IconButton(
            onPressed: () {
              isSearchEnable.value = !isSearchEnable.value;
            }, 
            icon: isSearchEnable.value ? const Icon(Icons.close) : const Icon(Icons.search)

            ),)

            ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
           children: [
            Column(
              children: [
                Obx(() => isSearchEnable.value ? const ContactSearch() : const SizedBox(),),
                const SizedBox(
                  height: 10,
                ),
                NewContactTile(
                  btnName: "New contact",
                  icon: Icons.person_add,
                  ontap: () {},
                ),
                const SizedBox(
                  height: 20,
                ),
                NewContactTile(
                  btnName: "New Group",
                  icon: Icons.person_add,
                  ontap: () {
                    Get.to(const NewGroup());
                  },
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Text("contact on Sampark"),
                  ],
                ),
                const SizedBox(height: 10,),
                Obx(() => Column(
                  children: contactController.userList
                  .map(
                    (e) =>  InkWell(
                      onTap: () {
                        // Get.toNamed("/chatPage");
                        // String roomID =chatController.getRoomId(e.id!);
                        // print(roomID);
                        Get.to(ChatPage
                        (userModel: e)
                        );
                      },
                      child: Chattile(
                        imageUrl: e.profileImage ?? AssetsImage.defaultProfileUrl,
                        name: e.name ?? "User",
                        lastChat: e.About ?? "hey there",
                        lastTime: 
                            e.email == 
                            profileController.currentUser.value.email
                             
                        ? "You" : 
                        "10:00",
                      ),
                    ),
                    
                  )
                  .toList(),
               ),
             )
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
