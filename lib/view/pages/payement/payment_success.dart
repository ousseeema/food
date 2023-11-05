import 'package:flutter/material.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:get/get.dart';

class payment_success extends StatelessWidget {
  const payment_success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            
             
            children: [

              SizedBox(height: Dimensions.heigth45*1.5,),

               Image.asset("img/done.png"),
               SizedBox(height: Dimensions.heigth20,),
              const  Text("You placed the order successfuly", style: TextStyle(
                fontSize: 20,fontWeight: FontWeight.bold
              ), overflow: TextOverflow.ellipsis,
              maxLines: 1,),
               SizedBox(height: Dimensions.heigth20*2,),
                const  Text("Successful order", style: TextStyle(
                fontSize: 20,color: Colors.grey
              ), overflow: TextOverflow.ellipsis,
              maxLines: 1,),

              SizedBox( height: Dimensions.heigth30*4,),
              GestureDetector(
                onTap: () => Get.toNamed(routeheleper.initaleroute),
                child: Container(
                  height: Dimensions.heigth20*2.5,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
              
              
                  ),
                  child:  const Center(
                    child:  Text(
                      "Back to home", style: TextStyle(
                        color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold
                      ),
                      )
                      ),
              
                ),
              )


            ],),
        )
      ),



    );
  }
}