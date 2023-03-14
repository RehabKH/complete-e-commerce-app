import 'package:complete_e_commerce_app/functionality/cartProvider.dart';
import 'package:complete_e_commerce_app/models/cartModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  var products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
      "size": "M",
      "color": "black",
      "quality": 2
    },
    {
      "name": "Shoes",
      "picture": "images/products/hills1.jpeg",
      "old_price": 120,
      "price": 85,
      "size": "7",
      "color": "red",
      "quality": 1
    },
  ];
  // CartProvider cartProvider =  CartProvider();

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartProvider>(context);
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        print("cart length ::::::::::::::::::" +
            value.cartList.length.toString());
        return ListView.builder(
          itemCount: value.cartList.length,
          itemBuilder: (context, index) {
            // List<CartModel> cartModel = cartProvider.cartList;
            // print("cart list"+cartModel[0].toString());
            // CartModel c = CartModel(
            //   (products_on_the_cart[index]["name"].toString()),
            //   products_on_the_cart[index]["name"].toString(),
            //   products_on_the_cart[index]["picture"].toString(),
            //   double.parse(products_on_the_cart[index]["price"].toString()),
            //   products_on_the_cart[index]["size"].toString(),
            //   products_on_the_cart[index]["color"].toString(),
            //   int.parse(products_on_the_cart[index]["quality"].toString()),
            // );
            return SingleCartProduct(value.cartList[index]);
          },
        );
      },
    );
  }
}

class SingleCartProduct extends StatefulWidget {
  CartModel cartModel;

  SingleCartProduct(this.cartModel);

  @override
  State<SingleCartProduct> createState() => _SingleCartProductState();
}

class _SingleCartProductState extends State<SingleCartProduct> {
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) {
        return Card(
            child: ListTile(
          trailing: InkWell(
            onTap: () {
              value.deleteFromList(widget.cartModel);
               
            },
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  "x",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // leading: Image.asset(widget.cartModel.cartProdPicture,
          //     height: 80.0, width: 80.0),
          title: Text(widget.cartModel.cartProdName),
          subtitle: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Size:"),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.cartModel.cartProdSize,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                    child: Text("Colors:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.cartModel.cartProdColor,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "\$${widget.cartModel.cartProdPrice}",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ))
            ],
          ),
          // trailing: Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: EditableText(
          //       controller: quantityController,
          //       focusNode: FocusNode(),
          //       style:
          //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //       cursorColor: Colors.black87,
          //       backgroundCursorColor: Colors.transparent),
          // )
          // Column(
          //   children: <Widget>[
          //     IconButton(
          //       icon: Icon(Icons.arrow_drop_up),
          //       onPressed: () {},
          //     ),
          //     Text("${cartModel.cartProdQty.toString()}"),
          //     IconButton(
          //       icon: Icon(Icons.arrow_drop_down),
          //       onPressed: () {},
          //     )
          //   ],
          // ),
        ));
      },
    );
  }
}
