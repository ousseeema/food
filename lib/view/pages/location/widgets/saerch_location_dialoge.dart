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

    return  Container(
      padding: EdgeInsets.all(Dimensions.width10),
   // alignment:  Alignment.topCenter,
  child:  Material(
    
    borderRadius: BorderRadius.circular(Dimensions.heigth20/2),
    child: SizedBox(
      height: 100,
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
              borderSide: BorderSide(
                style: BorderStyle.none, width: 0,
                
              )
            )



          )
          
        ),
        
        
        
        
        
        itemBuilder: (context, Prediction prediction) {
          return const  Row(children: [
            Text("hellooooo"),
          ],);

        }, 
        onSuggestionSelected: (Object? suggestion) {


          }, 
        suggestionsCallback: (String text) async { 
       return await    Get.find<locationcontroller>().searchlocation(context, text);

          
         },
        ),
    ),
  ),

    );
  }
}