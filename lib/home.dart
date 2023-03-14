import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_e_commerce_app/components/horizontal_listView.dart';
import 'package:complete_e_commerce_app/components/products.dart';
import 'package:complete_e_commerce_app/functionality/firebaseDB.dart';
import 'package:complete_e_commerce_app/functionality/sharedDB.dart';
import 'package:complete_e_commerce_app/pages/cart.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:complete_e_commerce_app/functionality/cartProvider.dart';
import 'package:complete_e_commerce_app/pages/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseDB firebaseDB = new FirebaseDB();
  LocalDB localDB = new LocalDB();
  List<String> userData = [];
  bool _loading = true;
  QuerySnapshot? allProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localDB.getUserInfo().then((value) {
      setState(() {
        userData = value;
      });
      firebaseDB.getAllProducts().then((value) {
        setState(() {
          _loading = false;
          allProducts = value;
        });
        // print("products result :::::" + allProducts!.docs[0].data()["name"]);
      });
    });
  }
// 1b:78:fd:31:1e:59:4a:7f:f8:42:73:fc:e3:71:c7:e9:7d:33:0e:7a:b4:80:17:6c:d5:47:2b:1e:fb:97:fc:34

// 7a:0e:97:62:a7:a3:97:15:c3:91:d1:c3:a3:3e:5e:62:32:f1:95:74
  @override
  Widget build(BuildContext context) {
    Widget carousel_image = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        indicatorBgPadding: 4.0,
        dotBgColor: Colors.transparent,
        dotSize: 4.0,
        images: [
          AssetImage("images/w1.jpeg"),
          AssetImage("images/w3.jpeg"),
          AssetImage("images/w4.jpeg"),
          AssetImage("images/back.jpg"),
          AssetImage("images/c1.jpg"),
          AssetImage("images/google.png"),
          AssetImage("images/lg.png"),
          AssetImage("images/m1.jpeg"),
          AssetImage("images/m2.jpg"),
        ],
      ),
    );
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
            //   onPressed: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) => new Cart()));
            //   },
            // )
          ],
        ),
        drawer: new Drawer(
          child: (_loading)
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ],
                )
              :
               (userData.length ==0)?
               Container(
                child: Center(
                  child: Text("No Products Found",style: TextStyle(color: Colors.red,
                    fontWeight: FontWeight.bold,fontSize: 17
                  ),),
                ),
               ):
              ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(userData[1]),
                      accountEmail: Text(userData[2]),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: new Icon(
                              Icons.person,
                              color: Colors.white,
                            )),
                      ),
                      decoration: BoxDecoration(color: Colors.red),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=> new Home()));
                        },
                        child: ListTile(
                          title: Text("Home"),
                          leading: Icon(
                            Icons.home,
                            color: Colors.red,
                          ),
                        )),
                    InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text("My account"),
                          leading: Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=> new Cart()));

                        },
                        child: ListTile(
                          title: Text("My Orders"),
                          leading: Icon(
                            Icons.shopping_basket,
                            color: Colors.red,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new Cart()));
                        },
                        child: ListTile(
                          title: Text("Shopping Cart"),
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Colors.red,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=> new Cart()));

                        },
                        child: ListTile(
                          title: Text("Favourites"),
                          leading: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        )),
                    InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text("Setting"),
                          leading: Icon(
                            Icons.settings,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          firebaseDB.signOut().then((value) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (c) => new LoginPage()));
                          });
                        },
                        child: ListTile(
                          title: Text("Logout"),
                          leading: Icon(
                            Icons.help,
                            color: Colors.blue,
                          ),
                        )),
                  ],
                ),
        ),
        body: (_loading)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     Center(
                       child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.red,
                    ),
                     ),
                  ],
                )
             
            : FutureBuilder(
                initialData: allProducts,
                builder: (context, AsyncSnapshot snapshot) {
                 
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                carousel_image,
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(snapshot.data?.docs[index]
                                        .data()["name"])),
                                horizontal_listView(),
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Current Products ")),
                                new Container(
                                  height: MediaQuery.of(context).size.height -
                                      450.0,
                                  child: products(snapshot.data),
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            );
                          })
                      : Container(
                          child: Center(
                            child: Text(
                              "No data found",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                })
        // : ,
        );
  }
}
