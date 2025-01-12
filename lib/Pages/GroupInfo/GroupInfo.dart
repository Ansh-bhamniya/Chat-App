import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Model/GroupModel.dart';
import 'package:chat_app101/Pages/GroupInfo/GroupMemberInfo.dart';
import 'package:chat_app101/Pages/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';


class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [
          IconButton(onPressed: (){},
          icon: const Icon(Icons.more_vert,
          ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            GroupMemberInfo(
              groupId: groupModel.id!,
              profileImage: groupModel.profileUrl == "" 
            ? AssetsImage.defaultProfileUrl
            : groupModel.profileUrl!,
            userName: groupModel.name!, 
            userEmail: groupModel.description ?? "No description available"
            ),
            const SizedBox( height: 12),
            Text("Members",style: Theme.of(context).textTheme.labelMedium),
            const SizedBox( height: 12),
            Column(children: groupModel.members!.
            map((member) => Chattile
            (imageUrl: member.profileImage ?? AssetsImage.defaultProfileUrl,
            name: member.name!,
            lastChat: member.email!,
            lastTime: member.role == "admin" ? "Admin" : "User",
             ),
            )
            
            .toList()),
            ],
        ),
      ),
    );
  }
}
