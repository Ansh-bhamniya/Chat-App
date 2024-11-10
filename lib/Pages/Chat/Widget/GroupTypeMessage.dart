import 'package:chat_app101/Controller/ChatController.dart';
import 'package:chat_app101/Controller/ImagePicker.dart';
import 'package:chat_app101/Model/GroupModel.dart';
import 'package:chat_app101/Widget/ImagepickerBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Config/Images.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  final VoidCallback onTap;
  const GroupTypeMessage({super.key, required this.groupModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    RxString imagePath  = "".obs;
    ImagePickerController imagePickerController = 
      Get.put(ImagePickerController());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      width: MediaQuery.of(context).size.width * 0.92,
      height: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),

      child: Row(
        children: [
          const SizedBox( width: 10),
          SizedBox(
                    height: 30,
                    width: 30,
                    child: SvgPicture.asset(AssetsImage.chatEmojiSvg),
                  ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
              },
              controller: messageController,
              decoration: const InputDecoration(
                filled: false,
                hintText: "Type message...",
                contentPadding: EdgeInsets.only(left: 15),
              ),
            ),
          ),


Obx(()=>  chatController.SelectedImagePath.value =="" ?
            InkWell(
            onTap: () {

              ImagePickerBottomsheet(context, imagePath, imagePickerController);
            },
            child: SizedBox(
              width: 40,
              height: 30,
              child: SvgPicture.asset(AssetsImage.chattGallarySvg),
            ),
          ): const SizedBox(),
          ),


          // Only wrap the mic/send icon in Obx to prevent rebuilding the TextField
          Obx(
            () => message.value != "" || chatController.SelectedImagePath.value  != ""
                ? InkWell(
                    onTap: () {
                      // if (messageController.text.isNotEmpty || chatController.SelectedImageoPath.value.isNotEmpty) {
                      //   chatController.sendMessage(
                      //       groupModel.id!, messageController.text, groupModel);
                      //   messageController.clear();
                      //   message.value = ""; // Clear message after sending
                      // }
                    },
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: chatController.isLoading.value
                    ? const CircularProgressIndicator()
                    : SvgPicture.asset(AssetsImage.chatSendSvg,
                    width: 25 
                    ),
                    ),
                  )
                
                
                : SizedBox(
                    height: 30,
                    width: 60,
                    child: SvgPicture.asset(
                      AssetsImage.chatMicSvg,)
                  ),
          ),
        ],
      ),
    );
  }

  


  }

