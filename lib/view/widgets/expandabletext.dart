import 'package:flutter/material.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/smalltext.dart';

class expandableText extends StatefulWidget {
  final String text;

  const expandableText({super.key, required this.text});

  @override
  State<expandableText> createState() => _expandableTextState();
}

class _expandableTextState extends State<expandableText> {
  late String firsthalf;
  late String secondhalf;

  bool hiddentext = true;

  double texthiegth = Dimensions.screenheight / 5.63;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > texthiegth) {
      firsthalf = widget.text.substring(0, texthiegth.toInt());
      secondhalf =
          widget.text.substring(texthiegth.toInt() + 1, widget.text.length);
    } else {
      firsthalf = widget.text;
      secondhalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalf.isEmpty
          ? smalltext(text: firsthalf, size: Dimensions.font16,color: AppColor.paracolor,)
          : Column(
              children: [
                smalltext(
                  height: 1.8,
                  color: AppColor.paracolor,
                  size: Dimensions.font16,
                  text: hiddentext
                      ? ("$firsthalf....")
                      : (firsthalf + secondhalf),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddentext = !hiddentext;
                    });
            
            
                      
            
                  },
                  child: Row(
                    children: [
                      smalltext(
                        text: hiddentext?"Show more": "Show less",
                        color: AppColor.maincolor,
                      ),
                      Icon(
                        hiddentext ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                        color: AppColor.maincolor,
                      ),
                     
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
