// ignore_for_file: empty_constructor_bodies

import 'package:food/Data/api/apiclient.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:get/get.dart';

class recommendedProductRepo extends GetxService {
  final apiclient apiClient;
  recommendedProductRepo({required this.apiClient});
  Future<Response> getrecommendedProductList() async {
    return apiClient.getdata(AppConstants.RECOMMENDED_PRODUCTS_URI);
  }
}
