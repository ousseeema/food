import 'package:flutter/material.dart';
import 'package:food/controller/cartController.dart';
import 'package:food/controller/popular_product_controller.dart';
import 'package:food/controller/recommanded_food_controller.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/appicon.dart';
import 'package:food/view/widgets/bigtext.dart';
import 'package:food/view/widgets/nodata%C3%A7_page.dart';
import 'package:food/view/widgets/smalltext.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cartpage extends StatelessWidget {
  const cartpage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //arrow back icons
        Positioned(
            top: Dimensions.heigth20 * 3,
            right: Dimensions.width20,
            left: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: appicon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.maincolor,
                    iconSize: Dimensions.iconsize24,
                  ),
                ),

                // sized box besh el home temshy shway aala el imin
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                //home icons button

                GestureDetector(
                  onTap: () {
                    Get.toNamed(routeheleper.getinitial());
                  },
                  child: appicon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.maincolor,
                    iconSize: Dimensions.iconsize24,
                  ),
                ),

                //shoppingcart icons
                appicon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColor.maincolor,
                  iconSize: Dimensions.iconsize24,
                )
              ],
            )),
         

         GetBuilder<cartecontroller>(builder: (_cartecontroller){
          return _cartecontroller.getitems.isNotEmpty? 
        Positioned(
            top: Dimensions.heigth20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.heigth15),
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,

                  //carte controller to display
                  // the total items and the quantity and the total price

                  child: GetBuilder<cartecontroller>(builder: (cartcontroller) {
                    var _cartlist = cartcontroller.getitems;
                    return ListView.builder(
                        itemCount: _cartlist.length,
                        itemBuilder: (_, index) {



                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: double.maxFinite,
                            height: Dimensions.heigth20 * 5,
                            child: Row(



                              children: [


                                GestureDetector(
                                  onTap: () {
                                    var popularindex = 
                                    Get.find<PopularProductController>().popularproductlist.indexOf(_cartlist[index].product!);
                                    if( popularindex >=0){
                                      Get.toNamed(routeheleper.getPopularFood(popularindex,));

                                    }else {
                                      var recomandedindex = 
                                    Get.find<recommendedProductController>().recommendedproductlist.indexOf(_cartlist[index].product!);
                                         if(recomandedindex<0){
                                           Get.snackbar("History product", "Product review is not available for history products");

                                                        }
                                        else{
                                          Get.toNamed(routeheleper.getrecommendedFood(recomandedindex));

                                          }
                                     
                                    }
                                  },
                                  child: Container(
                                  width: Dimensions.heigth20 * 5,
                                  height: Dimensions.heigth20 * 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              AppConstants.BASE_URI +
                                                  AppConstants.uploads_url +
                                                  cartcontroller
                                                      .getitems[index].img!),
                                          fit: BoxFit.cover)),
                                ),
                                
                                ),



                                SizedBox(
                                  width: Dimensions.width10,
                                ),



                                Expanded(
                                    child: Container(
                                  height: Dimensions.heigth20 * 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      bigtext(
                                        text: cartcontroller
                                            .getitems[index].name!,
                                        color: Colors.black54,
                                      ),
                                      smalltext(text: "spicy"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          bigtext(
                                            text:
                                                "\$ ${cartcontroller.getitems[index].price!}",
                                            color: Colors.redAccent,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: Dimensions.heigth10,
                                                bottom: Dimensions.heigth10,
                                                left: Dimensions.width10,
                                                right: Dimensions.width10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    cartcontroller.addItem(
                                                        _cartlist[index]
                                                            .product!,
                                                        -1);
                                                  },
                                                  child: const Icon(
                                                    Icons.remove,
                                                    color: AppColor.signcolor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10 / 2,
                                                ),
                                                bigtext(
                                                    text: _cartlist[index]
                                                        .quantity!
                                                        .toString()),
                                                SizedBox(
                                                  width: Dimensions.width10 / 2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    cartcontroller.addItem(
                                                        _cartlist[index]
                                                            .product!,
                                                        1);
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: AppColor.signcolor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                              ],
                            ),
                          );
                        });
                  })),
            )
            )
            : const nodata_page(text: "Your cart is empty! ");
     
         })

 ]),
     bottomNavigationBar: GetBuilder<cartecontroller>(
          builder: (cartcontroller) {
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
              child: 
              cartcontroller.getitems.length>0 ?
              Row(
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
                       
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                       
                        bigtext(text: "\$"+cartcontroller.totalamount.toString()),
                       
                       
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                      
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async {
                     
                      SharedPreferences shared = await SharedPreferences.getInstance();
                        
                    

                       if (shared.getBool("islogin") == true) {
                          cartcontroller.addtohistory();
                          Future.delayed(const Duration(milliseconds: 10,),(){
                         // Get.snackbar("Check Out Done ", "Done!");
                         });
                          Get.toNamed(routeheleper.getaddress());
                       }else{
                        Get.toNamed(routeheleper.getsignin());

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
                        text: " | Check Out ",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ): 
              Container(),
            
              
              );
          },
        )
  
    
    );
  }
}
