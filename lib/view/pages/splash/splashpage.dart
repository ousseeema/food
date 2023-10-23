import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/popular_product_controller.dart';
import '../../../controller/recommanded_food_controller.dart';

class splashpage extends StatefulWidget {
  const splashpage({super.key});

  @override
  State<splashpage> createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadresources() async {
    await  Get.find<PopularProductController>().get_popular_product_list();
   await  Get.find<recommendedProductController>().get_recommended_product_list();
  }
  @override 
  void initState(){
    super.initState();
    _loadresources();
    controller =  AnimationController(vsync: this,duration:const  Duration(seconds: 2))..forward();
    animation  = CurvedAnimation(parent: controller, curve: Curves.easeOutQuart);

    Timer(
     const  Duration(seconds: 3)
      , () { 
        Get.toNamed(routeheleper.getinitial());
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScaleTransition(
            scale: animation,
          child: Center(child: Image.asset("img/livreur.png",width:Dimensions.splashscreen,))),       
        ],
      ),
    );
  }
}