// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:food/models/popular_product_model.dart';
import "package:get/get.dart";
import 'package:food/Data/api/repository/carterepo.dart';

import '../models/cartmodel.dart';
import '../view/utils/appcolor.dart';

class cartecontroller extends GetxController{
  final  CarteRepo carterepo ;
  cartecontroller({required this.carterepo});

  Map<int, CartModel> _items= {};
   Map<int,CartModel> get items => _items;
  List<CartModel> storageitems=[];
   
  


  void addItem(ProductModel product, int quantity){
    /*
    but de la function :
    remarque : el map mtaay 3ibara key value el key howa el product id w value 3bara aala object type mte3a carte model 

     waqet netki aala button add to the carte 
     function add item demarre besh nzyd el produit 
     bel quantity eli deja ena mapssiha fi paeametre 
     si el product w quantity mawjoudin deja fi map mtaay naamlhom update 
     sinon naamlhom add ll map mtaay besh baatali nafichihom ll UI 
     w nesta3mlhom fi hejet okhra


    */
    int totalquantity =0;
    if(_items.containsKey(product.id)){


      _items.update(product.id!, (value) {
        totalquantity = value.quantity! + quantity;
        return CartModel(
      id:  value.id,
      name:  value.name,
      price:  value.price,
      img:  value.img,
      quantity: value.quantity! + quantity,
      isexist: true,
      time: DateTime.now().toString(),
      product: product
       );
      } );
      if(totalquantity <=0){
        _items.remove(product.id);
      }


    }else{
      if(quantity>0){
    _items.putIfAbsent(product.id!, () => CartModel(
      id:  product.id,
      name:  product.name,
      price:  product.price,
      img:  product.img,
      quantity: quantity,
      isexist: true,
      time: DateTime.now().toString(),
       product: product
    ));
      }
      else {
         Get.snackbar("Item count", "You should at least add an item in the cart !",
       backgroundColor: AppColor.maincolor,
       colorText: Colors.white,
       duration: const  Duration(seconds: 5),
       icon: const Icon(Icons.error, size: 40,),
       isDismissible: true
       
      );
      }
    }
      carterepo.addtocartlist(getitems);
    update();
  }
  // cherche 3la product mawjoud fi map mtaa el prod uts wala lee
 bool existinlist(ProductModel product ){
  if(_items.containsKey(product.id)){
    return true ;
 }
 else{
  return false;
 }
 }
 // getting the quantity that has beeen add to the cart
 int getquantity(ProductModel product ){
  var quantity =0;

  if(_items.containsKey(product.id)){
    _items.forEach((key, value) {
      if(key == product.id){
        quantity= value.quantity!;
        
      }
    }
    );
  }
  return quantity;
 }


int? get totalitems{
  var totalquantity=0;
  _items.forEach((key, value) {
    totalquantity +=  value.quantity!;
  });
   return totalquantity;
}

List<CartModel> get getitems{
  return _items.entries.map((e) {
     return e.value;
   }).toList();
}

int get totalamount{
  var total =0;
  _items.forEach((key, value) {
    total +=value.quantity! *  value.price!;
  });
  return total;
}



List<CartModel>? getcartdata(){
  setcart = carterepo.getcartlist();
  return storageitems;
}

set setcart(List<CartModel> items){
  storageitems = items;

for(var i=0; i<storageitems.length; i++){
  _items.putIfAbsent(storageitems[i].product!.id!, () => storageitems[i]);
}

}



void addtohistory(){
  carterepo.addtocarthistorylist();
  clear();
}

void clear(){
  _items={};
  update();
}


List<CartModel> getcarthistorylist(){
  return carterepo.getcarthistory();
}

set setitems(Map<int,CartModel> maps){
  _items={};
  _items =maps;  
}

void addtocartlist(){
  carterepo.addtocartlist(getitems);
  update();
}

  void clearcarhistory(){
    carterepo.clearcartehistory();
    update();
  }



}