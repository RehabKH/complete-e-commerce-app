import 'package:badges/badges.dart';
import 'package:complete_e_commerce_app/functionality/cartProvider.dart';
import 'package:complete_e_commerce_app/home.dart';
import 'package:complete_e_commerce_app/models/cartModel.dart';
import 'package:complete_e_commerce_app/models/productModel.dart';
import 'package:complete_e_commerce_app/pages/similar_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:complete_e_commerce_app/pages/cart.dart';


class ProductDetails extends StatefulWidget {
  final CartModel productModel;
  ProductDetails(this.productModel);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // CartProvider cartProvider = new CartProvider();

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping"),
        backgroundColor: Colors.red,
        elevation: 0.1,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.cartList.length == 0
                          ? "0"
                          : value.cartList.length.toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
                child:  IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => new Cart()));
              },
            )
                // child: IconButton(
                //   icon: Icon(Icons.shopping_bag),
                //   color: Colors.white,
                //   onPressed: () {},
                // ),
              ),
            ),
          )

          // IconButton(
          //   icon: Icon(Icons.shopping_cart),
          //   color: Colors.white,
          //   onPressed: () {},
          // )
        ],
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            height: 300,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.productModel.cartProdPicture),
              ),
              footer: new Container(
                color: Colors.white70,
                child: new ListTile(
                  leading: Text(
                    widget.productModel.cartProdName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "${widget.productModel.cartProdPrice}",
                        style: TextStyle(
                          color: Colors.grey,
                          //  decoration:
                        ),
                      )),
                      Expanded(
                          child: Text("${widget.productModel.cartProdPrice}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Size"),
                          content: Text("choose the size "),
                          actions: <Widget>[
                            new MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text("Close"),
                            )
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Size")),
                    Expanded(child: Icon(Icons.arrow_drop_down)),
                  ],
                ),
              )),
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Color"),
                          content: Text("choose the Color "),
                          actions: <Widget>[
                            new MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text("Close"),
                            )
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Color")),
                    Expanded(child: Icon(Icons.arrow_drop_down)),
                  ],
                ),
              )),
              Expanded(
                  child: MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Quantity"),
                          content: Text("choose the quantity "),
                          actions: <Widget>[
                            new MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop(context);
                              },
                              child: Text("Close"),
                            )
                          ],
                        );
                      });
                },
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("Qty")),
                    Expanded(child: Icon(Icons.arrow_drop_down)),
                  ],
                ),
              ))
            ],
          ),
          Row(children: <Widget>[
            Expanded(
                child: MaterialButton(
              onPressed: () {},
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0.2,
              child: Text("Buy Now"),
            )),
            Consumer<CartProvider>(
              builder: (context, value, child) {
                return IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: Colors.red),
                  onPressed: () {
                    //use provider to add to card
                    value.addToList(widget.productModel);
                    print("my cart list ::::::::::::::::::" +
                      value.cartList.toString());
                  },
                );
              },
            ),
            new IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {},
            )
          ]),
          Divider(),
          ListTile(
            title: Text("Product Details"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset "),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:
                    Text("Product Name:", style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.productModel.cartProdName))
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text("Product brand:",
                    style: TextStyle(color: Colors.grey)),
              ),
              Padding(padding: EdgeInsets.all(5.0), child: Text("Brand X"))
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product condition:",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0), child: Text("New"))
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Similar Product:"),
          ),
          Container(
            height: 300.0,
            child: SimilarProduct(),
          )
        ],
      ),
    );
  }
}
