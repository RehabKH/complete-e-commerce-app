// // Avoid errors caused by flutter upgrade.
// // Importing 'package:flutter/widgets.dart' is required.
// import 'package:complete_e_commerce_app/models/cartModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class LocalDB {
//   openDB() async {
//     WidgetsFlutterBinding.ensureInitialized();
// // Open the database and store the reference.
//     final database = openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.
//       join(await getDatabasesPath(), 'cart_database.db'),
//       // When the database is first created, create a table to store dogs.
//       onCreate: (db, version) {
//         // Run the CREATE TABLE statement on the database.
//         return db.execute(
//           'CREATE TABLE cartProducts(id INTEGER PRIMARY KEY, cartProdName TEXT, cartProdPicture TEXT,cartProdPrice DOUBLE,cartProdSize TEXT,cartProdColor TEXT,cartProdQty INTEGER)',
//         );
//       },
//       // Set the version. This executes the onCreate function and provides a
//       // path to perform database upgrades and downgrades.
//       version: 1,
//     );
//     return database;
//   }

//   // Define a function that inserts dogs into the database
//   Future<void> insertDog(CartModel cartModel) async {
//     // Get a reference to the database.
//     final db = await openDB();

//     // Insert the Dog into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same dog is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'cartProducts',
//       cartModel.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

// // A method that retrieves all the dogs from the dogs table.
//   Future<List<CartModel>> cartProducts() async {
//     // Get a reference to the database.
//     final db = await openDB();

//     // Query the table for all The Dogs.
//     final List<Map<String, dynamic>> maps = await db.query('cartProducts');

//     // Convert the List<Map<String, dynamic> into a List<Dog>.
//     return List.generate(maps.length, (i) {
//       return CartModel(
//           maps[i]['id'],
//           maps[i]['cartProdName'],
//           maps[i]['cartProdPicture'],
//           maps[i]['cartProdPrice'],
//           maps[i]['cartProdSize'],
//           maps[i]['cartProdColor'],
//           maps[i]['cartProdQty']);
//     });
//   }
// }
