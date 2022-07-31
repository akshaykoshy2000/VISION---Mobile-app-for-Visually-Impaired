import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/realtime/live_camera.dart';
import 'package:object_detection/static%20image/static.dart';
List<CameraDescription> cameras;

Future<void> camPrep() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
}

class MenuScreenToObjDetec extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>_MenuScreenState();
}
class _MenuScreenState extends State<MenuScreenToObjDetec>{


  Widget buildDetecImage(){
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
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => StaticImage(),),);
        },//Navigator.push(context,new MaterialPageRoute(builder: (context)=>new FormScreen())),
        child: Text(
          'Use an image from gallery',
          style: TextStyle(
              color: Color.fromRGBO(143, 148, 255, 1),
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
      ),
    );
  }

  Widget buildDetecCam(){
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
        onPressed: (){
          camPrep();
          Navigator.push(context, MaterialPageRoute(builder: (context) => LiveFeed(cameras),),);
        },//Navigator.push(context,new MaterialPageRoute(builder: (context)=>new FormScreen())),
        child: Text(
          'Live detection',
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
        //title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold),),
        //automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(143, 148, 255, 1),
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
                        buildDetecImage(),
                        SizedBox(height: 30),
                        buildDetecCam(),
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