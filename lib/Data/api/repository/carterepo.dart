import 'dart:convert';

import 'package:food/models/cartmodel.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarteRepo {
  final SharedPreferences sharedPreferences;

  CarteRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> carthistory = [];

  void addtocartlist(List<CartModel> cartelist) {
    cart = [];
    var time = DateTime.now().toString();
    // convert object to String then add to
    // the sharedPreferences because sharedPreferences accept only String
    //jsonencode convert the object to a map type string
    cartelist.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList("Cart-List", cart);
  }

// getting the list of element from sharedpreferences and then convert each element to an object type cartemodel
// jsondecode take the element type string in our code the element in the list is in the format of "id: .... , name:.... ,..."
// then convert to a map or "json" then with the methode fromjson it convert to a object type cartmodel

  List<CartModel> getcartlist() {
    List<String> carts = [];

    if (sharedPreferences.containsKey("Cart-List")) {
      carts = sharedPreferences.getStringList("Cart-List")!;
    }
    List<CartModel> cartlist = [];
    carts.forEach((element) {
      cartlist.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartlist;
  }

  // besh naaml recuperation lel cart-history mn shared preferences
  // w battali nrajjahom sous la form mtaa list of cartmodel
  // hedha kol besh ysyr bel methode fromjson eli besh t7aweli map (json) sous from d un object de type cartmodel
  // jsondecode besh takhedh element type mtaa String map (yaani map fi form mtaa string voir lexemple ) w trajaaholi map khw
  List<CartModel> getcarthistory() {
    if (sharedPreferences.containsKey("cart-history")) {
      carthistory = [];
      carthistory = sharedPreferences.getStringList("cart-history")!;
    }
    List<CartModel> cartlisthistory = [];
    carthistory.forEach((element) {
      cartlisthistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartlisthistory;
  }

  // besh tshouf ken feme deja fi shared prefernces cart-history wala le ken feme besh nrecuperehom
  //w baatali naaml parcours aala les items eli tzado jdoud fi history w nzidhom ll gdom eli deja mawjoudin
  //fi lakher besh naamlhom  save fi shared preferences el lista eli deja mawjouda maa les items eli tzado fi historyk

  void addtocarthistorylist() {
    if (sharedPreferences.containsKey("cart-history")) {
      carthistory = sharedPreferences.getStringList("cart-history")!;
    }
    for (int i = 0; i < cart.length; i++) {
      carthistory.add(cart[i]);
    }
    removecart();
    sharedPreferences.setStringList("cart-history", carthistory);
  }

  //reset the cart list and the shared preferences to vide
  void removecart() {
    cart = [];
    sharedPreferences.remove('Cart-List');
  }
  void clearcartehistory(){

    removecart();
    carthistory=[];
    sharedPreferences.remove("cart-history");
    


  }
}
