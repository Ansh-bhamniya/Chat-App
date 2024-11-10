import 'package:chat_app101/Config/PagePath.dart';
import 'package:chat_app101/Config/Theme.dart';
import 'package:chat_app101/Controller/CallController.dart';
import 'package:chat_app101/Pages/SplashPage/SplashPage.dart';
import 'package:chat_app101/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CallController callController = Get.put(CallController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      title: 'Sampark',
      theme : lightTheme,
      getPages: pagePath,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashPage(),
      // home: UserProfilePage(),
      

    );
  }

  
}
