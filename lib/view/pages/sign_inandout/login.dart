import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food/services/authent.dart';
import 'package:food/services/database.dart';
import 'package:food/view/pages/home/homepage.dart';
import 'package:food/view/pages/sign_inandout/signup.dart';
import 'package:food/view/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/appcolor.dart';

class login extends StatefulWidget {
  SharedPreferences? shared;
   login({super.key,  this.shared});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller1 = TextEditingController();
  String? name;
  auth authservices = auth();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : SafeArea(
              // ignore: sized_box_for_whitespace
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 50),
                            ),
                            SizedBox(
                              height: Dimensions.heigth10,
                            ),
                            const Text("Sign into your account ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey)),
                            SizedBox(
                              height: Dimensions.heigth30 * 2,
                            ),
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
                              child: TextField(
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
                              height: Dimensions.heigth20,
                            ),
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
                              child: TextField(
                                 obscureText: true,
                                controller: controller1,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.fingerprint),
                                    label: const  Text("Password :"),
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
                              height: Dimensions.heigth20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Forgot your password?",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.heigth30 * 2,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  var email = controller.text;
                                  var password = controller1.text;
                                  authservices
                                      .login(email, password)
                                      .then((value) async {
                                    if (value == true) {
                                      setState(() {
                                        loading = true;
                                      });

                                      await database().gettingUserData(email, FirebaseAuth.instance.currentUser!.uid);

                                      Get.to(() => const homepage())!
                                          .then((value) {
                                        Future.delayed(
                                            const Duration(seconds: 3), () {
                                          setState(() {
                                            loading = false;
                                          });
                                        });
                                      });

                                      Get.snackbar("Netfication", "All Good",
                                          colorText: Colors.white,
                                          backgroundColor: Colors.green[100],
                                          icon: const Icon(Icons.done));
                                    } else {
                                      Get.snackbar("Erorr",
                                          "You must type your email and password !",
                                          icon: const Icon(Icons.error),
                                          colorText: Colors.white,
                                          backgroundColor: Colors.red,);
                                    }
                                  });
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
                              height: Dimensions.heigth30 * 2 + 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      Dimensions.width30 + Dimensions.width20,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Don 't  have an account? ",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                    children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Get.to(
                                                () => const signuppage(),
                                                transition: Transition.fade),
                                          text: "Create",
                                          style: const TextStyle(
                                              color: AppColor.maincolor,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
