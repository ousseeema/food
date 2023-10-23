import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/controller/popular_product_controller.dart';
import 'package:food/controller/recommanded_food_controller.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/utils/app_constants.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/appcolumn.dart';
import 'package:food/view/widgets/bigtext.dart';
import 'package:food/view/widgets/icon_text_widget.dart';
import 'package:food/view/widgets/smalltext.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.80);
  var _currentpagevalue = 0.0;
  final double _scalefactor = 0.8;
  final double _height = Dimensions.pagheviewconatiner;
  @override
  void initState() {
    // setstate to the current page value wa9et nbadl el pageet eli mawjoudin fi top mtaa page home
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentpagevalue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget _builPageItem(int index, popularproduct) {
    // les tests:
    //1/ ken el container eli fi page view builder = le index alors nkaber
    // le conatiner heki w nsagher ba9i b telle facon el affichage yji azyen
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentpagevalue.floor()) {
      var currscale = 1 - (_currentpagevalue - index) * (1 - _scalefactor);
      var currtrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currentpagevalue.floor() + 1) {
      var currscale =
          _scalefactor + (_currentpagevalue - index + 1) * (1 - _scalefactor);

      var currtrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1);
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else if (index == _currentpagevalue.floor() - 1) {
      var currscale = 1 - (_currentpagevalue - index) * (1 - _scalefactor);

      var currtrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1);
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currtrans, 0);
    } else {
      var currscale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, _height * (1 - _scalefactor) / 2, 1);
    }

    // stack of items
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          // fiha container fi wasetha taswira el maklee w container okhra fi wasetha les details mtaa mkle w waqtresh tousel
          GestureDetector(
            onTap: () {
               Get.toNamed(routeheleper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pagheviewconatiner,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        AppConstants.BASE_URI+AppConstants.uploads_url+popularproduct.img!),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: const Color(0xFF69c5df),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            // container fiha kbira fiha el shadow w kol 
            //w fi wasetha container okhra fiha les details mtaa time w klm w type
            child: Container(
                height: Dimensions.pageviewtextcontainer + 9,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.heigth30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0XFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                    ]),

                // container fiha les commentaire  distance w time w esm makle
                child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.heigth15, left: 15, right: 15),
                    child: appcolumn(text: popularproduct.name!))),
          )
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    //page home fiha container heigth mtaaha 320 fi wasetha page view builder eli trajaa el function
    // buildpage item eli nalgou fi wasetha el stack eli aamlnahom el foug fi awel ppage
    return Column(
      children: [



        //slider section
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          // ken howa loding fi page api nafichhe mn api end point les image w detaisl mtaahom 
          //sinon namml circlar indicatire lin tji response mn serveur ken jet naffichehom 
          return popularProduct.isloading
              ? SizedBox(
                  height: Dimensions.pageview,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProduct.popularproductlist.isEmpty
                          ? 1
                          : popularProduct.popularproductlist.length,
                      itemBuilder: (context, index) {
                        return _builPageItem(
                            index, popularProduct.popularproductlist[index]);
                      }),
                )
              : Container(
                  child: const Center(
                      child: SpinKitHourGlass(
                  color: AppColor.maincolor,
                  size: 70,
                )));
        }),
        
        
        
         //dots



        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularproductlist.isEmpty
                ? 1
                : popularProduct.popularproductlist.length,
            position: _currentpagevalue,
            decorator: DotsDecorator(
                activeColor: AppColor.maincolor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          );
        }),





        // popular text


        SizedBox(
          height: Dimensions.heigth30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              bigtext(text: "Recommanded Food "),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: bigtext(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: smalltext(text: "Food pairing "),
              )
            ],
          ),
        ),




        // list of food and images
          GetBuilder<recommendedProductController>(builder: (recommendedProduct){
            return recommendedProduct.isloading ?  ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommendedProduct.recommendedproductlist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.toNamed(routeheleper.getrecommendedFood(index));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.heigth10),
                  child: Row(
                    children: [
                      //iamge section
                      Container(
                        width: Dimensions.listviewimgSize,
                        height: Dimensions.listviewimgSize,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          image:  DecorationImage(
                              image: NetworkImage(
                           AppConstants.BASE_URI +AppConstants.uploads_url +recommendedProduct.recommendedproductlist[index].img!),
                    fit: BoxFit.cover),
                        ),
                      ),
                      //text container
                      Expanded(
                        child: Container(
                          height: Dimensions.listviewtextcontsize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight:
                                      Radius.circular(Dimensions.radius20)),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                bigtext(text: recommendedProduct.recommendedproductlist[index].name!),
                                SizedBox(
                                  height: Dimensions.heigth10,
                                ),
                                smalltext(text: "with chinese caracteristics"),
                                SizedBox(
                                  height: Dimensions.heigth10,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    iconandtextwidget(
                                        icon: Icons.circle_sharp,
                                        text: "Normal ",
                                        iconcolor: AppColor.iconcolor1),
                                    iconandtextwidget(
                                        icon: Icons.location_on,
                                        text: "1.7Km ",
                                        iconcolor: AppColor.maincolor),
                                    iconandtextwidget(
                                        icon: Icons.access_time_rounded,
                                        text: "32min ",
                                        iconcolor: AppColor.iconcolor2)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            ) 
            
            :

              Container(
                  child: const Center(
                      child: SpinKitHourGlass(
                  color: AppColor.maincolor,
                  size: 70,
                )))
               ;
      
          }),
    
      ],
    );
  }
}
