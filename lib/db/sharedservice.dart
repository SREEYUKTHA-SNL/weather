import 'package:shared_preferences/shared_preferences.dart';

class Spservice{
  Future<void> addData(String name,String email,String password,String confirmpassword)async{
final SharedPreferences pref=await SharedPreferences.getInstance();
await pref.setString('name', name);
await pref.setString('email', email);
 await pref.setString('password', password);
 await pref.setString('confirmpassword', confirmpassword);


 }
  Future<Map<String, String?>> getData()async{
   final SharedPreferences pref=await SharedPreferences.getInstance();
   final String?name=pref.getString('name');
   final String?email=pref.getString('email');
   final String?confirmpassword=pref.getString('confirmpassword');

   final String?password=pref.getString('password');
  return {
      'name': name,
      'email': email,
      'password': password,
      'confirmpassword':confirmpassword
    };
  }

}