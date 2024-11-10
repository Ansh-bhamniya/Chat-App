import 'package:chat_app101/Controller/GroupController.dart';
import 'package:chat_app101/Model/UserModel.dart';
import 'package:chat_app101/Controller/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupMemberInfo extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userEmail;
  final String groupId;

  const GroupMemberInfo({
    super.key,
    required this.profileImage,
    required this.userName,
    required this.userEmail,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    GroupController groupController = Get.put(GroupController());

    return Container(
      height: 300, // Increase the height as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20), // Add space between the top of the container and the image
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userEmail,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(context, Icons.phone, "Call", Colors.green),
                    const SizedBox(width: 10), // Space between buttons
                    _buildActionButton(context, Icons.video_call, "Video", Colors.blue),
                    const SizedBox(width: 10), // Space between buttons
                    _buildActionButton(
                      context,
                      Icons.group_add,
                      "Add",
                      Colors.white,
                      onTap: () {
                        // Creating a new member using UserModel
                        var newMember = UserModel(
                          email: "vikki@gmail.com",
                          name: "vikki",
                          profileImage: "",
                          role: "admin",
                        );
                        

                        // Add this new member to the group
                        groupController.addMemberToGroup(groupId, newMember);

                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5), // Adjust padding if needed
      child: InkWell(
        onTap: onTap, // Adding the onTap function
        child: Container(
          padding: const EdgeInsets.all(8), // Decrease padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Slightly smaller radius
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Adjusts the button size to fit the content
            children: [
              Icon(icon, size: 18, color: color), // Decrease icon size
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 14, // Decrease font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'dart:ffi';

// import 'package:chat_app101/Config/Images.dart';
// import 'package:chat_app101/Controller/ProfileController.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class GroupMemberInfo extends StatelessWidget {
//   final String profileImage;
//   final String userName;
//   final String userEmail;
//   final String groupId;
  
//   const GroupMemberInfo
//   ({super.key, required this.profileImage, required this.userName,required this.userEmail, required this.groupId});


//   @override
//   Widget build(BuildContext context) {
//     ProfileController profileController = Get.put(ProfileController());
    



//     return Container(
//       height: 300, // Increase the height as needed
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Theme.of(context).colorScheme.primaryContainer,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 SizedBox(height: 20), // Add space between the top of the container and the image
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
                      
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100),

//                         child: Image.network(
//                           profileImage,
//                           fit: BoxFit.cover,)
//                         ),
//                         ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                          Text(
//                         userName,
//                         style: Theme.of(context).textTheme.bodyLarge,
//                       ),
                    
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       userEmail,
//                       style: Theme.of(context).textTheme.labelLarge,
//                     )
                    

//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildActionButton(context, Icons.phone, "Call", Colors.green),
//                     SizedBox(width: 10), // Space between buttons
//                     _buildActionButton(context, Icons.video_call, "Video", Colors.blue),
//                     SizedBox(width: 10), // Space between buttons
//                     _buildActionButton(context, Icons.group_add, "Add", Colors.white),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton(BuildContext context, IconData icon, String label, Color color) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 5), // Adjust padding if needed
//       child: Container(
//         padding: EdgeInsets.all(8), // Decrease padding
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8), // Slightly smaller radius
//           color: Theme.of(context).colorScheme.background,
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min, // Adjusts the button size to fit the content
//           children: [
//             Icon(icon, size: 18, color: color), // Decrease icon size
//             SizedBox(width: 5),
//             Text(
//               label,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 14, // Decrease font size
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
