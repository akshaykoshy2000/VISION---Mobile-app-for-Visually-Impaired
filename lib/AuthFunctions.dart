import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> setRem(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isRem', value);
}
Future<bool>  getRem() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isRem') ?? false;
}

Future<String> getToken() async{
  final _storage = FlutterSecureStorage();
  return await _storage.read(key: "token");
}

Future<void> saveToken(String token) async{
  final _storage = FlutterSecureStorage();
  await _storage.write(key: "token", value: "Token " + token);
}
Future<void> deleteToken() async{
  final _storage = FlutterSecureStorage();
  await _storage.delete(key: "token");
}