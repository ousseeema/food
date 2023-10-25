// ignore_for_file: prefer_const_constructors, unused_field, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:food/controller/locationcontroller.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/services/shared.dart';
import 'package:food/view/pages/location/pick_address_map.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/bigtext.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class addaddresspage extends StatefulWidget {
  const addaddresspage({super.key});

  @override
  State<addaddresspage> createState() => _addaddresspageState();
}

class _addaddresspageState extends State<addaddresspage> {
  // variable that will containe the name of the person logged in his phone number and one variable for the address that came from the google map api in location controller class
  final TextEditingController _addresscontroller = TextEditingController();
  final TextEditingController _contactpersonname = TextEditingController();
  final TextEditingController _contactpersonnumber = TextEditingController();
  late bool islooged;

  // camera postion taatik el blasa eli aatiha enta fi coordonnee
  //fi google maps mn foug b zoom eli theb aalih
  CameraPosition _cameraposition =
      CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  // postion initiale eli besh tet7all 3liha google map
  late LatLng _initposition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addresscontroller.text="";
    // getting the value of islogin in the sharedpreferences "look at page shared "
    islooged = shared.getbool("islogin");

    if (Get.find<locationcontroller>().addresslist.isNotEmpty) {
      // besh nthabet ken el lista eli fi page location controller fiha address gdyma deja ou nn
      // si fiha des adddress njibhom w nhothom fi camera postion elli besh tji fih el camera awel ma tet7al el google maps hiya w init postion
      // sinon ma naaml chy
      _cameraposition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<locationcontroller>().getaddress["latitude"]),
              double.parse(
                  Get.find<locationcontroller>().getaddress["longitude"])));

      _initposition = LatLng(
          double.parse(Get.find<locationcontroller>().getaddress["latitude"]),
          double.parse(Get.find<locationcontroller>().getaddress["longitude"]));
    }
    // jebna les info mtaaa compte mn sharedpreferences w hatinehom fi des variable besh naaamlolhom affichage fi UI
    // kol ma tet7al page hedhy
    if (islooged == true && _contactpersonname.text.isEmpty) {
      _contactpersonname.text = shared.getString("name");
      _contactpersonnumber.text = shared.getString("phone");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GetBuilder<locationcontroller>(
        builder: (locationcontroller1) {
          //recupere l'objet placemark from location controller et affiche
          // les attribut eli fi wasta "deja aamlnalhom init fi page location controller "
          _addresscontroller.text =
              '${locationcontroller1.placemark.name ?? ""} '
              '${locationcontroller1.placemark.locality ??""} '
              '${locationcontroller1.placemark.country ??""}';

          print("adress is ${_addresscontroller.text}");

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //this container to show google maps
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(right: 7, left: 7, top: 5),
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(width: 2, color: AppColor.maincolor),
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(
                       
                        onTap: (x) {
                           
                          Get.toNamed(routeheleper.getpickaddres(),arguments: PickAdressMap(
                            fromsignup: false ,
                            fromadresss:true ,
                            googlemapcontroller:locationcontroller1.mapcontroller,


                          ));
                          
                        },

                        initialCameraPosition:
                            CameraPosition(target: _initposition, zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        // mylocation enabled taati acces ll tlf besh yhez postion mtaak
                        myLocationEnabled: true,
                        // update location or postion

                        onCameraMove: (position) {
                          // fonction hedhy besh thez el position nwaqet howa yabde yet7arek bel map w taamlha enregistre
                          //fi _cameraposition variable besh batali el fonction eli baaedha thez heki position
                          // w temshy taaml update khater feme address jdiida t7atet
                     
                            _cameraposition = position;
                     
                        },
                        // fonction besh thez camera position jdida
                        // w temshy taaml update ll address el gdyma w tkharej mnha esm el blasa w rue w country
                        onCameraIdle: () {
                          locationcontroller1.updatePostion(
                              _cameraposition, true);
                        },
                        onMapCreated: (GoogleMapController controller) {
                          locationcontroller1.setmapcontroller(controller);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // this container for icons for the type of address
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: locationcontroller1.addresstypelist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 70,
                              ),
                              InkWell(
                                onTap: () {
                                  locationcontroller1
                                      .setAddresstypeindex(index);
                                },
                                child: Icon(
                                  index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color: locationcontroller1.addrestypeindex ==
                                          index
                                      ? AppColor.maincolor
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),

                SizedBox(
                  height: Dimensions.heigth20,
                ),

                // Text widget for dilevry address
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: bigtext(
                    text: "Delivery Address",
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: Dimensions.heigth10,
                ),

                //CONTAINER ll affichage de donnees de geocoding
                Container(
                  margin: EdgeInsets.only(left: 5),

                  height: Dimensions.heigth45,
                  //container for the address coming from api decode
                  child: Row(
                    children: [
                      Icon(
                        Icons.gps_fixed,
                        color: AppColor.iconcolor1,
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            _addresscontroller.text,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.heigth10,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: bigtext(
                    text: "Contact name",
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: Dimensions.heigth10,
                ),

                // contact info name
                Container(
                  margin: EdgeInsets.only(left: 5),

                  height: Dimensions.heigth45,
                  //container for the address coming from api decode
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.person,
                        color: AppColor.iconcolor1,
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Text(
                        _contactpersonname.text,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: Dimensions.heigth10,
                ), // espace entre name container and the text contact phone

                // text contact phone
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: bigtext(
                    text: "Contact phone",
                    color: Colors.black,
                  ),
                ),

                SizedBox(
                  height: Dimensions.heigth10,
                ),

                // contact info phone
                Container(
                  margin: EdgeInsets.only(left: 5),

                  height: Dimensions.heigth45,
                  //container for the address coming from api decode
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.phone_android,
                        color: AppColor.iconcolor1,
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Text(
                        _contactpersonnumber.text,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )),
      bottomNavigationBar: GetBuilder<locationcontroller>(
        builder: (loccontroller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.heigth20 * 8,
                padding: EdgeInsets.only(
                    top: Dimensions.heigth30,
                    bottom: Dimensions.heigth30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColor.buttombackgroundcolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        //this function will save the user address info in the data base

                        Map<String, dynamic> detailsaddress = {
                          "name": _contactpersonname.text,
                          "phone": _contactpersonnumber.text,
                          "latitude": loccontroller.postion.latitude.toString(),
                          "longitude":
                              loccontroller.postion.longitude.toString(),
                          "type_address": loccontroller
                              .addresstypelist[loccontroller.addrestypeindex],
                          "city_name": loccontroller.placemark.name,
                          "country": loccontroller.placemark.country,
                          "state": loccontroller.placemark.locality,
                          "county": loccontroller.placemark.subLocality
                        };

                        // ken el conatiner deja fiha el address par default nkharej pop up message
                        //sinon naaml enreg ll address w hajet lokhra i data base
                        if (_addresscontroller.text ==
                            "  ") {
                          Get.snackbar(
                              "Error", "Type your address with google map",
                              colorText: Colors.white,
                              barBlur: 10,
                              backgroundColor: Colors.red);
                        } else {
                          
                          
                          loccontroller.saveaddress(detailsaddress);
                          Get.toNamed(routeheleper.initaleroute);

                                
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.maincolor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        padding: EdgeInsets.only(
                            top: Dimensions.heigth20,
                            bottom: Dimensions.heigth20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: bigtext(
                          text: "Save your address",
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
