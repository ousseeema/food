import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class nodata_page extends StatelessWidget {
  final String text;
  final String imgpath;
  const nodata_page(
      {super.key, required this.text, this.imgpath = "img/nodata1.png"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          imgpath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0175,
              color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center  ,
        )
      ],
    );
  }
}
