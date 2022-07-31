import 'package:flutter/material.dart';
import 'loginScreen.dart';
import 'menuPage.dart';
import 'dart:async';
import 'package:simple_gradient_text/simple_gradient_text.dart';

void main() {
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                LoginScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 550,),
          GradientText('VISION',//textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            colors: [
              Colors.deepPurple,
              Colors.greenAccent,
              Colors.pinkAccent,
              Colors.teal,
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('assets/images/download.jpg'),
        ),
    ),);
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter login UI',
      debugShowCheckedModeBanner: false,
      home:MyHomePage(),
    );
  }
}