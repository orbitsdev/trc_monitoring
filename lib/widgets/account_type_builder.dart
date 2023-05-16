




import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trcmapping/helpers/asset.dart';
import 'package:trcmapping/models/role.dart';
import 'package:trcmapping/utils/themes/app_color.dart';
import 'package:trcmapping/widgets/v.dart';

class AccountTypeBuilder extends StatelessWidget {

final Role role; 
  const AccountTypeBuilder({
    Key? key,
    required this.role,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Container(
      constraints: const  BoxConstraints(
        maxHeight : 200,
      ),
       padding: const EdgeInsets.all(10),
     decoration: BoxDecoration( 

     border: Border.all(
      color: role.isSelected ? AppColor.lightBlue: Colors.transparent,
      width: 2,
    ),
        
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
         if(role.isSelected) BoxShadow(
            color: AppColor.lightBlue.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
          // BoxShadow(
          //   color: AppColor.primary.withOpacity(0.2),
          //   offset: Offset(0, 4),
          //   blurRadius: 8,
          // ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              const V(8),
               ClipOval(
                 child: SvgPicture.asset(
                  width: 100,
                  height: 100,            
                  Asset.public('images/${role.image}'),
                  fit: BoxFit.cover,
                  ),
               ),
                const V(34),
              Expanded(child: Text(role.name, style: const TextStyle(fontSize: 18,fontWeight:FontWeight.bold, color:AppColor.darkblue))),
            ],
          ),
         if(role.isSelected) Positioned(
            top: -0,
            right: 0,
            child: ClipOval(
              child: Container(
                padding: const EdgeInsets.all(4),
                color:   AppColor.lightBlue,
                child: const Icon(Icons.check,  color: Colors.white, size: 12,),
              ),
            ))
        ],
      ),
    );
  }
}
