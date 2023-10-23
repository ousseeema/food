// page hedhy fiha les details mtaa recommanbded food 


import 'package:flutter/material.dart';
import 'package:food/controller/popular_product_controller.dart';
import 'package:food/controller/recommanded_food_controller.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/appicon.dart';
import 'package:food/view/widgets/bigtext.dart';
import 'package:food/view/widgets/expandabletext.dart';
import 'package:get/get.dart';

import '../../../controller/cartController.dart';
import '../../utils/app_constants.dart';

class recommandedFoodDetails extends StatelessWidget {
  final int  pageId;
  const recommandedFoodDetails({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<recommendedProductController>().recommendedproductlist[pageId];
   Get.find<PopularProductController>()
        .initproduct(product, Get.find<cartecontroller>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 60,
            title:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const appicon(icon: Icons.clear)),


                 GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                                 if(controller.totalitems! >= 1){
                                  Get.toNamed(routeheleper.getcartpage());
                                 }
                                },
                      child: Stack(
                        children: [
                            const appicon(icon: Icons.shopping_cart_outlined),
                            // if ttal items is more then  1 then nafichi circle 
                            //besh baatali nafichi fiha el number mtaa items
                          Get.find<PopularProductController>().totalitems! >= 1
                              ?  const Positioned
                              (
                                right: 0,
                                top: 0,
                                child:   appicon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColor.maincolor,
                                  ),
                              )
                              : Container(),
                    
                    
                              // ken eli  total items akther mn 0 naffiche el number
                              // eli hkina aaliha fi comm eli gbal hedha khater deja ahna aandna stack najm nrakbhom foug baadhhom
                    
                              controller.totalitems! >= 1
                              ?  Positioned
                              (
                                right: 5,
                                top: 0,
                                child:  bigtext(text: "${controller.totalitems}", size: 12, color: Colors.white,),
                              )
                              : Container(),
                    
                    
                        
                        ],
                      ),
                    );
                  })
              
              ],
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  color: Colors.white,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Center(
                      child: bigtext(size: Dimensions.font16, text:product.name!)),
                )),
            pinned: true,
            backgroundColor: AppColor.yellowcolor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URI +AppConstants.uploads_url + product.img,
                width: double.infinity,
                 fit: BoxFit.cover,)
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: expandableText(
                    text: product.description)
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: Dimensions.width20*2.5, right:Dimensions.width20*2.5, top: Dimensions.heigth10,
            bottom: Dimensions.heigth10 ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.Setquantity(false);
                  },
                  child: appicon(
                    icon: Icons.remove,
                    backgroundColor: AppColor.maincolor,
                    iconColor: Colors.white,
                    iconSize: Dimensions.iconsize24,
                  ),
                ),
                // ignore: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings
                bigtext(text: "\$ ${product.price!} X ${controller.incarteitem}", color: AppColor.mainclackcolor,size: Dimensions.font20,),

                 GestureDetector(
                  onTap: () {
                    controller.Setquantity(true);
                    
                  },
                  child: appicon(
                  icon: Icons.add,
                  backgroundColor: AppColor.maincolor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.iconsize24,
                ),
                 )
                
                
                
              ],
            ),
          ),
           Container(
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
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child:  const Icon(Icons.favorite, color: AppColor.maincolor,)
            ),
            GestureDetector(
              onTap: () {
                controller.additem(product);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.maincolor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                padding: EdgeInsets.only(
                    top: Dimensions.heigth20,
                    bottom: Dimensions.heigth20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: bigtext(
                  text: "\$ ${product.price!} | Add to cart",
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      )
        ],
      );
    
      },)
    );
  }
}
