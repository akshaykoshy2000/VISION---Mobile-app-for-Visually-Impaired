
import 'AuthFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';


Future<User> fetchUser() async{
  if(User._isAuthenticated){
    return User.getCurrentUser();
  } else {
    if(await User.fetchAndAuthUser()){
      return User.getCurrentUser();
    } else {
      throw Exception("Failed to Load User");
    }
  }
}


class User
{
  final int pk;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String contactNo;
  final String locality;
  static User _currentUser;
  static bool _isAuthenticated=true;
  User({
    this.pk,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.contactNo,
    this.locality,
  });

  static User getCurrentUser(){
    return _currentUser;
  }

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      pk:json['pk'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      contactNo: json["contact_no"],
      locality: json["locality"],
    );
  }

  static Future<bool> fetchAndAuthUser() async{
    String HOST_NAME = "django-project-endpoint.herokuapp.com";
    String token = await getToken();
    if(token == null){
      return false;
    }
    final response=await http.get(
      Uri.http(HOST_NAME,'/rest-auth/login/'),
      headers: {HttpHeaders.authorizationHeader: token},
    );
    if(response.statusCode >= 200 && response.statusCode < 300) {
      print("Hello");
      _isAuthenticated = true;
      print(response.body);
      _currentUser = User.fromJson(jsonDecode(response.body));
      return true;
    }
    else {
      _isAuthenticated = false;
      return false;
    }
  }
}

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState()=>_ProfilePageState();

}
class _ProfilePageState extends State<ProfilePage>{
  Future<User> futureAlbum;
  @override
  void initState(){
    super.initState();
    futureAlbum=fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Profile',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, ), textScaleFactor: 1.5,),
        elevation: 1,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            FutureBuilder<User>(
              future: futureAlbum,
              builder: (context,snapshot){
                if (snapshot.hasData)
                {
                  return Container(
                    height:double.infinity,
                    width:double.infinity,
                    decoration: BoxDecoration(
                        gradient:LinearGradient(
                            begin: Alignment.topCenter,
                            end:Alignment.bottomCenter,
                            colors: [
                              Color(0x665ac18e),
                              Color(0x995ac18e),
                              Color(0xcc5ac18e),
                              Color(0xff5ac18e),
                            ]
                        )
                    ),
                    padding: EdgeInsets.only(
                        left: 16,top: 25,right: 16
                    ),
                    child: ListView(
                      children: <Widget>[
                        Text(
                          'First name',
                          style:TextStyle(
                              color:Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height:5),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.badge,color: Colors.black26,),
                                title: Text(snapshot.data.firstName,style: TextStyle(fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Last name',
                          style:TextStyle(
                              color:Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height:5),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.badge,color: Colors.black26,),
                                title: Text(snapshot.data.lastName,style: TextStyle(fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Email',
                          style:TextStyle(
                              color:Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height:5),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.email,color: Colors.black26,),
                                title: Text(snapshot.data.email,style: TextStyle(fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Contact Number',
                          style:TextStyle(
                              color:Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height:5),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.phone,color: Colors.black26,),
                                title: Text(snapshot.data.contactNo,style: TextStyle(fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Locality',
                          style:TextStyle(
                              color:Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height:5),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.house,color: Colors.black26,),
                                title: Text(snapshot.data.locality,style: TextStyle(fontWeight: FontWeight.w500),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if(snapshot.hasError)
                {
                  return Text("${snapshot.error}");
                }
                return Center(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient:LinearGradient(
                              begin: Alignment.topCenter,
                              end:Alignment.bottomCenter,
                              colors: [
                                Color(0x665ac18e),
                                Color(0x995ac18e),
                                Color(0xcc5ac18e),
                                Color(0xff5ac18e),
                              ]
                          )
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: new CircularProgressIndicator(
                          strokeWidth: 5.0,
                          color: Colors.teal,
                        ),
                      ),
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}