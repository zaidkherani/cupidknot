import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'login2.dart';
import 'package:splashscreen/splashscreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Random User Generator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyApp2(),
      //home: HomePage(),
    );
  }
}

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => new _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Login2(),
      title: Text(
        'Welcome In SplashScreen',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
     loadingText: Text(
       'This is Splash Screen',
       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
     ),
      image: Image.asset(
          'images/Untitled.png',height: 500,width: 500,),
      backgroundColor: Colors.white,
      loaderColor: Colors.red,
    );
  }
}
