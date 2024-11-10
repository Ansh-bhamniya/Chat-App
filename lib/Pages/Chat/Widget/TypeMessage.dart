import 'package:chat_app101/Controller/ChatController.dart';
import 'package:chat_app101/Controller/ImagePicker.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Config/Images.dart';

class TypeMessage extends StatelessWidget {
  final UserModel userModel;
  const TypeMessage({super.key, required this.userModel, });

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    RxString message = "".obs;
    RxString SelectedImagePath = "".obs;

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

              ImagePickerBottomsheet(
                context,
                chatController.SelectedImagePath,
                imagePickerController);
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
                      if (messageController.text.isNotEmpty || chatController.SelectedImagePath.value.isNotEmpty) {
                        chatController.sendMessage(
                            userModel.id!, messageController.text, userModel);
                        messageController.clear();
                        message.value = ""; // Clear message after sending
                      }
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

  Future<dynamic> ImagePickerBottomsheet(BuildContext context, RxString imagePath, ImagePickerController imagePickerController) {
    return Get.bottomSheet(
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                      imagePath.value = await 
                      imagePickerController.pickImage(ImageSource.camera);  
                      Get.back();                     

                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Icon(Icons.camera , size: 30,),
                      ),
                    ),
                    InkWell(
                      onTap: () async{
                      imagePath.value = await 
                      imagePickerController.pickImage(ImageSource.gallery);
                        
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Icon(Icons.photo , size: 30,),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: const Icon(Icons.play_arrow , size: 30,),
                      ),
                    )
                  ],
                ),
              )
            );
  }
}
