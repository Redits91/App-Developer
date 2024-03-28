import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hrbox/screen/Dashboard.dart';
import 'package:hrbox/screen/Login.dart';
import 'constant/MyPreferences.dart';
import 'constant/color.dart' as color;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: color.primary_color,
        scaffoldBackgroundColor: color.HexColor('#f2f2f2'),
        fontFamily:'poppins',
        appBarTheme: AppBarTheme(color: color.primary_color),
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyPreferences prefernces = new MyPreferences();
  String user_login_id = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen();
    getSharedValue();
  }

  void getSharedValue() async {
    user_login_id = await prefernces.getPreferences(MyPreferences.System_user_login_id);
  }


  @override
  Widget build(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: color.primary_color));
    return Scaffold(
      backgroundColor: color.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(height: 150, width: 150,child: Image(image: AssetImage('assets/hrbox.png',)))
            ],
          ),
          // child: Image(image: AssetImage('assets/hrbox.png')),
        ),
      ),
    );
  }

  void splashScreen() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: color.primary_color));
    await Future.delayed(Duration(milliseconds: 3000), () {});
    if (user_login_id == "") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
    }
  }

}
