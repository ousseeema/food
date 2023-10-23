// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:food/view/utils/dimensions.dart';

// ignore: camel_case_types
class bigtext extends StatelessWidget {
   Color? color;
   final String text;
   double size ; 
   TextOverflow overflow ;
   bigtext( {super.key,  this.color=const Color(0xFF332d2b), required this.text, this.overflow=TextOverflow.ellipsis,this.size=0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(color: color,fontWeight: FontWeight.w400, fontSize: size==0? Dimensions.font20 : size, fontFamily: "Roboto")
    );
  }
}