

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food/controller/cartController.dart';
import 'package:food/controller/popular_product_controller.dart';
import 'package:food/controller/recommanded_food_controller.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/services/shared.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'helper/dependencies.dart' as dep;
Future<void>  main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );
    shared.init();
  
    
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<cartecontroller>().getcartdata();
    Get.find<PopularProductController>().get_popular_product_list();
    Get.find<recommendedProductController>().get_recommended_product_list();
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
    // home:login(),
     initialRoute: routeheleper.getspalshpage(),
      getPages: routeheleper.Routes,
      theme: ThemeData(primaryColor: AppColor.maincolor),
    );
  }
}
