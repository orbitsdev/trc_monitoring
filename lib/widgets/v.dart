

import 'package:flutter/material.dart';

class V extends StatelessWidget {

  final double height;
  const V(this.height, {super.key});
  
  @override
  Widget build(BuildContext context){
    return SizedBox(
      height:height,
    );
  }
}
