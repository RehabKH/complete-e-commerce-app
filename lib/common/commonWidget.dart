import 'package:complete_e_commerce_app/common/commonColor.dart';
import 'package:flutter/material.dart';


AppBar appBarMain(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text("ECommerce App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
  );
}

InputDecoration inputDecoration(String hint) {
  return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black)),
      hintStyle: TextStyle(color: Colors.black),
      focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black)
          // UnderlineInputBorder(
          //   
            ));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: ColorManager.mainColor, fontSize: 16);
}
TextStyle simpleTextStyle2() {
  return TextStyle(color: ColorManager.mainColor, fontSize: 20,fontWeight: FontWeight.bold);
}
TextStyle textStyleInsideBtn() {
  return TextStyle(color: Colors.white, fontSize: 16);
}
String? validate(String? val) {
  return (val!.isEmpty) || (val.length < 6)? "Please enter valid value length" : null;
}