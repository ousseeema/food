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



}