import 'package:flutter/material.dart';
import 'package:food/view/widgets/smalltext.dart';

import '../utils/appcolor.dart';
import '../utils/dimensions.dart';
import 'bigtext.dart';
import 'icon_text_widget.dart';

class appcolumn extends StatelessWidget {
  final String text;
  const  appcolumn({super.key, required this.text, });

  @override
  Widget build(BuildContext context) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bigtext(text: text, size: Dimensions.font26,),
                  SizedBox(
                    height: Dimensions.heigth10,
                  ),
                  Row(
                    children: [
                      Wrap(
                          children: List.generate(
                              5,
                              (index) => const Icon(
                                    Icons.star,
                                    size: 15,
                                    color: AppColor.maincolor,
                                  ))),
                      const SizedBox(
                        width: 10,
                      ),
                      smalltext(text: "4.5"),
                      const SizedBox(
                        width: 10,
                      ),
                      smalltext(text: "1287"),
                      const SizedBox(
                        width: 10,
                      ),
                      smalltext(
                        text: "comments",
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.heigth20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      iconandtextwidget(
                          icon: Icons.circle_sharp,
                          text: "Normal ",
                          iconcolor: AppColor.iconcolor1),
                      iconandtextwidget(
                          icon: Icons.location_on,
                          text: "1.7Km ",
                          iconcolor: AppColor.maincolor),
                      iconandtextwidget(
                          icon: Icons.access_time_rounded,
                          text: "32min ",
                          iconcolor: AppColor.iconcolor2)
                    ],
                  )
                ],
              );
  }
}