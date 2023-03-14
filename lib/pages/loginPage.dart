import 'dart:io';

import 'package:complete_e_commerce_app/common/commonColor.dart';
import 'package:complete_e_commerce_app/common/commonWidget.dart';
import 'package:complete_e_commerce_app/functionality/firebaseDB.dart';
import 'package:complete_e_commerce_app/functionality/sharedDB.dart';
import 'package:complete_e_commerce_app/home.dart';
import 'package:complete_e_commerce_app/models/userModel.dart';
import 'package:complete_e_commerce_app/pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  FirebaseDB firebaseDB = new FirebaseDB();
  LocalDB localDB = new LocalDB();
  final key = GlobalKey<FormState>();
  bool _isLoading = false;
  bool loadingLogin = false;
  TextEditingController email = new TextEditingController(),
      pass = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Expanded(
          child: Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height - 150,
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Login Now",
                    style: simpleTextStyle2(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: email,
                    style: simpleTextStyle(),
                    decoration: inputDecoration("email"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: pass,
                    obscureText: true,
                    style: simpleTextStyle(),
                    decoration: inputDecoration("Password"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forget Password?",
                        style: simpleTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isLoading = true;
                      });
                      firebaseDB.getDataByUserEmail(email.text).then((value) {
                        firebaseDB
                            .loginByEmailAndPass(
                                UserModel("", email.text, pass.text, ""))
                            .then((value) {
                          localDB.saveUserInfo(UserModel(
                              value.id, value.name, value.email, value.pass));
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => new Home()));
                        });
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 235, 16, 16),
                            Color.fromARGB(255, 153, 12, 12)
                          ])),
                      child: (_isLoading)?CircularProgressIndicator(
                              backgroundColor: Colors.red,
                              color: Colors.white,
                            ):Text(
                        "Sign In",
                        style: textStyleInsideBtn(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      try {
                        setState(() {
                          loadingLogin = true;
                        });
                        firebaseDB.googleLogin().then((value) {
                          setState(() {
                            loadingLogin = false;
                          });
                          UserModel userModel = new UserModel(
                              value.uid,
                              value.displayName!,
                              value.email!,
                              value.phoneNumber??"123");
                          localDB.saveUserInfo(userModel).then((value) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          });
                          //   HelperFunctions.saveUserLoggedIn(true);
                          //   setState(() {
                          //     _isLoading = false;
                          //   });
                        });
                      } catch (e) {
                        print("http error " + e.toString());
                        Fluttertoast.showToast(
                            msg: e.toString(), backgroundColor: Colors.red);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white),
                      child: (loadingLogin)
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.red,
                              color: Colors.white,
                            )
                          : Text(
                              "Sign In With Google",
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account,",
                        style: simpleTextStyle(),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new SignUp()));
                        },
                        child: Text(
                          "Register Now?",
                          style: TextStyle(
                              color: ColorManager.mainColor,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void isLoggedIn() async {
    setState(() {
      loading = true;
    });
    localDB.getLoginState().then((isLogedIn) {
      if (isLogedIn) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (c) => new Home()));
      }
    });

    setState(() {
      loading = false;
    });
  }
}
