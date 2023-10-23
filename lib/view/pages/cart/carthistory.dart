import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food/controller/cartController.dart';
import 'package:food/models/cartmodel.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/appicon.dart';
import 'package:food/view/widgets/bigtext.dart';
import 'package:food/view/widgets/nodata%C3%A7_page.dart';
import 'package:food/view/widgets/smalltext.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class cartHistory extends StatelessWidget {
  const cartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // init controller and calling the  function getcarthistorylist
    var getcarthistorylist = Get.find<cartecontroller>().getcarthistorylist().reversed.toList();
    // declaration of a new map
    
    Map<String, int> cartitemsperordze = Map();

    // cette fonction  besh taaml el parcours mtaa list getcarthistorylist eli hiya type mtaaha cartemodel
    // w taaml tester sghyr eli howa ken el date eli fi waset el obj heka mawjouda weele le
    // ken mesh mawjouda nhoutha fi map 3ibara el time howa key w  feme value 1
    //  w ken lgytha date deja fi map besh naamlha update ll value mtaaha w nzyda 1 kol mera nalge object anda nafes el time

    for (int i = 0; i < getcarthistorylist.length; i++) {
      if (cartitemsperordze.containsKey(getcarthistorylist[i].time!)) {
        cartitemsperordze.update(
            getcarthistorylist[i].time!, (value) => ++value);
      } else {
        cartitemsperordze.putIfAbsent(getcarthistorylist[i].time!, () => 1);
      }
    }

    // convert a map of int to a list of int
    List<int> cartitemsperordertolist() {
      return cartitemsperordze.entries.map((e) => e.value).toList();
    }

    List<String> cartordertimetolist() {
      return cartitemsperordze.entries.map((e) => e.key).toList();
    }

    var itemsorder = cartitemsperordertolist();

    var listconter = 0;

    Widget timeWidget(int index) {
    var outputdate= DateTime.now().toString() ;
      if(index< getcarthistorylist.length){
      
                              // fi ligne 1 besh yobligi el date eli jaya mn getcarthistorylist enha tkoun fi forma yyyy-MM-dd 
                              // ligne 2 besh yaaml besh yaaml variable fiha el forma el jdida eli yheb aaliha 
                              // ligne 3 besh y7awel ll date ll forma eli yheb aalia b fonction format 
                              DateTime inputdate= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getcarthistorylist[listconter].time!);
                               
                              var outputformat = DateFormat("MM/dd/yyyy hh:mm a");
                               outputdate =outputformat.format(inputdate);
                             
            
              
      }
         return  bigtext(text: outputdate); 
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.heigth10*10,
            width: double.maxFinite,
            padding:  EdgeInsets.only(top: Dimensions.heigth45),
            color: AppColor.maincolor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bigtext(text: "Cart History", color: Colors.white),
                const appicon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  backgroundColor: AppColor.maincolor,
                  iconSize: 30,
                )
              ],
            ),
          ),

          GetBuilder<cartecontroller>(builder: (cartcontroller){

            return cartcontroller.getcarthistorylist().length >0 ? 
            Container(
              height: MediaQuery.of(context).size.height/1.5,
              child: Expanded(
              child: Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.heigth20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for (int i = 0; i < cartitemsperordze.length; i++)
                          Container(
                            height: Dimensions.heigth30*4,
                            margin: EdgeInsets.only(bottom: Dimensions.heigth20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listconter), 
                            
                                SizedBox(
                                  height: Dimensions.heigth10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                        direction: Axis.horizontal,
                                        children:
                                            List.generate(itemsorder[i], (index) {
                                          if (listconter <
                                              getcarthistorylist.length) {
                                            listconter++;
                                          }
                                          return index <= 2
                                              ? Container(
                                                  height: Dimensions.heigth20*4,
                                                  width: Dimensions.width20*4,
                                                  margin: EdgeInsets.only(
                                                      right:
                                                          Dimensions.width10 / 2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadiusDirectional
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  2),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(AppConstants
                                                                  .BASE_URI +
                                                              AppConstants
                                                                  .uploads_url +
                                                              getcarthistorylist[
                                                                      listconter -
                                                                          1]
                                                                  .img!))),
                                                )
                                              : Container();
                                        })),
                                    Container(
            
                                      height: 80,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          smalltext(text: "Total"),
                                          bigtext(
                                            text: itemsorder[i].toString() +
                                                "Items",
                                            color: AppColor.titlecolor,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                    
                                              var ordertime=cartordertimetolist();
                                              Map<int, CartModel> moreorder ={};
                                     
                                               for(int j = 0 ; j < getcarthistorylist.length; j++) {
                                               
                                                if(getcarthistorylist[j].time! == ordertime[i] ){
                                                  moreorder.putIfAbsent(getcarthistorylist[j].id! , () =>
                                                  CartModel.fromJson(jsonDecode(jsonEncode(getcarthistorylist[j])))
                                                 
                                                   );
                                                   
                                                }
                                               }
                                               Get.find<cartecontroller>().setitems = moreorder;
                                               Get.find<cartecontroller>().addtocartlist();
                                               Get.toNamed(routeheleper.getcartpage()); 
                                              
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Dimensions.width10,
                                                  vertical:
                                                      Dimensions.heigth10 / 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius15 / 3),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColor.maincolor)),
                                              child: smalltext(
                                                text: "One more !",
                                                color: AppColor.maincolor,
                                              ),
                                            ),
                                          )
                                       
                                       
                                       
                                        ],
                                     
                                     
                                      ),
                                   
                                   
                                    ),
                                
                                
                                
                                  ],
                               
                               
                               
                                ),
                              
                              
                              ],
                            
                            
                            
                           
                            ),
                          
                          
                          )
                      ],
                    ),
                  )),
                      ),
            )
            : const Center(child: nodata_page(text: "You didn't buy anything so far ! "));
          })
         
         ],
      ),
    );
  }
}
