// ignore_for_file: empty_constructor_bodies

import 'package:food/Data/api/apiclient.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:get/get.dart';

class popularProductRepo extends GetxService {
  final apiclient apiClient;
  popularProductRepo({required this.apiClient});
  Future<Response> getpopularProductList() async {
    return apiClient.getdata(AppConstants.POPULAR_PRODUCTS_URI);
  }
}
