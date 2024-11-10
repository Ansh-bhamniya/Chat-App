import 'package:chat_app101/Model/UserModel.dart';
import 'package:chat_app101/Pages/Auth/AuthPage.dart';
import 'package:chat_app101/Pages/ContactPage/ContactPage.dart';
import 'package:chat_app101/Pages/Home/HomePage.dart';
import 'package:chat_app101/Pages/UserProfile/ProfilePage.dart';
import 'package:chat_app101/Pages/UserProfile/Widgets/UpdateProfile.dart';
import 'package:get/get.dart';

var pagePath =[
  GetPage(
    name: "/authPage",
    page: () => const AuthPage(),
    transition: Transition.rightToLeft,
  ),
    GetPage(
    name: "/homePage",
    page: () => const HomePage(),
    transition: Transition.rightToLeft,
  ),
  //   GetPage(
  //   name: "/chatPage",
  //   page: () => ChatPage(),
  //   transition: Transition.rightToLeft,
  // ),  
    GetPage( 
    name: "/profilePage",
    page: () => UserProfilePage(userModel: Get.arguments as UserModel),
    transition: Transition.rightToLeft,
  ),
    GetPage( 
    name: "/contactPage",
    page: () => const ContactPage(),
    transition: Transition.rightToLeft,
  ),      
    GetPage(
    name: "/updateProfile",
    page: () => const UpdateProfile(),
    transition: Transition.rightToLeft,
  ),    




];