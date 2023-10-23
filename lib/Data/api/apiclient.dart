// ignore_for_file: non_constant_identifier_names

import 'package:food/view/utils/app_constants.dart';
import 'package:get/get.dart';

class apiclient extends GetConnect implements GetxService {
  late String token ;
  final String appbaseurl;
  // ignore: unused_field
  late Map<String, String> _Mainheaders;
  apiclient({required this.appbaseurl}) {
    baseUrl = appbaseurl;
    timeout = const  Duration(seconds: 30);
   token = AppConstants.TOKEN;
    _Mainheaders = {
      'content-type': 'application/json; charset=utf-8',
      'authorization': 'bearer   $token',
    };
  }

  Future<Response> getdata(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
