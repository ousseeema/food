// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class smalltext extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  smalltext(
      {super.key,
      this.height = 1.2,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      this.size = 12});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    
        style: TextStyle(
            color: color, fontWeight: FontWeight.w400, fontSize: size));
  }
}
