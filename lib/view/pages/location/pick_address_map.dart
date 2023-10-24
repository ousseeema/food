// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAdressMap extends StatefulWidget {
  final bool? fromsignup;
  final bool? fromadresss;
  final GoogleMapController? googlemapcontroller;
  const PickAdressMap({super.key, this.fromadresss,this.fromsignup, this.googlemapcontroller});

  @override
  State<PickAdressMap> createState() => _PickAdressMapState();
}

class _PickAdressMapState extends State<PickAdressMap> {
  late LatLng _initposition = LatLng(45.51563, -122.677433);
  late CameraPosition _cameraPosition= CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late GoogleMapController _mapcontroller;
  @override
  void initState() {
    // TODO: implement initState
    

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: SafeArea(child:
        Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
          
          
              
            ),
          ),
        )
      
      
       )
    );
  }
}