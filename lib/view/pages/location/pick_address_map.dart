// ignore_for_file: unused_field, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/controller/locationcontroller.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
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
  late TextEditingController _addressmarker = TextEditingController();
  late LatLng _initposition = LatLng(45.51563, -122.677433);
  late CameraPosition _cameraPosition =
      CameraPosition(target: _initposition, zoom: 17);
  late GoogleMapController _mapcontroller;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<locationcontroller>(builder: (locationcntrl) {
      return Scaffold(
          body: SafeArea(
              child: Center(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initposition, zoom: 17),
                onCameraMove: (position) {
                  setState(() {
                    _cameraPosition = position;
                  });
                },
                onCameraIdle: () {
                  Get.find<locationcontroller>()
                      .updatePostion(_cameraPosition, false);
                },
                onMapCreated: (controller) {
                  _mapcontroller = controller;
                },
              ),

              // center widget for the image marker.png to be  over the map

              Center(
                child: !locationcntrl.loading
                    ? CircularProgressIndicator(
                        color: AppColor.maincolor,
                      )
                    : Image.asset(
                        "img/marker.png",
                        height: 50,
                        width: 50,
                      ),
              ),

              // container to display the current address that the user choose
              GetBuilder<locationcontroller>(builder: (controller) {
                _addressmarker.text = '${controller.pickPlaceMark.name ?? ''} '
                    ' ${controller.pickPlaceMark.locality ?? ""} '
                    ' ${controller.pickPlaceMark.country ?? ''} ';
                return Positioned(
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
                            style:const  TextStyle(fontSize: 16, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      )),
                );
              })
            ],
          ),
        ),
      )));
    });
  }
}
