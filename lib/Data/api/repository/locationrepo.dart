import 'package:food/Data/api/apiclient.dart';
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

 

}