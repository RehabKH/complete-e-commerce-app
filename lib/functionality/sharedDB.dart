import 'package:complete_e_commerce_app/models/cartModel.dart';
import 'package:complete_e_commerce_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  // List<String> keyList = ["id", "name", "email", "pass"];


   
  Future<bool> getLoginState() async {
    GoogleSignIn googleSignIn = new GoogleSignIn();
    final firebaseLoginState = await FirebaseAuth.instance.currentUser;
    // print("firebase login state :LLLLLLLLLLLLLLLLLLLL"+ firebaseLoginState!.uid);
    final googleState = await googleSignIn.isSignedIn();
    if(firebaseLoginState == null && !googleState){
      return false;
    }
    else if(firebaseLoginState != null){
      return true;
    }
    else
    // final sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  Future<void> saveUserInfo(UserModel userModel) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("userModel",
        [userModel.id, userModel.name, userModel.email, userModel.pass]);
  }

  Future<List<String>> getUserInfo() async {
    List<String> userData;
    final sharedPreferences = await SharedPreferences.getInstance();
    final resultData = sharedPreferences.getStringList("userModel");

    print("saved Data ::::::::::::::::::" + resultData.toString());
    return resultData??[];
  }
}
