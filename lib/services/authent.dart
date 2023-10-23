// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/services/database.dart';

class auth {
  FirebaseAuth firebaseauth = FirebaseAuth.instance;

  Future creatinguser(
      String email, String fullname, String phone, String password) async {
    try{
      User user = (await firebaseauth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user!;


        if(user != null){
         await    database(Uid: user.uid).registeruser(email, fullname, phone);

          
          return true ;

     
        }
       
        
 
    }
    catch(e){
      return false;
    }
    


  }


  Future login(String email , String password)async{
    try{
      User user =(await firebaseauth.signInWithEmailAndPassword(email: email, password: password)).user!;
      if(user != null){
        return true ;
      }

    }
    on FirebaseAuthException catch(e){
      return e.message;

    }
  }

Future signout(){
  return  firebaseauth.signOut();
}
  
   

   
}
