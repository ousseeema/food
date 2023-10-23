import 'package:food/Data/api/apiclient.dart';
import 'package:food/Data/api/repository/carterepo.dart';
import 'package:food/Data/api/repository/locationrepo.dart';
import 'package:food/Data/api/repository/popular_product_repo.dart';
import 'package:food/Data/api/repository/recommended_food_repo.dart';
import 'package:food/controller/locationcontroller.dart';
import 'package:food/controller/popular_product_controller.dart';
import 'package:food/controller/recommanded_food_controller.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/cartController.dart';

Future<void> init() async {
  //shared preferences
  final sharedpreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedpreferences);

  //sharedpreferences.clear();
  //api clinet
  Get.lazyPut(() => apiclient(appbaseurl: AppConstants.BASE_URI));



// repo
  Get.put(CarteRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => popularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => recommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => locationrepo(apiClient: Get.find(), sharedPreferences: Get.find()));

 
 
 
 
  // controller
  Get.put(cartecontroller(carterepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popular_product_repo: Get.find()));
  Get.lazyPut(
      () => recommendedProductController(recommended_product_repo: Get.find()));
  Get.lazyPut(() => locationcontroller(Locationrepo: Get.find()));
}
