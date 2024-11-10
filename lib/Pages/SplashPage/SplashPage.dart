import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Controller/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController =Get.put(SplashController());
    return Scaffold(

      body: Center(child: SvgPicture.asset(AssetsImage.appIconSVG),
      
      ),
    );
  }
}