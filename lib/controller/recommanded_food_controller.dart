
// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:food/models/popular_product_model.dart';
import 'package:get/get.dart';

import '../Data/api/repository/recommended_food_repo.dart';

class recommendedProductController extends GetxController {
  final recommendedProductRepo recommended_product_repo;
  recommendedProductController({required this.recommended_product_repo});
  List<dynamic> _recommendedproductList = [];
  List<dynamic> get recommendedproductlist => _recommendedproductList;
  bool _isLoading = false;
  bool  get isloading => _isLoading;

  Future<void> get_recommended_product_list() async {
    //  nb ! = recommended product controller -> recommended product repo  -> api client
    Response response = await recommended_product_repo.getrecommendedProductList();
    if (response.statusCode == 200) {
      
      _recommendedproductList = [];
      _recommendedproductList.addAll(Product.fromJson(response.body).products);
   
      _isLoading = true;
      update();
    } else {}
  }

  void SetRecQuality(){
    
  }
}
