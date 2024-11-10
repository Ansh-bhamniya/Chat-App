import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController with WidgetsBindingObserver {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this); // Observe app lifecycle events
  }

  @override
  void onClose() async {
    WidgetsBinding.instance.removeObserver(this); // Clean up observer when not needed
    await db.collection('users').doc(auth.currentUser!.uid).update({
    'status': 'Online',
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifecycleState: $state');

    if (auth.currentUser != null) {
      if (state == AppLifecycleState.resumed) {
        // When the app is resumed, mark the user as online
        await db.collection('users').doc(auth.currentUser!.uid).update({
          'status': 'Online',
        });
        print("User is Online");
      } else if (state == AppLifecycleState.paused) {
        // When the app is paused, mark the user as offline
        await db.collection('users').doc(auth.currentUser!.uid).update({
          'status': 'Offline',
        });
        print("User is Offline");
      }
    }
  }
}
