import 'package:complete_e_commerce_app/functionality/cartProvider.dart';
import 'package:complete_e_commerce_app/functionality/networkConnectivity.dart';
import 'package:complete_e_commerce_app/functionality/sharedDB.dart';
import 'package:complete_e_commerce_app/pages/loginPage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  //
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

//   Map _source = {ConnectivityResult.none: false};
//   final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
//   String string = '';
//   @override
// void initState() {
//     super.initState();
//     _networkConnectivity.initialise();
//     _networkConnectivity.myStream.listen((source) {
//       _source = source;
//       print('source $_source');
//       // 1.
//       switch (_source.keys.toList()[0]) {
//         case ConnectivityResult.mobile:
//           string =
//               _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
//           break;
//         case ConnectivityResult.wifi:
//           string =
//               _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
//           break;
//         case ConnectivityResult.none:
//         default:
//           string = 'Offline';
//       }
//       // 2.
//       setState(() {});
//       // 3.
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             string,
//             style: TextStyle(fontSize: 30),
//           ),
//         ),
//       );
//     });
//   }
//   @override
//   void dispose() {
//     _networkConnectivity.disposeStream();
//     super.dispose();
//   }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: 
         MaterialApp(
          theme: ThemeData(
              appBarTheme: AppBarTheme(
            backgroundColor: Colors.red,
          )),
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: AppPage(),
        )
      
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  LocalDB localDB = new LocalDB();
  List<String> userData = [];
  bool loginState = false;
  bool loading= true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localDB.getLoginState().then((value) {
      setState(() {
        loading = false;
        loginState = value;
        
      });
    });
    print("loading result :::::::::::::::::::"+loading.toString());
    // localDB.getUserInfo().then((value) {
    //   setState(() {
    //     userData = value;flutter 
    //   });
    //   print("userData:::::::::::::" + value.toString());
    // }); 7A:0E:97:62:A7:A3:97:15:C3:91:D1:C3:A3:3E:5E:62:32:F1:95:74
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        loading ? CircularProgressIndicator(
          color: Colors.red,
          backgroundColor: Colors.white,
        ):
        (!loginState)?LoginPage():Home(),
      ),
    );
  }
}

