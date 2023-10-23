import 'package:shared_preferences/shared_preferences.dart';

class localstorage  {

   bool islogin;
   String name ;
   String email ;
   String phone ;
  localstorage({required this.email, required this.islogin, required this.name, required this.phone});




  // setting user infromation to the shared preferences 
  setcorrdonnation()async{
   SharedPreferences   shared =await SharedPreferences.getInstance();
      await shared.setString("name", name);
       await shared.setString("email", email);
       await  shared.setString("phone", phone);
        await shared.setBool("islogin", islogin);

  }
  
  



  // deleteing user info from shared preferences 
   deletecorrdonnation()async{
          SharedPreferences   shared =await SharedPreferences.getInstance();
         shared.setBool("islogin",islogin);
            shared.setString("name", name);
       shared.setString("email", email);
        shared.setString("phone", phone);
    
      }

     
      
     
}