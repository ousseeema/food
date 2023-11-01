// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food/controller/locationcontroller.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

class locationDialogue extends StatelessWidget {
  GoogleMapController mapController;
  locationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    TextEditingController contrl = TextEditingController();

    return Container(
      padding: EdgeInsets.all(Dimensions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        borderRadius: BorderRadius.circular(Dimensions.heigth20 / 2),
        child: SizedBox(
          height: 50,
          width: Dimensions.screenwidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: contrl,
                autofocus: true,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                          width: 0,
                        )))),

            //function hedhy el list eli trajaaha direct
            //tet7at fi function eli baaedha fi argument prediction b maniere automatique
            // besh nhez ena heka liste of prediction w naamlha affichage b facon kif ma nhebha ena fi itembuilder
            suggestionsCallback: (String text) async {
              return await Get.find<locationcontroller>()
                  .searchlocation(context, text);
            },
            // hedhy ki besh nakhtar wahda mn suggestion eli 3tahomli serveur besh nemshy naal mise ajour 
            // ll postion w camera postion w esm postion jdida eli besh nakhtarha 
            onSuggestionSelected: (Prediction suggestion) async {
             
             await Get.find<locationcontroller>().getsearchdetails(
                  suggestion.placeId!, suggestion.description!, mapController);
                  
              Get.back();
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimensions.width10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    Expanded(
                        child: Text(
                      suggestion.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                              fontSize: Dimensions.font16 + 2),
                    )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
