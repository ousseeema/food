import 'package:food/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiCheker{


  static void checkApi(Response response){
    if(response.statusCode==401){
      Get.offNamed(routeheleper.sign);

    }else {
     Get.snackbar("Eroor", response.statusText!);
    }

  }
}