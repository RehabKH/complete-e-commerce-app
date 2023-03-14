import 'package:complete_e_commerce_app/components/products.dart';
import 'package:complete_e_commerce_app/models/cartModel.dart';
import 'package:complete_e_commerce_app/models/productModel.dart';
import 'package:flutter/material.dart';

class SimilarProduct extends StatefulWidget {
  @override
  _SimilarProductState createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  var product_list = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Dress1",
      "picture": "images/products/dress1.jpeg",
      "old_price": 120,
      "price": 200
    },
  ];

  /// get products from firestore depened on type of current product
  List<CartModel> productList =
      [new CartModel(
        "","dress", 
        "https://m.media-amazon.com/images/I/415j31CMYCS._AC_SY741_.jpg", 600, 
        "", "Small", 1)];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Single_prod(
             productList[index]);
        });
  }
}
