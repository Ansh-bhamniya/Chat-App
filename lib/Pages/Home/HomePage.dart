import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Config/Stings.dart';
import 'package:chat_app101/Controller/ImagePicker.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:chat_app101/Controller/statusController.dart';
import 'package:chat_app101/Pages/CallHistory/CallHistory.dart';
import 'package:chat_app101/Pages/Groups/GroupsPage.dart';
import 'package:chat_app101/Pages/Home/Widget/ChatList.dart';
import 'package:chat_app101/Pages/Home/Widget/TabBar.dart';
import 'package:chat_app101/Pages/ProfilePage/UserProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ImagePickerController imagePickerController = Get.put(ImagePickerController());
    StatusController statusController = Get.put(StatusController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            AssetsImage.appIconSVG,
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppString.appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              imagePickerController.pickImage(ImageSource.gallery);
              // Your action here
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              // Get.toNamed("/profilePage");
              await profileController.getUserDetails(); 
              Get.to(const ProfilePage());
              // Your action here
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
        bottom: myTabBar(tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("contactPage");
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TabBarView(
          controller: tabController,
          children: const [
            ChatList(),
            
            // group section
            GroupPage(),
            
            CallHistory(),
          ],
        ),
      ),
    );
  }
}
