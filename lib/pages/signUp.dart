import 'package:complete_e_commerce_app/common/commonColor.dart';
import 'package:complete_e_commerce_app/common/commonWidget.dart';
import 'package:complete_e_commerce_app/functionality/firebaseDB.dart';
import 'package:complete_e_commerce_app/functionality/sharedDB.dart';
import 'package:complete_e_commerce_app/home.dart';
import 'package:complete_e_commerce_app/models/userModel.dart';
import 'package:complete_e_commerce_app/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final key = GlobalKey<FormState>();
  TextEditingController name = new TextEditingController(),
      email = new TextEditingController(),
      pass = new TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading = false;
  FirebaseDB firebaseDB = new FirebaseDB();
  LocalDB localDB = new LocalDB();

  bool _isLoading = false;
  bool loadingLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          alignment: Alignment.bottomCenter,
          height: MediaQuery.of(context).size.height - 150,
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Register Now",
                  style: simpleTextStyle2(),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  
                  controller: name,
                  style: simpleTextStyle(),
                  decoration: inputDecoration("Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: email,
                  style: simpleTextStyle(),
                  decoration: inputDecoration("Email"),
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
                InkWell(
                  onTap: () {
                    setState(() {
                      _isLoading = true;
                    });

                    firebaseDB
                        .signUpByEmailAndPass(
                            UserModel("",name.text,email.text, pass.text))
                        .then((value) {
                      firebaseDB
                          .uploadUserInfo(UserModel(
                              value.id,name.text, value.email, value.pass))
                          .then((val) {
                              localDB.saveUserInfo(UserModel(
                          value.id, name.text, value.email, value.pass));
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => new Home()));
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
                    child: (_isLoading)
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            color: Colors.white,
                          )
                        : Text(
                            "Submit",
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
                            value.phoneNumber!);
                        localDB.saveUserInfo(userModel).then((value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => new Home()));
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
                            "Sign Up With Google",
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
                      "Already have account,",
                      style: simpleTextStyle(),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => new LoginPage()));
                      },
                      child: Text(
                        "Login Now?",
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
    );
  }
}
