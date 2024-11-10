// Ensure this import is correct
import 'package:chat_app101/Pages/Welcome/Widgets/WelcomeBody.dart';
import 'package:chat_app101/Pages/Welcome/Widgets/WelcomeFooterButton.dart';
import 'package:chat_app101/Pages/Welcome/Widgets/WelcomeHeading.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WelcomeHeading(),

            WelcomeBody(),

            WelcomeFooterButton(),



            ],

        ),
      ),
    );
  }
}
