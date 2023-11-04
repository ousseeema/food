import 'package:food/view/pages/cart/cartpage.dart';
import 'package:food/view/pages/food/popular_food_details.dart';
import 'package:food/view/pages/food/recommended_food_details.dart';
import 'package:food/view/pages/home/homepage.dart';
import 'package:food/view/pages/location/add_address_page.dart';
import 'package:food/view/pages/location/pick_address_map.dart';
import 'package:food/view/pages/payement/payment_success.dart';
import 'package:food/view/pages/sign_inandout/login.dart';
import 'package:food/view/pages/sign_inandout/signup.dart';
import 'package:food/view/pages/splash/splashpage.dart';
import 'package:get/get.dart';

class routeheleper {
  static const String  splashscreen ="/splashpage";
  static const String initaleroute = "/";
  static const String popularfood = "/popular-food";
  static const String recommendedfood = "/recommended-food";
  static const String Cartpage = "/cart-page";
  static const String sign = "/sign-in";
  static const String signout="/sign-out";
  static const String  addaddres ="/add-address";
  static const String pickaddress="/pick-address";
   static const String paymentsuccess ="/payment_success";




   
   static String getspalshpage()=> '${splashscreen}';
  static String getinitial() => "${initaleroute}";
  static String getPopularFood(int index) => "$popularfood?pageId=$index";
  static String getrecommendedFood(int pageid) =>
      "$recommendedfood?pageId=$pageid";
  static String getcartpage() => "${Cartpage}";
  static String getsignin() => "${sign}";
  static String getsignout()=>"${signout}" ;
  static String getaddress()=> "${addaddres}";
  static String  getpickaddres()=> "${pickaddress}";
 static String  getpayment()=> "${paymentsuccess}";


  static List<GetPage> Routes = [
    GetPage(name: splashscreen, page: ()=> const splashpage()),
    GetPage(name: initaleroute, page: () => const homepage()),
    GetPage(
        name: popularfood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return popularFoodDetails(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedfood,
        page: () {
          var pageid = Get.parameters["pageId"];
          return recommandedFoodDetails(
            pageId: int.parse(pageid!),
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: Cartpage,
        page: () {
          return const cartpage();
        },
        transition: Transition.fadeIn),
        
        
        GetPage(
        name: sign,
        page: () {
          
          return  login();
        },
        transition: Transition.fadeIn),

        GetPage(name: signout, page: ()=>const signuppage(), transition: Transition.fadeIn),

        GetPage(name: addaddres, page: ()=>const addaddresspage(), transition: Transition.fadeIn),
       GetPage(name: pickaddress, page: (){
        PickAdressMap _pickAdressMap = Get.arguments;
        return _pickAdressMap;
       }),
 
 

        GetPage(name: paymentsuccess, page: ()=> const payment_success(), transition: Transition.fadeIn)
  ];
}
