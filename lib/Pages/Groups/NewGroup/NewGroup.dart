// import 'package:chat_app101/Config/Images.dart';
// import 'package:chat_app101/Controller/ContactController.dart';
// import 'package:chat_app101/Pages/Home/Widget/ChatTile.dart';
// import 'package:flutter/material.dart';

// class NewGroup extends StatelessWidget {
//   const NewGroup({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: StreamBuilder(
//         stream: contactController.getContacts(),
//         builder: (context,snapshot)
//         {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text("Error: ${snapshot.error}"),
//                         );
//                       }
//                       if (snapshot.data == null) {
//                         return const Center(
//                           child: Text("No messages"),
//                         );
//                       } else {
//                         return ListView.builder(
                          
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             return Chattile(
//                               imageUrl: snapshot.data![index].profileImage ?? AssetsImage.defaultProfileUrl, 
//                               name: snapshot.data![index].name!, 
//                               lastChat: snapshot.data![index].About! ?? "", 
//                               lastTime: "",
//                               );
//                           }
                        
//                             );
      
//                           }
//         }
//                         ),
//     );
//         }
//         }
      

import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/ContactController.dart';
import 'package:chat_app101/Controller/GroupController.dart';
import 'package:chat_app101/Pages/Groups/NewGroup/Grouptitle.dart';
import 'package:chat_app101/Pages/Groups/NewGroup/SelectedMemberlist.dart';
import 'package:chat_app101/Pages/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
   
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
      ),
      floatingActionButton: 
      Obx( 
        ()=> FloatingActionButton(
        backgroundColor: groupController.groupMember.isEmpty
        ? Colors.grey : Theme.of(context).colorScheme.primary,
        onPressed: (){
          if(groupController.groupMember.isEmpty){
            Get.snackbar("Error", "Please select atleast one member");
          }else {
            Get.to(const GroupTitle());
             
          }
          
      }, child: Icon(Icons.arrow_forward, 
      color: Theme.of(context).colorScheme.onSurface,),
      ),
      ),
      body: Column(
        children: [
          const Selectedmemberlist(),


          const SizedBox( height: 10,),
          Row(
            children: [
              Text("contact on sampark", style: Theme.of(context).textTheme.labelMedium),
              ],
            ),
            const SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder(
              stream: ContactController().getContacts(),
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
                }
            
                return ListView.builder(
 
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var contact = snapshot.data![index];
                    
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    onTap: (){
                      groupController.selectMember(snapshot.data![index]);
                    },
        
                      child: Chattile(
                        imageUrl: snapshot.data![index].profileImage ?? AssetsImage.defaultProfileUrl, // Access imageUrl from snapshot
                        name: snapshot.data![index].name ?? "Unknown", // Safely access name
                        lastChat: snapshot.data![index].About ?? "", // Access about field
                        lastTime: "", // Add logic to handle the time if needed
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
