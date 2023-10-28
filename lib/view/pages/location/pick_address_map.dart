// ignore_for_file: unused_field, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:food/controller/locationcontroller.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/pages/location/add_address_page.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/save_address_btt.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAdressMap extends StatefulWidget {
  final bool? fromsignup;
  final bool? fromadresss;
  final GoogleMapController? googlemapcontroller;
  const PickAdressMap(
      {super.key, this.fromadresss, this.fromsignup, this.googlemapcontroller});

  @override
  State<PickAdressMap> createState() => _PickAdressMapState();
}

class _PickAdressMapState extends State<PickAdressMap> {
  late TextEditingController _addressmarker = new TextEditingController();

  // hedhom hatithom heka mn location controller besh awel ma tete7al el map besh thezni el akher blasa khtaretha fi map lawla 
  // yaani ken khtaret blasa fi map lawla w baatali habyt nbdlha fi map el kbyra yazem ki nhell map nalgeha kif kfi 
  // mesh wahda fi bllasa w lokhra fi blasa okhra mehomsh kifkif 
  // yyani bel falegi el blasa eli khtaretha fi map lawla ki nodkhel ll thenya nalga nafesha 
  late LatLng _initposition = LatLng(
      Get.find<locationcontroller>().postion.latitude,
      Get.find<locationcontroller>().postion.longitude);




  late CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(Get.find<locationcontroller>().postion.latitude,
          Get.find<locationcontroller>().postion.longitude),
      zoom: 17);
  late GoogleMapController _mapcontroller;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<locationcontroller>(builder: (locationcntrl) {
      // njib fi donnees aala el blasa w esmha mn location controller 
      _addressmarker.text = '${locationcntrl.pickPlaceMark.name ?? ''} '
          ' ${locationcntrl.pickPlaceMark.locality ?? ""} '
          ' ${locationcntrl.pickPlaceMark.country ?? ''} ';
      return Scaffold(
          body: SafeArea(
              child: Center( 
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition:
                    CameraPosition(target: _initposition, zoom: 17),
                    // kol ma n7arek el maps hiya takhker position jdida w t7otha fi camera position besh 
                    //ena baatali feme fonction okhra temshy taaml update ll les corrdonnes w asemli jdod w kol mtaa el blasa jdida 
                onCameraMove: (position) {
                 
                    _cameraPosition = position;
            
                },
                // hedhy hiya fonction eli besh tnedi func updateposition eli fi location controller 
                // besh taamlna update ll donnes zay postion w place marker eli fihom donnes zay esm el blasa eli khtarnha 
                // cameraposition fiha hajet zay longitude w latitude nabaathom ll serveur besh yrajaali esm el blasa eli b corrdonnees heki 
                // wena nhez naamlha enreg fi place marker eli besh baatali njm naccedila mn blayes okhra w nafiche esm el blasa w kol 
                // kol ma tetbadl tsyr mise a jour ll hejet kol 
                onCameraIdle: () {
                  Get.find<locationcontroller>()
                      .updatePostion(_cameraPosition, false);
                },
              ),

              // center widget for the image marker.png to be  over the map

              Center(
                  child: !locationcntrl.loading
                      ? Image.asset(
                          "img/marker.png",
                          height: 50,
                          width: 50,
                        )
                      : const CircularProgressIndicator(
                          color: AppColor.maincolor,
                        )),

              // container to display the current address that the user choose
              Positioned(
                top: Dimensions.heigth45,
                left: Dimensions.width20 / 2,
                right: Dimensions.width20 / 2,
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20 / 2),
                        border: Border.all(color: Colors.black),
                        color: AppColor.maincolor),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on),
                        Expanded(
                            child: Text(
                          "${_addressmarker.text}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    )),
              ),

              // this postionned widget for making button to save the address that will retrevie
              Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: locationcntrl.isloading ? Center(
                    child: CircularProgressIndicator(),
                  ):SaveButt(
                    bttText:widget.fromadresss! ?"Pick Address": "Pick Location ",
                    icon: Icons.done,
                    // if loding is true naaml verification aala el
                    //variable pickposition w pickplacemarker fihom donnee wele le
                    // ken fihom donnes naaml mise ajour ll camera postion b 
                    // position jdida eli deja khtartha ki amltt save address 
                    // w baaed yhezni ll page eli jyt mmnha 
                    OnPressed: (locationcntrl.loading)
                        ? null
                        : () {
                            if (locationcntrl.pickPostion.latitude != 0 &&
                                locationcntrl.pickPlaceMark.name != null) {
                              if (widget.fromadresss!) {
                                if (widget.googlemapcontroller != null) {
                                  widget.googlemapcontroller!.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: LatLng(
                                                  locationcntrl
                                                      .pickPostion.latitude,
                                                  locationcntrl.pickPostion
                                                      .longitude))));

                                  locationcntrl.setaddressupdate();
                                 
                                }
                                Get.back();






                              }
                            }
                          },
                  ),
                  )
           
                  
                  
                  
                  
                   ],
          ),
        ),
      )));
    });
  }
}
