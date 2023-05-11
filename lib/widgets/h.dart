

import 'package:flutter/material.dart';

class H extends StatelessWidget {

  final double width;

  const H(this.width, {super.key});
  @override
  Widget build(BuildContext context){
    return   SizedBox(
        width: width ,
    );
  }

  
}