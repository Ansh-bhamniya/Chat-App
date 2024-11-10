import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/GroupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Selectedmemberlist extends StatelessWidget {
  const Selectedmemberlist({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return           Obx(()=>  Row(children: groupController.groupMember.map((e) => 
          Stack(
            children: [
            
            Container(
            margin: const EdgeInsets.all(10),
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.network(e.profileImage ?? AssetsImage.defaultProfileUrl)),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: (){
                groupController.groupMember.remove(e);
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  
                  borderRadius: BorderRadius.circular(50),
                  
                ),
                child:  
                const Icon(Icons.close,
                color: Colors.black,
                size: 30,), 
                
                
                 ),
            ),
          ),
            ],
          )

          ).toList()),);
  }
}