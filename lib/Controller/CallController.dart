
import 'package:chat_app101/Model/UserModel.dart';
import 'package:chat_app101/Model/audioCall.dart';
import 'package:chat_app101/Pages/CallPage/AudioCallPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallController extends GetxController{
  final db  = FirebaseFirestore.instance;
  final auth =FirebaseAuth.instance;
  final uuid = const Uuid().v4();

  @override
  void onInit(){
    super.onInit();


    getCallsNotification().listen((List<AudioCallModel> callList){

      if (callList.isNotEmpty){
        var callData = callList[0];
        Get.snackbar(
          duration: const Duration( days: 1 ),
          isDismissible: false,
          icon : const Icon(Icons.call),
          backgroundColor: Colors.grey,
          onTap: (snack){
            Get.to(AudioCallPage(target: UserModel(
              id: callData.callerUid,
              name: callData.callerName,
              email: callData.callerEmail,
              profileImage: callData.callerPic
              ),
              ),
              );
              Get.back();
          },
            callData.callerName!,
            "Incoming call",
             mainButton: TextButton(
        onPressed: 
        (){
          endcall(callData);
          Get.back();
          }, 
          child: const Text("End call")));
      }
    });
  }

  Future <void> callAction(  UserModel receiver, UserModel caller,String type ) async{

      String id = uuid;
      String nowTime = DateFormat('hh:mm a').format(DateTime.now());
      var newcall = AudioCallModel(
        id:id,
        callerName: caller.name,
        callerEmail: caller.email,
        callerPic: caller.profileImage,
        callerUid: caller.id,
        receiverName: receiver.name,
        receiverPic: receiver.profileImage,
        receiverUid: receiver.id,
        receiverEmail: receiver.email,
        status: "dialing",
        type: type,
        time: nowTime,
        timestamp: DateTime.now().toString(),
      );


      try{
        await db
          .collection("notification")
          .doc(receiver.id ) 
          .collection("call")
          .doc(id)
          .set(newcall.toJson());
        await db 
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("calls")
          .doc(id)
          .set(newcall.toJson());

        await db 
          .collection("users")
          .doc(receiver.id)
          .collection("calls")
          .doc(id)
          .set(newcall.toJson());    
          Future.delayed(const Duration(minutes: 1),(){
            endcall(newcall);
          });      
      }
      catch(e){
        print (e);

      }


  }
    
    
  Stream<List<AudioCallModel>> getCallsNotification() {
      return FirebaseFirestore.instance
        .collection("notification")
        .doc(auth.currentUser!.uid)
        .collection("call")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AudioCallModel.fromJson(doc.data()))
            .toList());

    } 


  Future <void> endcall(AudioCallModel call) async {

    try {
      await db
        .collection("notification")
        .doc(call.receiverUid)
        .collection("call")
        .doc(call.id)
        .delete();

    } catch (e){
      print(e);
    }
  }
}