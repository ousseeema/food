import 'package:flutter/material.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/smalltext.dart';

class iconandtextwidget extends StatelessWidget {
  final IconData icon;
  final String text;
 
  final Color iconcolor;
  const iconandtextwidget(
      {super.key,
      required this.icon,
      required this.text,
      
      required this.iconcolor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon , color: iconcolor,size: Dimensions.iconsize24,),
        const SizedBox(width: 5,),
        smalltext(text: text),
      ]

    );
  }
}
