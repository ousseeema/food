import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:food/helper/localstorage.dart';
import 'package:food/models/cartmodel.dart';
import 'package:food/services/shared.dart';


class database{
  String? Uid;
  database({this.Uid});

// ignore: empty_constructor_bodies
final CollectionReference orderscoll = FirebaseFirestore.instance.collection("orders");
final CollectionReference usercollection = FirebaseFirestore.instance.collection("user");
final CollectionReference addresscollection = FirebaseFirestore.instance.collection("delivery ");
  Future registeruser(String email , String fullname , String phone )async {

        return await usercollection.doc(Uid).set({
          "fullname": fullname,
          "email": email, 
          "phone number": phone,
          "userid": Uid

        });

  }

    Future gettingUserData(email, uid) async {
    QuerySnapshot<Object?> snapshot =
        await usercollection.get();
      if(snapshot.docs.isNotEmpty){
      snapshot.docs.forEach((element) {
        
       if (element.id == uid ){
        print(element["email"]);
            
            localstorage(email: element["email"], islogin: true, name: element["fullname"], phone: element["phone number"]).setcorrdonnation();
            print( shared.getString("name"));
            print(shared.getbool("islogin"));
          }
        
      });
      }
       
      


       
    
          

        
        
      
  }

 
 Future saveaddress(Map addressdetails)async {
   return await addresscollection.add({
    
     "Uid": "${Uid}_${DateTime.now()}",
     "name":addressdetails["name"],
     "phone":addressdetails["phone"],
     "latitude":addressdetails["latitude"],
     "longitude":addressdetails["longitude"],
     "type_address":addressdetails["type_address"],
     "city_name":addressdetails["city_name"],
     "country":addressdetails["country"],
     "state":addressdetails["state"],
     "county":addressdetails["county"],
     "date_de_commande":"${DateTime.now().day} D/${DateTime.now().month} M/${DateTime.now().month} A ",
     "heure_de_commande":"${DateTime.now().hour } H~${DateTime.now().minute } M~${DateTime.now().second } S" 

});


     

 }

 Future saveorder(List<Map<String,dynamic>> order)async{

  await orderscoll.doc(Uid).collection("orders").add({
    
    "order":order,

  });

 }
}