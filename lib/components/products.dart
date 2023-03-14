import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_e_commerce_app/models/cartModel.dart';
import 'package:complete_e_commerce_app/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:complete_e_commerce_app/pages/productDetaials.dart';

class products extends StatefulWidget {
  var data;
  products(this.data);
  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<products> {
  // var product_list = [
  //   {
  //     "name": "Blazer",
  //     "picture": "images/products/blazer1.jpeg",
  //     "old_price": 120,
  //     "price": 85
  //   },
  //   {
  //     "name": "Dress",
  //     "picture": "images/products/dress2.jpeg",
  //     "old_price": 120,
  //     "price": 85
  //   },
  //   {
  //     "name": "Dress1",
  //     "picture": "images/products/dress1.jpeg",
  //     "old_price": 120,
  //     "price": 200
  //   },
  //   {
  //     "name": "Blazer1",
  //     "picture": "images/products/blazer2.jpeg",
  //     "old_price": 120,
  //     "price": 85
  //   },
  //   {
  //     "name": "Dress",
  //     "picture": "images/products/skt1.jpeg",
  //     "old_price": 120,
  //     "price": 85
  //   },
  //   {
  //     "name": "Dress1",
  //     "picture": "images/products/skt2.jpeg",
  //     "old_price": 120,
  //     "price": 200
  //   },
  //   {
  //     "name": "Blazer1",
  //     "picture": "images/products/hills1.jpeg",
  //     "old_price": 120,
  //     "price": 85
  //   }
  // ];
  @override
  Widget build(
    BuildContext context,
  ) {
    return GridView.builder(
        itemCount: widget.data.docs.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          CartModel productModel = new CartModel(
            "",
            widget.data.docs[index].data()["name"],
            widget.data.docs[index].data()["picture"],
            double.parse(widget.data.docs[index].data()["price"].toString()),
          (widget.data.docs[index].data()["size"].toString()),
            widget.data.docs[index].data()["size"],
          1,
          );
          return Single_prod(productModel, );

          // product_list[index]["name"],
          // product_list[index]["picture"],
          // product_list[index]["old_price"],
          // product_list[index]["price"]);
        });
  }
}

class Single_prod extends StatelessWidget {
  final CartModel productModel;
  // QuerySnapshot productList;
  Single_prod(this.productModel,  );
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: Text("product_name"),
          child: Material(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new ProductDetails(productModel)));
              },
              child: GridTile(
                  footer: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(productModel.cartProdName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0)),
                          Text("\$${productModel.cartProdPrice.toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.red))
                        ],
                      )),
                  child: Image.network(productModel.cartProdPicture)
                  // ,
                  // fit: BoxFit.cover,
                  // ),
                  ),
            ),
          )),
    );
  }
}
