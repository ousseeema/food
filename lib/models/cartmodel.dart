import 'package:food/models/popular_product_model.dart';

class CartModel {
  int? id;
  String? name;

  int? price;

  String? img;
  int? quantity; 
  bool? isexist;
  String? time;
  ProductModel? product ;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.time,
    this.isexist,
    this.product
  });
   // t7awelk el map  ll variable eli enta aamlhom declqration yaani mn json trajalk object 
  CartModel.fromJson(Map<String, dynamic> json) {
    id= json["id"];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isexist = json['isexist'];
    product =  ProductModel.fromJson(json['product']);
  }

  // t7awelk el object ll map 
  Map<String, dynamic> toJson() {
    return {
      "id": id,
    "name": name,
    "price": price,
    "img": img,
    "quantity":quantity,
    "isExist": isexist,
    "time": time,
    "product": product!.toJson()
    };

  }
}
