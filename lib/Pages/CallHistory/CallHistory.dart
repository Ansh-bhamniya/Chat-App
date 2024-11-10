import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/ChatController.dart';
import 'package:chat_app101/Pages/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder(
      stream: chatController.getCalls(),
      builder: (context, snapshot) { // Changed 'Snapshot' to 'snapshot'
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              DateTime timestamp = DateTime.parse(snapshot.data![index].timestamp!);
              String formattedTime = DateFormat("hh:mm a").format(timestamp);
              return Chattile(
                imageUrl: snapshot.data![index].callerPic ?? AssetsImage.defaultProfileUrl,
                name: snapshot.data![index].callerName ?? "...",
                lastChat: snapshot.data![index].type ?? "...",
                lastTime: formattedTime,
              );
            },
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading call history."));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}