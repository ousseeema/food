import 'package:flutter/material.dart';
import 'package:food/helper/localstorage.dart';
import 'package:food/services/authent.dart';
import 'package:food/view/pages/home/homepage.dart';
import 'package:food/view/pages/sign_inandout/login.dart';
import 'package:food/view/utils/appcolor.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final formkey = GlobalKey<FormState>();
  
  

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.clear();
    controller1.clear();
    controller2.clear();
    controller3.clear();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.maincolor,
              ),
            )
          : SafeArea(
              child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: Dimensions.heigth20 * 10 + 5,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("img/giflogin.gif"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                    top: Dimensions.heigth20 * 10,
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        height: 600,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Form(
                          key: formkey,
                          child: Column(children: [
                            SizedBox(
                              height: Dimensions.heigth20,
                            ),
                            // for email
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 7,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2))
                                  ]),
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.email),
                                    label: const Text("E-mail : "),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!))),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.heigth15,
                            ),

                            //for password
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 7,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2))
                                  ]),
                              child: TextFormField(
                                obscureText: true,
                                controller: controller1,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.fingerprint),
                                    label: const Text("Password : "),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!))),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.heigth15,
                            ),

                            //for name
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 7,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2))
                                  ]),
                              child: TextFormField(
                                controller: controller2,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.person),
                                    label: const Text("Name : "),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!))),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.heigth15,
                            ),

                            //for phone number
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 7,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2))
                                  ]),
                              child: TextFormField(
                                controller: controller3,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.phone),
                                    label: const Text("Phone : "),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                            color: Colors.grey[100]!))),
                              ),
                            ),

                            SizedBox(
                              height: Dimensions.heigth30,
                            ),

                            //buttom signup
                            Center(
                              child: GestureDetector(
                                // this function will test all the controller text entred by the user and if its all good will do the
                                //registration by calling the function register in the auth class if all went good in the registration
                                onTap: () async {
                                  var email = controller.text;
                                  var password = controller1.text;
                                  var name = controller2.text;
                                  var phone = controller3.text;
                                  if (!email.isEmail) {
                                    Get.snackbar("Error", "Email is not valid ",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red,
                                        icon: const Icon(Icons.error));
                                  } else if (password.length < 8) {
                                    Get.snackbar("Error", "Invalid password  ",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red,
                                        icon: const Icon(Icons.error));
                                  } else if (name.isEmpty) {
                                    Get.snackbar("Error", "Name can't be empty",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red,
                                        icon: const Icon(Icons.error));
                                  } else if (phone.length < 8) {
                                    Get.snackbar("Error",
                                        "Phone number must be more then 8 number ",
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red,
                                        icon: const Icon(Icons.error));
                                  } else {
                                    // ken kol shy s7i7 naaml nbdl value mtaa loading besh nafiche circulaire progre indica
                                    setState(() {
                                      loading = true;
                                    });
                                    // naaaml lenregistrement mtaa utilisateur fi firebase cloud
                                    await auth()
                                        .creatinguser(
                                            email, name, phone, password)
                                        .then((value) {
                                      if (value) {
                                        // if value equals to true besh yaaml (yani enregistrement  done ) snack bar  w baatali yaaml les corrdonnee fi shared preferences
                                        // w mbaaed aamlna future delayed besh nbadl variable loadiing b setstate ll false
                                        Get.snackbar("Verification ",
                                            "your account has been created ",
                                            colorText: Colors.white,
                                            backgroundColor: Colors.green[200],
                                            icon: const Icon(Icons.done));

                                        localstorage(email: email, islogin: true, name: name, phone:phone ).setcorrdonnation();

                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          setState(() {
                                            loading = false;
                                          });
                                        });

                                        Get.to(() => const homepage());
                                      } else {
                                        setState(() {
                                          loading = false;
                                        });
                                        Get.snackbar(
                                            "Error", "User is already existe",
                                            colorText: Colors.white,
                                            backgroundColor: Colors.red,
                                            icon: const Icon(Icons.error));
                                      }
                                    });
                                  }
                                },
                                child: Container(
                                  height: Dimensions.heigth45 + 5,
                                  width: Dimensions.width30 * 6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(23),
                                      color: AppColor.maincolor),
                                  child: const Center(
                                      child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.heigth15,
                            ),

                            GestureDetector(
                                onTap: () {
                                  Get.to( login());
                                },
                                child: Center(
                                    child: Text(
                                  "Have an account already? ",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[500]),
                                ))),
                            SizedBox(
                              height: Dimensions.heigth20 + 10,
                            ),
                            Center(
                                child: Text(
                              "Sign up usong one of the following methodes  ",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[500]),
                            )),
                            SizedBox(
                              height: Dimensions.heigth15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("img/face.png"),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Image.asset("img/twitter.png"),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Image.asset("img/google.png")
                              ],
                            )
                          ]),
                        )))
              ]),
            )),
    );
  }
}
