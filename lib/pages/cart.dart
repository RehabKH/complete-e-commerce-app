import 'package:complete_e_commerce_app/components/cart_products.dart';
import 'package:complete_e_commerce_app/functionality/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping"),
        backgroundColor: Colors.red,
        elevation: 0.1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {},
          ),
          //  IconButton(icon: Icon(Icons.shopping_cart),color: Colors.white,onPressed: (){
          //  },)
        ],
      ),
      body: CartProduct(),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, value, child) {
          return Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Text("Total"),
                    subtitle: Text("\$"+ value.totalPrice.toString()),
                  )),
                  Expanded(
                      child: MaterialButton(
                          color: Colors.red,
                          onPressed: () {},
                          child: Text("Check Out",
                              style: TextStyle(color: Colors.white))))
                ],
              ));
        },
      ),
    );
  }
}
