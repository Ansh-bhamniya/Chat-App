import 'dart:io';

import 'package:chat_app101/Controller/AuthController.dart';
import 'package:chat_app101/Controller/ImagePicker.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Widget/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key , });


  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController name =
        TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController email =
        TextEditingController(text: profileController.currentUser.value.email);
    TextEditingController phone = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    TextEditingController about =
        TextEditingController(text: profileController.currentUser.value.About);
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString imagePath = "".obs;
    AuthController authController = Get.put(AuthController());
       
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(onPressed: (){ authController.logoutUser();
          }, icon: const Icon(Icons.logout,
          ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 600,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(() => isEdit.value
                                    ? InkWell(
                                        onTap: () async {
                                          imagePath.value =
                                              await imagePickerController
                                                  .pickImage(ImageSource.gallery);


                                          print(
                                              "image picked${imagePath.value}");
                                        },
                                        child: Container(
                                          height: 170,
                                          width: 170,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: imagePath.value == ""
                                              ? const Icon(Icons.add)
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.file(
                                                    File(
                                                      imagePath.value,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      )
                                    : Container(
                                        height: 170,
                                        width: 170,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: 
                                        profileController.currentUser.value.profileImage  == "" || 
                                        profileController.currentUser.value.profileImage == null
                                            ? const Icon(Icons.image)
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(profileController.currentUser.value.profileImage!,
                                                fit: BoxFit.cover,)
                                              ),
                                      ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => TextField(
                                controller: name,
                                enabled: isEdit.value,
                                decoration: InputDecoration(
                                  filled: isEdit.value,
                                  // hintText: "ansh Bhamniya",
                                  prefixIcon: const Icon(Icons.person),
                                  labelText: "Name",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => TextField(
                                controller: about,
                                enabled: isEdit.value,
                                decoration: InputDecoration(
                                  filled: isEdit.value,
                                  // hintText: "How you doin",
                                  prefixIcon: const Icon(Icons.info),
                                  labelText: "About",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: email,
                              enabled: isEdit.value,
                              decoration: const InputDecoration(
                                filled: false,
                                // hintText: "ansh Bhamniya",
                                prefixIcon: Icon(Icons.alternate_email),
                                labelText: "Email",
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(
                              () => TextField(
                                controller: phone,
                                enabled: isEdit.value,
                                decoration: InputDecoration(
                                  filled: isEdit.value,
                                  // hintText: "ansh Bhamniya",
                                  prefixIcon: const Icon(Icons.phone),
                                  labelText: "Number",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => isEdit.value
                                      ? PrimaryButton(
                                          btnName: "Save",
                                          icon: Icons.save,
                                          onTap: ()async {
                                          await profileController.updateProfile(
                                              imagePath.value,
                                              name.text,
                                              about.text,
                                              phone.text,
                                              );                                            
                                            isEdit.value = false;
                                          })
                                      : PrimaryButton(
                                          btnName: "Edit",
                                          icon: Icons.edit,
                                          onTap: () {
                                            isEdit.value = true;
                                          }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
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
