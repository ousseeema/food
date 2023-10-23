// page hedhy fiha details mtaa popular food
import 'package:flutter/material.dart';
import 'package:food/controller/cartController.dart';
import 'package:food/controller/popular_product_controller.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/appcolumn.dart';
import 'package:food/view/widgets/appicon.dart';
import 'package:food/view/widgets/expandabletext.dart';
import 'package:get/get.dart';

import '../../utils/appcolor.dart';
import '../../widgets/bigtext.dart';

// ignore: camel_case_types, must_be_immutable
class popularFoodDetails extends StatelessWidget {
  int pageId;
  popularFoodDetails({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularproductlist[pageId];
    Get.find<PopularProductController>()
        .initproduct(product, Get.find<cartecontroller>());
       

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          //background images
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularfoodimgsize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URI +
                            AppConstants.uploads_url +
                            product.img))),
              )),
          // icon widgets
          Positioned(
              top: Dimensions.heigth45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const appicon(
                          icon: Icons.arrow_back_ios, iconSize: 25)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                        if( controller.totalitems! >= 1){
                           Get.toNamed(routeheleper.getcartpage());
                        }
                                
                                },
                      child: Stack(
                        children: [
                            const appicon(icon: Icons.shopping_cart_outlined),
                            // if ttal items is more then  1 then nafichi circle 
                            //besh baatali nafichi fiha el number mtaa items
                          controller.totalitems! >= 1
                              ?  const Positioned
                              (
                                right: 0,
                                top: 0,
                                child:     appicon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColor.maincolor,
                                  ),
                              )
                              : Container(),
                    
                    
                              // ken eli  total items akther mn 0 naffiche el number
                              // eli hkina aaliha fi comm eli gbal hedha khater deja ahna aandna stack najm nrakbhom foug baadhhom
                    
                              Get.find<PopularProductController>().totalitems! >= 1
                              ?  Positioned
                              (
                                right: 5,
                                top: 0,
                                child:  bigtext(text: "${controller.totalitems}", size: 10, color: Colors.white,),
                              )
                              : Container(),
                    
                    
                        
                        ],
                      ),
                    );
                  })
                ],
              )),

          // introduction of foods
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularfoodimgsize - 30,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.heigth20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appcolumn(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimensions.heigth20,
                      ),
                      bigtext(text: "Introduce"),
                      SizedBox(
                        height: Dimensions.heigth20,
                      ),
                      //expandable text widget
                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: expandableText(text: product.description),
                        ),
                      )
                    ],
                  ))),
        ]),

        // container with 2 container inside one for the add to cart and one for the plus and mainaise
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularproduct) {
            return Container(
              height: Dimensions.bottomheight + 5,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.heigth20,
                        bottom: Dimensions.heigth20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            popularproduct.Setquantity(false);
                          },
                          child: const Icon(
                            Icons.remove,
                            color: AppColor.signcolor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        bigtext(text: "${popularproduct.incarteitem}"),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularproduct.Setquantity(true);
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppColor.signcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularproduct.additem(product);

                      Future.delayed(const Duration(seconds: 1), () {
                        Get.snackbar("Operation succeeded ",
                            "Your item has been add to the cart ",
                            icon: const Icon(Icons.done));
                      });
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
                        text: "\$ ${product.price} | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
