class CartModel {
  String id;
  String cartProdName;
  String cartProdPicture;
  double cartProdPrice;
  String cartProdSize;
  String cartProdColor;
  int cartProdQty;
  CartModel(
      this.id,
      this.cartProdName,
      this.cartProdPicture,
      this.cartProdPrice,
      this.cartProdSize,
      this.cartProdColor,
      this.cartProdQty);

  CartModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        cartProdName = res["cartProdName"],
        cartProdPicture = res["cartProdPicture"],
        cartProdPrice = res["cartProdPrice"],
        cartProdSize = res["cartProdSize"],
        cartProdColor = res["cartProdColor"],
        cartProdQty = res["cartProdQty"];
Map<String,dynamic> toMap(){
  return {
    "id":id,
    "cartProdName": cartProdName,
    "cartProdPicture":cartProdPicture,
    "cartProdPrice":cartProdPrice,
    "cartProdSize" :cartProdSize,
    "cartProdColor":cartProdColor,
    "cartProdQty":cartProdQty

  };
}
 @override
  String toString() {
    return 'CartModel{id: $id, cartProdName: $cartProdName, cartProdPicture: $cartProdPicture}';
  }
}
