


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trcmapping/database/boarding_seeder.dart';
import 'package:trcmapping/utils/themes/ap_constants.dart';
import 'package:trcmapping/utils/themes/app_color.dart';
import 'package:trcmapping/widgets/boarding_content_builder.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({ Key? key }) : super(key: key);

  @override
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
    final _pagecontroler = PageController();
     bool isLastIndex = false;

  @override
  void dispose() {

    _pagecontroler.dispose();
    super.dispose();
  }
   void next() async {
      if (!isLastIndex){
        _pagecontroler.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
      }else{
        // SharedPreferencesManager.setShowOnBoarding(true);
        // Get.off(()=> const HomeScreen());
      }
  }
  
  void skip(){
   _pagecontroler.animateToPage(boardingContent.length - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:PageView.builder(
        onPageChanged: (index){
          setState(() {
            isLastIndex = index == boardingContent.length - 1;
          });
        },
        physics: const ClampingScrollPhysics(),
        controller: _pagecontroler,
        itemCount: boardingContent.length,
        itemBuilder: (context,index) => BoardingContentBuilder(boarding: boardingContent[index]),
      ),
      bottomSheet: Container(
        
        width:double.infinity,
        padding: EdgeInsets.all(padding),
        constraints:  BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.10,
        ),
        decoration: const BoxDecoration(
          color:Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(!isLastIndex)TextButton(onPressed: skip, child: const Text('Skip', style: TextStyle(color:AppColor.fontColor1))).animate().fadeIn(),
            if(!isLastIndex)  SmoothPageIndicator(
                  onDotClicked: (index) => _pagecontroler.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                controller: _pagecontroler,
                count: boardingContent.length,
                effect:  const WormEffect(
                  spacing: 12,
                  activeDotColor: AppColor.lightBlue,
                  dotColor : AppColor.dotColor,
                
                  dotHeight: 10,
                  dotWidth: 10,

                ),
              ).animate().fadeIn(),
          if(!isLastIndex) ElevatedButton(
               style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24,),
               ),
              onPressed: next, child:  Text( isLastIndex ? 'Continue'.toUpperCase() : 'Next').animate().fadeIn()),
          if(isLastIndex) Expanded(
            child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24,),
                 ),
                onPressed: next, child: const  Text('Get Started')).animate().fadeIn(),
          )
          ],
        ),
      ),
    );
  }
}