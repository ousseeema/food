import 'package:food/Data/api/apiclient.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
class locationrepo {
  apiclient apiClient;
  SharedPreferences sharedPreferences;


  locationrepo({required this.apiClient, required this.sharedPreferences});
final connect =GetConnect();
  Future<Response> GetAddressFromGeoCode(LatLng latlng)  {
    
  return connect.get(("https://geocode.maps.co/reverse?lat=${latlng.latitude}&lon=${latlng.longitude}"));

   }
   Future<Response> getzone(String lat , String lon) async {


    return await apiClient.getdata("${AppConstants.ZONE_URI}?lat=${lat}&lng=${lon}");
   }


  Future<Response> getsearchlocation(String text)async {
    
    return await  apiClient.getdata("${AppConstants.location_search}?search_text=${text}");
  }



  Future<Response> getlocationdetails(String placeid)async{

    return await apiClient.getdata("${AppConstants.search_details}?placeid=${placeid}");

  }
 

}