import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'FadeAnimation.dart';
import 'loginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword1 = true;
  bool hidePassword2 = true;
  SignUpRequestModel signupRequestModel;
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
    signupRequestModel = new SignUpRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: signupuiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 1,
      color: Colors.white,
    );
  }

  Widget buildEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                ]),
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              key:Key("emailReg"),
              onSaved: (input) => signupRequestModel.email = input,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email, color: Colors.black26),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                ]),
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              key:Key("pwd1Reg"),
              obscureText: hidePassword1,
              onSaved: (input) => signupRequestModel.password1 = input,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Colors.black26),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black38),
                suffixIcon: IconButton(
                  icon: Icon(
                      hidePassword1 ? Icons.visibility_off : Icons.visibility),
                  color: Colors.black26,
                  onPressed: () {
                    setState(() {
                      hidePassword1 = !hidePassword1;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildConfirmPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                ]),
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              key:Key("pwd2Reg"),
              obscureText: hidePassword2,
              onSaved: (input) => signupRequestModel.password2 = input,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Colors.black26),
                hintText: 'Confirm Password',
                hintStyle: TextStyle(color: Colors.black38),
                suffixIcon: IconButton(
                  icon: Icon(
                      hidePassword2 ? Icons.visibility_off : Icons.visibility),
                  color: Colors.black26,
                  onPressed: () {
                    setState(() {
                      hidePassword2 = !hidePassword2;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
      width: double.infinity,
      key:Key("signupReg"),
      child: ElevatedButton(
        onPressed: () {
          if (validateAndSave()) {
            setState(() {
              isApiCallProcess = true;
            });
            APIservice apiService = new APIservice();
            apiService.signup(signupRequestModel).then((value) {
              if (value != null) {
                setState(() {
                  isApiCallProcess = false;
                });
                print(value.token);
                if (value.statusCode >= 200 && value.statusCode < 300) {

                  final snackBar = SnackBar(content: Text("Sign up successful!!!"));
                  ScaffoldMessenger.of(context).showSnackBar((snackBar));
                  Navigator.push(context,new MaterialPageRoute(builder: (context)=>new LoginScreen()));
                } else {
                  final snackBar = buildErrorSnackBtn(value.error);
                  ScaffoldMessenger.of(context).showSnackBar((snackBar));
                }
              }
            });
            print(signupRequestModel.toJson());
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          onPrimary: Colors.black12,
          primary: Color.fromRGBO(143, 148, 251, 1),
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          'SIGN UP',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: 'Login',
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  Widget signupuiSetup(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [
              //           Color(0x44ff0000),
              //           Color(0x66ff0000),
              //           Color(0x99ff0000),
              //           Color(0xccff0000),
              //         ])),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                //padding: EdgeInsets.symmetric(horizontal: 25, vertical: 65),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/background.png'),
                                fit: BoxFit.fill
                            )
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 30,
                              width: 80,
                              height: 200,
                              child: FadeAnimation(1, Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/light-1.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              left: 140,
                              width: 80,
                              height: 150,
                              child: FadeAnimation(1.3, Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/light-2.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              right: 40,
                              top: 40,
                              width: 80,
                              height: 150,
                              child: FadeAnimation(1.5, Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/clock.png')
                                    )
                                ),
                              )),
                            ),
                            Positioned(
                              child: FadeAnimation(1.6, Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                                ),
                              )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      // buildFirstName(),
                      // buildLastName(),
//                          buildUsername(),
                      buildEmail(),
                      buildPassword(),
                      buildConfirmPassword(),
                      // buildContactNo(),
                      // buildLocality(),
                      buildSignUpBtn(),
                      buildLoginBtn(),
                      SizedBox(height: 250,)
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      final emptyMsg = signupRequestModel.checkifEmpty();
      if (emptyMsg.isNotEmpty) {
        final snackBar = buildErrorSnackBtn(emptyMsg);
        ScaffoldMessenger.of(context).showSnackBar((snackBar));
        return false;
      }
      return true;
    } else {
      return false;
    }
  }
}

class APIservice {
  Future<SignUpResponseModel> signup(
      SignUpRequestModel signupRequestModel) async {
    String HOST_NAME = "django-project-endpoint.herokuapp.com";
    try {
      final response = await http.post(Uri.http(HOST_NAME, "/rest-auth/registration/"),
          body: signupRequestModel.toJson()).timeout(
          const Duration(seconds: 10));
      print(response.statusCode);
      print(response.body);
      if ((response.statusCode >= 200 && response.statusCode < 300) ||
          response.statusCode == 400) {
        return SignUpResponseModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        throw Exception('Failed to load data');
      }
    } on TimeoutException catch (e){
      return SignUpResponseModel(error: "Connection Time out", statusCode: 500);
    } on SocketException catch (e) {
      return SignUpResponseModel(error: "Connection Time out", statusCode: 500);
    } catch(e) {
      return SignUpResponseModel(error: e.toString(), statusCode: 500);
    }
  }
}

class SignUpResponseModel {
  final String token;
  final String error;
  int statusCode;
  SignUpResponseModel({this.token, this.error, this.statusCode});
  factory SignUpResponseModel.fromJson(Map<String, dynamic> json,
      [int statusCode = 200]) {
    String errorMsg = "";
    if (json["non_field_errors"] != null) {
      errorMsg = json["non_field_errors"][0];
    } else if (json["email"] != null) {
      errorMsg = json["email"][0];}
       else if (json["password1"] != null) {
      json["password1"].forEach((s) => errorMsg += (s + "\n"));
//      errorMsg = json["password1"][0];
    } else if (json["password2"] != null) {
      errorMsg = json["password2"][0];
    } else if (json["password"] != null) {
      errorMsg = json["password"][0];
    }
    return SignUpResponseModel(
        token: json["key"] != null ? json["key"] : "",
        error: errorMsg != null ? errorMsg : "",
        statusCode: statusCode ?? 200);
  }
}

class SignUpRequestModel {
//  String username;

  String email;
  String username;
  String password1;
  String password2;

  SignUpRequestModel({
    // ignore: non_constant_identifier_names

    this.email,
    this.username,
    this.password1,
    this.password2,
  });

  String checkifEmpty() {
        if (!email.contains("@")) {
      return "Enter a valid email";
    } else if (password1.isEmpty) {
      return "Enter a password";
    } else if (password2.isEmpty) {
      return "Confirm password";
    }
    return "";
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': email.trim(),
      //'email': email.trim(),
      'password1': password1.trim(),
      'password2': password2.trim(),
    };
    return map;
  }
}



SnackBar buildErrorSnackBtn(String str){
  return SnackBar(
    content: Text(str,
        key:Key("errorReg"),
        style: const TextStyle(
            fontSize:17,
            fontWeight: FontWeight.bold)
    ),
    backgroundColor: Colors.red,
  );
}

class ProgressHUD extends StatelessWidget{
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;
  ProgressHUD({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity=0.0,
    this.color=Colors.white,
    this.valueColor,
  }):super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList=[];
    widgetList.add(child);
    if(inAsyncCall){
      return Stack(
        children: [
          new Opacity(opacity: opacity,child:ModalBarrier(dismissible:false,color:color),),
          new Center(
              child: new CircularProgressIndicator(color: Color.fromRGBO(143, 148, 255, 1),)
          ),
        ],
      );
    }
    return Stack(
      children: widgetList,
    );
  }
}