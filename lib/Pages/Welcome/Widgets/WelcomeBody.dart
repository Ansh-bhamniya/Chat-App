import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Config/Stings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                    Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
  
              Image.asset(AssetsImage.boyPic),
              SvgPicture.asset(AssetsImage.connectSVG),
              Image.asset(AssetsImage.girlPic),
              

            ],
            ),
            const SizedBox(height: 30),

            Text(WelcomePageString.nowYourAre, style: Theme.of(context).textTheme.headlineMedium,),
            Text(WelcomePageString.connected, style: Theme.of(context).textTheme.headlineLarge,),          
            const SizedBox(height:10),
            
            Text(WelcomePageString.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
            ),
      ],
    );
  }
}