import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/GroupController.dart';
import 'package:chat_app101/Pages/Groupchat/GroupChat.dart';
import 'package:chat_app101/Pages/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx( 
      ()=> ListView(
      
      children: groupController.groupList
      .map(
        (group) => InkWell(
          onTap: (){
            Get.to(
              GroupChatPage
            (groupModel: group));

          },
          child: Chattile(
            imageUrl: group.profileUrl == "" ?
            AssetsImage.defaultProfileUrl
            : group.profileUrl!,
            name: group.name!, 
            lastChat: "Group Created",
            lastTime: "Just Now",
            ),
        ),
      )
      .toList(),


    )
    );
  }
}

// import 'package:chat_app101/Config/Images.dart';
// import 'package:chat_app101/Controller/GroupController.dart';
// import 'package:chat_app101/Pages/Home/Widget/ChatTile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// class GroupPage extends StatelessWidget {
//   const GroupPage({super.key,});

//   @override
//   Widget build(BuildContext context) {
//     GroupController groupController = Get.put(GroupController());
//     return Obx(
//       () {
//       if (groupController.isLoading.value) {
//         return Center(child: CircularProgressIndicator()); // Show loading indicator
//       }

//       return ListView(
//         children: groupController.groupList.map((group) {
//           return InkWell(
//             onTap: () {
//               // Handle tap event
//             },
//             child: Chattile(
//               imageUrl: group.profileUrl == ""
//                   ? AssetsImage.defaultProfileUrl
//                   : group.profileUrl!,
//               name: group.name!,
//               lastChat: "Group Created",
//               lastTime: "Just Now",
//             ),
//           );
//         }).toList(),
//       );
//     });
//   }
//}
