import 'package:chat_app101/Controller/GroupController.dart';
import 'package:chat_app101/Controller/ImagePicker.dart';
import 'package:chat_app101/Model/GroupModel.dart';
import 'package:chat_app101/Widget/ImagepickerBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../Config/Images.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
   const GroupTypeMessage({super.key, required this.groupModel});
  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    RxString imagePath ="".obs;
    ImagePickerController imagePickerController = Get.put(ImagePickerController());
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


          Obx(()=>  groupController.SelectedImagePath.value =="" ?
            InkWell(
            onTap: () {

              ImagePickerBottomsheet(
                context, 
                groupController.SelectedImagePath,
                imagePickerController
                );
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
            () => message.value != "" || groupController.SelectedImagePath.value  != ""
                ? InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                    onTap: () {
                      groupController.sendGroupMessage(
                        messageController.text,
                        groupModel.id!,
                        "",
                         );

                        messageController.clear();
                        message.value = ""; // Clear message after sending
                      
                    },
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: groupController.isLoading.value
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

