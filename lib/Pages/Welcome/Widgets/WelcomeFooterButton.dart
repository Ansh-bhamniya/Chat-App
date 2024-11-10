import 'package:chat_app101/Config/Images.dart';
import 'package:chat_app101/Config/Stings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeFooterButton extends StatelessWidget {
  const WelcomeFooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
                    SlideAction(
              onSubmit: (){
                Get.offAllNamed("/authPage");
                return null;
              },
              sliderButtonIcon: SizedBox(
                width: 25,
                height:25,
                child: SvgPicture.asset(
                  AssetsImage.connectSVG,
                  width: 25,
                ),
              ),
              submittedIcon: SvgPicture.asset(
                AssetsImage.connectSVG,
                width: 25,),
              text: WelcomePageString.slideToStart,
              textStyle: Theme.of(context).textTheme.labelLarge,  
               innerColor: Theme.of(context).colorScheme.primary,
              outerColor: Theme.of(context).colorScheme.primaryContainer,
            ),
        
      ],
    );
  }
}