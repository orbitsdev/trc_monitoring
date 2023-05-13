

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:trcmapping/database/boarding_seeder.dart';
import 'package:trcmapping/helpers/asset.dart';
import 'package:trcmapping/utils/themes/ap_constants.dart';
import 'package:trcmapping/utils/themes/app_color.dart';
import 'package:trcmapping/widgets/v.dart';

class BoardingContentBuilder extends StatelessWidget {


   final Boarding boarding;
  const BoardingContentBuilder({
    Key? key,
    required this.boarding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  SafeArea(
      child: Container(
        color:Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10, right: 24, left: 24,top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment : MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.center,
            children: [                
              V(MediaQuery.of(context).size.height * 0.05),
             SvgPicture.asset(
                height:MediaQuery.of(context).size.height * 0.40,
              Asset.public('images/${boarding.image}'),
            ).animate().moveY(begin: -30, end: 0,curve: Curves.easeInOut, duration: const Duration(seconds: 1)).fadeIn(),
              const V(40),
              Text(capitalize(boarding.header), style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold ),  textAlign: TextAlign.center,).animate().moveX(begin: 20, end: 0,curve: Curves.easeInOut, duration: const Duration(milliseconds: 1300)).fadeIn(),
              const V(20),
              Text(boarding.body, style: bodyText.copyWith(
                color: AppColor.fontColor1,
                height: 1.5,
              ),
                textAlign: TextAlign.center,
              ).animate().moveY(begin: 30, end: 0,curve: Curves.easeInOut, duration: const Duration(seconds: 1)).fadeIn(),
            ],
            
          ),
        ),
      ),
    );  
  }

  
}
