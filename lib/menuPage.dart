import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menuToObjectDetection.dart';
import 'currency.dart';
import 'colorRec.dart';
import 'newcolorrec.dart';
class MenuScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen>{

  Widget buildTakeTestBtn(){
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
      ),
      primary: Colors.white,
      onPrimary: Colors.black12,
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: _launchURLApp,//Navigator.push(context,new MaterialPageRoute(builder: (context)=>new FormScreen())),
        child: Text(
          'Color-blindness test',
          style: TextStyle(
              color: Color.fromRGBO(143, 148, 255, 1),
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
      ),
    );
  }

  Widget buildDetectColorBtn(){
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
      ),
      primary: Colors.white,
      onPrimary: Colors.black12,
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: ()=>Navigator.push(context,new MaterialPageRoute(builder: (context)=>new newcolorrec())),
        child: Text(
          'Color detection',
          style: TextStyle(
              color: Color.fromRGBO(143, 148, 255, 1),
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
      ),
    );
  }

  Widget buildObjectDetectionBtn(){
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
      ),
      primary: Colors.white,
      onPrimary: Colors.black12,
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed:()=> Navigator.push(context,new MaterialPageRoute(builder: (context)=>new MenuScreenToObjDetec())),
        child: Text(
          'Object detection',
          style: TextStyle(
              color: Color.fromRGBO(143, 148, 255, 1),
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
      ),
    );
  }
  Widget buildCurrencyDetectionBtn(){
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      elevation: 5,
      padding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
      ),
      primary: Colors.white,
      onPrimary: Colors.black12,
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed:()=> Navigator.push(context,new MaterialPageRoute(builder: (context)=>new currency())),
        child: Text(
          'Currency recognition',
          style: TextStyle(
              color: Color.fromRGBO(143, 148, 255, 1),
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        //automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(143, 148, 255, 1),
        actions: [],
      ) ,

      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle.light,
        child:GestureDetector(
          child:Stack(
              children:<Widget>[
                Container(
                  height:double.infinity,
                  width:double.infinity,
                  decoration: BoxDecoration(
                      gradient:LinearGradient(
                          begin: Alignment.topCenter,
                          end:Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(143, 148, 251, .4),
                            Color.fromRGBO(143, 148, 251, .6),
                            Color.fromRGBO(143, 148, 251, 0.8),
                          ]
                      )
                  ),
                  child:SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 60),
                        buildTakeTestBtn(),
                        SizedBox(height: 30),
                        buildDetectColorBtn(),
                        SizedBox(height: 30),
                        buildObjectDetectionBtn(),
                        SizedBox(height: 30),
                        buildCurrencyDetectionBtn()
                      ],
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
_launchURLApp() async {
  const url = 'https://enchroma.com/pages/color-blindness-test';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true,enableJavaScript: true);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLBrowser() async {
  const url = 'https://enchroma.com/pages/color-blindness-test';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}