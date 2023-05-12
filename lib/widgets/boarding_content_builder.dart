

import 'package:flutter/material.dart';
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
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.10, right: 16, left: 16,top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment : MainAxisAlignment.center,
            children: [                
              V(MediaQuery.of(context).size.height * 0.10),
             SvgPicture.asset(
                height:MediaQuery.of(context).size.height * 0.40,
              'assets/images/sentiment.svg',
            ),
              Text(capitalize(boarding.header), style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold )),
              const V(20),
              Text(boarding.body, style: bodyText.copyWith(
                color: AppColor.fontColor1,
              )),
            ],
            
          ),
        ),
      ),
    );  
  }

  
}
