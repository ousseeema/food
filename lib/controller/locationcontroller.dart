// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/Data/api/repository/locationrepo.dart';
import 'package:food/models/adressmodel.dart';
import 'package:food/services/database.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class locationcontroller extends GetxController implements GetxService {
  locationrepo Locationrepo;

  locationcontroller({required this.Locationrepo});
  bool _loading = false;
  
  bool _changeAddress = true;
  late Position _position;
  late Position _pickerPosition;
  Placemark placemark = Placemark();
  Placemark pickPlaceMark = Placemark();
  List<AdressModel> _addressList = [];
  List<AdressModel> get addresslist => _addressList;
  List<AdressModel> _alladdressList = [];
  List<String> _addresstypelist = ["home", "office", "others"];
  int _addresstypeindex = 0;
  int get addrestypeindex => _addresstypeindex;
  List<String> get addresstypelist => _addresstypelist;

  late GoogleMapController _mapController;
  GoogleMapController get mapcontroller => _mapController;

  bool _updateaddressdata = true;
  bool get loading => _loading;

  Position get postion => _position;
  Position get pickPostion => _pickerPosition;

  void setmapcontroller(GoogleMapController mapcontroller) {
    _mapController = mapcontroller;
    
  }
  Map<String,dynamic> Address={};


 

  // fonction besh taamli update ll postion w pickpostion besh nadiha mn page add_address_page
  void updatePostion(CameraPosition position, bool fromaddress) async {
    if (_updateaddressdata) {
      _loading = true;
      update();

      try {
        // hedhy waqet nbda nakhtar mn el el map el sghyra eli fi add_address_page

        if (fromaddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            headingAccuracy: 1,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speed: 1,
            speedAccuracy: 1,
            altitudeAccuracy: 1,
          );
        }else{
          _pickerPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            headingAccuracy: 1,
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speed: 1,
            speedAccuracy: 1,
            altitudeAccuracy: 1,
          );
        }

        
        
        
        // in this if we will send the corrdonnation to the serveur and the serveur will  speak with the googel map and return
        // the name of the place that we choose in the maps (ex : tawa besh nabaatho object latlang ll serveur fi forme(44.66555,87.8148787)
        //w google maps bvesh yrajjali esm el blasa)
        if (_changeAddress) {
          
                Address = await getAddressFromGeoCode(
              LatLng(position.target.latitude, position.target.longitude));
            if(fromaddress){
                placemark = Placemark(
                  name: Address["road"]?? "",
                  country: Address["country_code"]??"",
                  locality: Address["state"]??"",
                  subLocality: Address["county"]??"");
            }else{
               pickPlaceMark = Placemark(
                  name: Address["road"]?? "",
                  country: Address["country_code"]??"",
                  locality: Address["state"]??"",
                  subLocality: Address["county"]??"");

            }
         
             
        }
      } catch (e) {
        print(e);
      }
      _loading= false;
      update();
    }
    else{
      _updateaddressdata =true;
   
      //update();
    }
  }

  Future<Map<String, dynamic>> getAddressFromGeoCode(LatLng latlng) async {
    Map<String, dynamic> _address = {};

    Response response = await Locationrepo.GetAddressFromGeoCode(latlng);
    if (response.statusText == "OK") {
      _address = response.body["address"];
      
    } else {
      print("error loading from the api ");
    }

    return _address;
  }

  late Map<String, dynamic> _getaddress;
  Map get getaddress => _getaddress;

//change the type index lors de la clique dans le UI sur les type des address
  void setAddresstypeindex(int index) {
    _addresstypeindex = index;
    update();
  }

  // saving the address in the data base
  void saveaddress(Map addressdetails) async {
    try {
      await database(Uid: FirebaseAuth.instance.currentUser!.uid)
          .saveaddress(addressdetails)
          .then((value) {
        
        Get.snackbar("Done!", "Your order has been take care of it :)",
            colorText: Colors.black,
            backgroundColor: AppColor.maincolor,
            barBlur: 10,
            icon: const Icon(Icons.done));
      });
    } catch (e) {
      Get.snackbar("Error", "Error saving your address delivery");
    }
  }
     void setaddressupdate(){

  
       _position = _pickerPosition;
       placemark = pickPlaceMark; 
       
       _updateaddressdata = false;
      
        update();
        
    }


}
