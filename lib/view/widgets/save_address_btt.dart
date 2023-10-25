import 'package:flutter/material.dart';
import 'package:food/view/utils/dimensions.dart';

class SaveButt extends StatelessWidget {
  final VoidCallback? OnPressed;
  final String bttText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double radius;
  final IconData? icon;

  const SaveButt(
      {super.key,
      this.OnPressed,
      required this.bttText,
      this.transparent = false,
      this.margin,
      this.height,
      this.width = 280,
      this.radius = 5,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _floatbutton = TextButton.styleFrom(
      backgroundColor: OnPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(Dimensions.screenwidth, 50),
      padding: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimensions.screenwidth,
        height: height ?? 50,
        child: TextButton(
            onPressed: OnPressed,
            style: _floatbutton,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null
                    ? Padding(
                        padding: EdgeInsets.only(right: Dimensions.width10 / 2),
                        child: Icon(
                          icon,
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                        ),
                      )
                    : SizedBox(),
                Text(
                  bttText,
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    color: transparent
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).cardColor,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
