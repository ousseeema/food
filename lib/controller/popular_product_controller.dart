// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:food/Data/api/repository/popular_product_repo.dart';
import 'package:food/controller/cartController.dart';
import 'package:food/models/cartmodel.dart';
import 'package:food/models/popular_product_model.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final popularProductRepo popular_product_repo;
  PopularProductController({required this.popular_product_repo});
  List<dynamic> _popularproductList = [];
  List<dynamic> get popularproductlist => _popularproductList;
   late cartecontroller _cart;

  bool _isLoading = false;
  bool get isloading => _isLoading;
  int _quantity = 0;
  int get quantity => _quantity;
  int _incarteitem =0;
  int get incarteitem => _incarteitem +_quantity;



  Future<void> get_popular_product_list() async {
    //  nb ! = popular product controller -> popular product repo  -> api client
    Response response = await popular_product_repo.getpopularProductList();
    if (response.statusCode == 200) {
      _popularproductList = [];
      _popularproductList.addAll(Product.fromJson(response.body).products);
      _isLoading = true;
      update();
    } else {
      print("error loading information from server");
    }
  }

  void Setquantity(bool isIncrement) {
    if (isIncrement) {
      
      _quantity = checkQuantity(_quantity + 1);
      update();
    } else {

      _quantity = checkQuantity(_quantity - 1);
      update();
    }
  }

  int checkQuantity(int quantity) {
    if (_incarteitem + quantity < 0) {
      Get.snackbar("Item count", "you can't reduce  more sorry !",
       backgroundColor: AppColor.maincolor,
       colorText: Colors.white,
       duration: const  Duration(seconds: 5),
       icon: const Icon(Icons.error, size: 40,),
       isDismissible: true
       
      );
     if(incarteitem>0){
        return _quantity = -_incarteitem;
      }


      return 0;
    } else if (_incarteitem + quantity > 30) {
        Get.snackbar("Item count", "you can't add more sorry !",
       backgroundColor: AppColor.maincolor,
       colorText: Colors.white,
       duration: const  Duration(seconds: 5),
       icon: const Icon(Icons.error, size: 40,),
       isDismissible: true
       
      );
       
      return 30;
      
    } else {
      return quantity;
      
    }
  }

void initproduct(ProductModel product,  cartecontroller cart){
  _quantity =0;
  _incarteitem=0;
  _cart= cart;  
  var exist = false;
  exist = _cart.existinlist(product);

  //get from storage
  if(exist){
    _incarteitem= _cart.getquantity(product);
  }
   
}
void additem(ProductModel product){
  
    _cart.addItem(product, _quantity);
    _quantity=0;
    _incarteitem = _cart.getquantity(product);
   update();
}
 int? get totalitems{
  return _cart.totalitems;
 }
  List <CartModel>  get getitems{
    return _cart.getitems;
  }


}
