import 'package:flutter/material.dart';
import "package:tflite/tflite.dart";
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'tts.dart';


class currency extends StatefulWidget {
  @override
  _currencyState createState() => _currencyState();
}

class _currencyState extends State<currency> {
  File _image;
  List _outputs;
  bool _loading = false;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loading = true;
    speak('Try to capture the notes one by one. Click anywhere to open the camera.');
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Currency Recognition',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
        ),
        backgroundColor: Color.fromRGBO(143, 148, 255, 1),
      ),
      body: _loading
          ? Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null ? Expanded(
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Click anywhere to open the Camera',
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 255, 1),
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ) : GestureDetector(
              //onTap: ()=> Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
              onTap: ()=>  Navigator.push(context,new MaterialPageRoute(builder: (context)=>new currency())),
              child: Column(
                children: [
                  Image.file(_image,height:600),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You got ${_outputs[0]["label"].toString().substring(2)} rupees",
                    style: TextStyle(
                      color: Color.fromRGBO(143, 148, 255, 1),
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
    if (_outputs!=null)
    {speak("You got ${_outputs[0]["label"].toString().substring(2)} rupees.Click anywhere to start again.");

    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}