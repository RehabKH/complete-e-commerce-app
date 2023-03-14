import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_e_commerce_app/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseDB {
  Future<User> googleLogin() async {
    GoogleSignInAccount? _user;
    GoogleSignIn googleSignIn = new GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    // if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final val = await FirebaseAuth.instance.signInWithCredential(credential);
    return val.user!;
  }

  Future signOut() async {
    GoogleSignIn googleSignIn = new GoogleSignIn();
    try {
      await googleSignIn.disconnect();
      SharedPreferences _pref = await SharedPreferences.getInstance();
      await _pref.remove("userModel");
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadUserInfo(UserModel userModel) async {
    Map<String, dynamic> userInfo = {
      "name": userModel.name,
      "email": userModel.email
    };
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.id)
        .set(userInfo)
        .catchError((e) {
      print("error in save user name and email ::::::::::::::" + e.toString());
    });
  }

  Future getDataByUserID(String userID) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get();
  }

  Future getDataByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  Future getAllProducts() async {
    final result =
        await FirebaseFirestore.instance.collection("products").get();
    print("products result::>>LLLLLLL" + result.docs[0].toString());
    return result;
  }

  Future<UserModel> loginByEmailAndPass(UserModel userModel) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.pass);
      User? user = result.user;

      return UserModel(user!.uid, user.displayName!, user.email!, "");
    } catch (e) {
      print("error sign in::::::::::::::::::" + e.toString());
      return UserModel("", "", "", "");
    }
  }

  Future<UserModel> signUpByEmailAndPass(UserModel userModel) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      print("email :" + userModel.email);
      print("pass :" + userModel.pass);

      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.pass);
      print("user data LLLLL:::::" + result.user.toString());
      User? user = result.user;

      return UserModel(user!.uid, user.displayName ?? "", user.email!, "");
    } catch (e) {
      print("error sign up::::::::::::::::::" + e.toString());
      return UserModel("", "", "", "");
    }
  }
}
