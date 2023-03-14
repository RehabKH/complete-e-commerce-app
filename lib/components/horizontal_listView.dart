import 'package:flutter/material.dart';

class horizontal_listView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: new ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          category(image_location: "images/cats/tshirt.png",image_caption: "shirt"),
          category(image_location: "images/cats/accessories.png",image_caption: "acces"),
          category(image_location: "images/cats/dress.png",image_caption: "dress"),
          category(image_location: "images/cats/informal.png",image_caption: "informal"),
          category(image_location: "images/cats/jeans.png",image_caption: "jeans"),
          category(image_location: "images/cats/shoe.png",image_caption: "shoe"),

        ],
      ),
      
    );
  }
}

class category extends StatelessWidget {
  final String? image_location;
  final String? image_caption;
   category({this.image_location,this.image_caption});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(onTap: (){},
      child: Container(
        width: 100.0,
              child: ListTile(
          title: Image.asset(image_location!,width: 100.0,height:80.0),
         subtitle: Container(
           alignment: Alignment.topCenter,
           child:Text(image_caption!)
         ),
        ),
      ),
    ));
  }
}