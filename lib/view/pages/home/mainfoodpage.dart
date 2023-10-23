// hedhi page home besh tnadi baatli ll page foodpagebody
import 'package:flutter/material.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/pages/home/foodpagebody.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/bigtext.dart';
import 'package:food/view/widgets/smalltext.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/popular_product_controller.dart';
import '../../../controller/recommanded_food_controller.dart';

class mainfoodpage extends StatefulWidget {
  const mainfoodpage({super.key});

  @override
  State<mainfoodpage> createState() => _mainfoodpageState();
}

class _mainfoodpageState extends State<mainfoodpage> {
   Future<void> _loadresources() async {
    await  Get.find<PopularProductController>().get_popular_product_list();
   await  Get.find<recommendedProductController>().get_recommended_product_list();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      
      onRefresh:_loadresources ,
      
      child: Column(
        children: [
          //showing the header 
          Container(
            child: Container(
              margin:  EdgeInsets.only(top: Dimensions.heigth45, bottom: Dimensions.heigth15),
              padding:  EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20 ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    bigtext(
                      text: "Tunisie",
                      color: AppColor.maincolor,
                    ),
                    Row(
                      children: [
                        smalltext(
                          text: "Djerba",
                          color: Colors.black54,
                        ),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ]),
                  Center(
                    child: Container(
                      width: Dimensions.heigth45,
                      height: Dimensions.heigth45,
                      decoration: BoxDecoration(
                        color: AppColor.maincolor,
                        borderRadius: BorderRadius.circular(Dimensions.width15),
                      ),
                      child:  Icon(Icons.search, color: Colors.white,size: Dimensions.iconsize24,),
                    ),
                  )
                ],
              ),
            ),
          ),
         //showing the body 
         const  Expanded(child: 
          SingleChildScrollView(
            child:  FoodPageBody(),
          ))
        ],
      ),
     );
  }
}
