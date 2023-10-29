// ignore_for_file: prefer_final_fields, unused_field, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:food/Data/api/repository/locationrepo.dart';
import 'package:food/Data/apicheker.dart';
import 'package:food/models/adressmodel.dart';
import 'package:food/models/response.dart';
import 'package:food/services/shared.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

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
  //this  varaiable will be for service zone
  bool isloading = false;
  // this varaible will be for weather the user are in the services zone
  bool inzone = false;

  // diabling button
  bool buttondisabled = true;

  void setmapcontroller(GoogleMapController mapcontroller) {
    _mapController = mapcontroller;
  }

  Map<String, dynamic> Address = {};

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
        } else {
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

        response response1 = await getzone(position.target.latitude.toString(),
            position.target.longitude.toString(), false);
        //if buttondisabled equal false we are in the services area
        buttondisabled = !response1.issucces;

        // in this if we will send the corrdonnation to the serveur and the serveur will  speak with the googel map and return
        // the name of the place that we choose in the maps (ex : tawa besh nabaatho object latlang ll serveur fi forme(44.66555,87.8148787)
        //w google maps bvesh yrajjali esm el blasa)
        if (_changeAddress) {
          Address = await getAddressFromGeoCode(
              LatLng(position.target.latitude, position.target.longitude));
          if (fromaddress) {
            placemark = Placemark(
                name: Address["road"] ?? "",
                country: Address["country_code"] ?? "",
                locality: Address["state"] ?? "",
                subLocality: Address["county"] ?? "");
          } else {
            pickPlaceMark = Placemark(
                name: Address["road"] ?? "",
                country: Address["country_code"] ?? "",
                locality: Address["state"] ?? "",
                subLocality: Address["county"] ?? "");
          }
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateaddressdata = true;

      update();
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

//change the type index lors de la clique dans le UI sur les type des address
  void setAddresstypeindex(int index) {
    _addresstypeindex = index;
    update();
  }

  // saving the address in the data base
  void saveaddress(Map<String, dynamic> addressdetails) async {
    try {
      // besh naamlo enreg ll address fi shared preferences besh alaiha test bbatali w naajmo njibouha

      shared.setlatlang("latitude", addressdetails["latitude"]);
      shared.setlatlang("longitude", addressdetails["longitude"]);
      shared.setaddressname("address",
          "${addressdetails["city_name"]} ${addressdetails["country"]} ${addressdetails["state"]} ${addressdetails["county"]} ");
      // hne twali true  khater walet aandna aaaddreese fi shared
      //  addressexiste filed fi shared aamltha besh ki nji besh naaml check out
      // yshounfi ken addressexiste fiha true yaani reho feme aadress mn ghyr ma yehzni lll page add address w ywali yaadi el order w ymshy ll home page
      // ken addressexiste fiha false reho yaani  mafemesh address  fi shared ywali yhezni ll page get address besh nakhtar address

      shared.setaddressexiste("addressexiste", true);
      // notice noaddress field yetbdl hne ll false khater walet aandna address
      // yetbdk zed fiha logout
    } catch (e) {
      Get.snackbar("Error", "Error saving your address delivery");
    }
  }

// el postion el jdida eli khtaretha mn pickerposition nhotha fi position besh
// yawalo nafes el camera postion w kol fi zouz paget
  void setaddressupdate() {
    _position = _pickerPosition;
    placemark = pickPlaceMark;

    _updateaddressdata = false;

    update();
  }

  Future<response> getzone(String lat, String lon, bool marked) async {
    late response resp;
    if (marked) {
      _loading = true;
    } else {
      isloading = true;
    }
    update();

    Response resp1 = await Locationrepo.getzone(lat, lon);
    if (resp1.statusCode == 200) {
      inzone = true;
      resp = response(true, resp1.body["zone_id"].toString());
      print(resp1);
    } else {
      inzone = false;
      resp = response(false, resp1.statusText!);
    }
    if (marked) {
      _loading = false;
    } else {
      isloading = false;
    }
    update();

    return resp;
  }

// this variable list is to save the suggeustion that comes from the google it liste of prediction
  List<Prediction> predictionslist = [];
  Future<List<Prediction>> searchlocation(BuildContext context, String text) async {
    predictionslist = [];
    // if the text eli fi receherche mesh empty besh nemshy nedi function getsearchlocation
    // eli betbi3etha besh tabaath requeste ll back end b api w trajaali esm el blayes eli grab ll text eli aadita 
    // heka aalh esmha prediction 
    // prediction hedhy deja hadhra mn googlempas 
    // khater response besh tkoun list pf prediction heka aalh deja 
    //aandna class hadhra esmha prediction fiha functon esmha fromjson
    // besh thez el prediction bel kaaba bel kaaba w tbdlhom object type prediction w t7othom fi liste de type p^rediction
    // besh najmo naccedo liha fi UI 

    if (text.isNotEmpty) {
      Response response = await Locationrepo.getsearchlocation(text);
      // el response besh tkoun 3ibara aala liste fiha beshrsha mapet  [{},{},{},{}]
      // besh naamlo foreach besh nhezouhom bel map bel map w baatali nbdlouhom ll object type prediction 
      // besh nesta3lo fromjson eli takhedh map t7awelha object 
      // besh baatali n7otouhom fi list de type prediction 
      // Todo : note bien el class prediction deja defini  yaani hadhra fi depandecie eli sabynha googlemaps..

      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        response.body['prediction'].foreach((prediction) {
          predictionslist.add(Prediction.fromJson(prediction));
        });
      }else {
        ApiCheker.checkApi(response);



      }
    }
    return predictionslist;
  }
}
