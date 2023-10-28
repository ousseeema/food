import 'package:shared_preferences/shared_preferences.dart';

class shared{
 static  SharedPreferences? pref; 

 static Future<SharedPreferences> init()async{
  pref = await SharedPreferences.getInstance();
 
  return pref!;
 

 }



 static getString(key) {



    return pref!.getString(key)??"XXXX";

 }
 static getbool(key){

  return  pref!.getBool(key)??false ;

 }
  static setaddressname(key, value){
    pref!.setString(key,value);
  }

  // aamltha besh njm nkhtar bin page add address w login fi check out 
  static setaddressexiste(String key , bool value){
    pref!.setBool(key, value);
  }
   static getaddressexiste(String key ){
   return pref!.getBool(key)?? false;
  }
  


 static getlatutide(String key){
    return pref!.getString(key)??"33.8116";
 }
 static getlong(String key){
  return pref!.getString(key)??"10.9875";
 }
 static setlatlang(String key ,String value){
   pref!.setString(key, value);

 }


}