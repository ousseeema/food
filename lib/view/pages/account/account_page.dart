import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food/controller/cartController.dart';
import 'package:food/helper/localstorage.dart';
import 'package:food/routes/route_helper.dart';
import 'package:food/services/authent.dart';
import 'package:food/services/shared.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:food/view/widgets/appicon.dart';
import 'package:food/view/widgets/bigtext.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
class accountpage extends StatefulWidget {
  SharedPreferences? shared1;
   accountpage({super.key ,  this.shared1});
  

  @override
  State<accountpage> createState() => _accountpageState();
}

class _accountpageState extends State<accountpage> {


  
    


 
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: bigtext(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColor.maincolor,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.heigth20,
            ),
            width: double.maxFinite,
            child: appicon(
              icon: Icons.person,
              backgroundColor: AppColor.maincolor,
              iconColor: Colors.white,
              iconSize: Dimensions.heigth15 * 8 - 5,
              size: Dimensions.heigth15 * 10,
            ),
          ),
          SizedBox(
            height: Dimensions.heigth20 * 2,
          ),
          Expanded(
            child: SingleChildScrollView(
              
              child: Column(children: [
                // this row inside the conatiner  is for info name (user name)
                Container(
                  width: Dimensions.width30 * 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColor.maincolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1, 10),
                          blurRadius: 10,
                          spreadRadius: 7,
                        ),
                      ]),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.maincolor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        width: Dimensions.width20 * 3,
                        height: Dimensions.heigth20 * 3,
                        child: const Icon(Icons.person),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                       Text(shared.getbool("islogin")? shared.getString("name"): "User Name")
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.heigth20,
                ),
              
                // this is for email addresses
                Container(
                  width: Dimensions.width30 * 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColor.maincolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1, 10),
                          blurRadius: 10,
                          spreadRadius: 7,
                        ),
                      ]),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.maincolor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        width: Dimensions.width20 * 3,
                        height: Dimensions.heigth20 * 3,
                        child: const Icon(Icons.email),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                       Text(shared.getbool("islogin") ? shared.getString("email")! : "email address")
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.heigth20,
                ),
              
                // this is for phone number
                Container(
                  width: Dimensions.width30 * 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColor.maincolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1, 10),
                          blurRadius: 10,
                          spreadRadius: 7,
                        ),
                      ]),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.maincolor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        width: Dimensions.width20 * 3,
                        height: Dimensions.heigth20 * 3,
                        child: const Icon(Icons.phone_android),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                       Text(shared.getbool("islogin") ?shared.getString("phone")! : "Phone Number"),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.heigth20,
                ),
                // this is for adress 
                 Container(
                  width: Dimensions.width30 * 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColor.maincolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1, 10),
                          blurRadius: 10,
                          spreadRadius: 7,
                        ),
                      ]),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.maincolor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        width: Dimensions.width20 * 3,
                        height: Dimensions.heigth20 * 3,
                        child: const Icon(Icons.location_on),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                       Text((shared.getbool("islogin") ? "Djerba" : "Fill in your adress")),
                    ],
                  ),
                ),
                   SizedBox(
                  height:Dimensions.heigth20,
                ),
                // this is for messenging 

                 Container(
                  width: Dimensions.width30 * 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColor.maincolor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1, 10),
                          blurRadius: 10,
                          spreadRadius: 7,
                        ),
                      ]),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.maincolor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        width: Dimensions.width20 * 3,
                        height: Dimensions.heigth20 * 3,
                        child: const Icon(Icons.message),
                      ),
                      SizedBox(
                        width: Dimensions.width20,
                      ),
                      const Text("Messege me"),
                    ],
                  ),
                ),
                
                        SizedBox(
                  height: Dimensions.heigth20,
                ),
                // this is for logout 
                 GestureDetector(

                  onTap: () async{
                    if(shared.getbool("islogin")== true){
                      localstorage(email: "User@exmpl.com", islogin: false, name: "User", phone: "Phone Number").deletecorrdonnation();
                         
                          Get.find<cartecontroller>().clear();
                          Get.find<cartecontroller>().clearcarhistory();                        
                          auth().signout();
                          print("signout");
                           Get.toNamed(routeheleper.initaleroute);
                          
                      


                    }else{
                      Get.snackbar("Error", " You have to be logged in to log out ");
                    }
                   
                  


                    
                  },
                   child: Container(
                    width: Dimensions.width30 * 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColor.maincolor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(1, 10),
                            blurRadius: 10,
                            spreadRadius: 7,
                          ),
                        ]),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.width20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.maincolor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          width: Dimensions.width20 * 3,
                          height: Dimensions.heigth20 * 3,
                          child: const Icon(Icons.logout),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        ),
                        const Text("Log Out  "),
                      ],
                    ),
                                 ),
                 ),
              
                


                
              ]),
            ),
          )
        ],
      ),
    );
  }
}
