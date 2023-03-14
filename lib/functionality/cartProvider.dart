import 'package:complete_e_commerce_app/models/cartModel.dart';
import 'package:complete_e_commerce_app/models/productModel.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  addToList(CartModel myCartItem) {
    _cartList.add(myCartItem);
     _totalPrice += myCartItem.cartProdPrice;
  
    notifyListeners();
  }

    deleteFromList(CartModel myCartItem) {
    _cartList.remove(myCartItem);
     _totalPrice -= myCartItem.cartProdPrice;
  
    notifyListeners();
  }
}
