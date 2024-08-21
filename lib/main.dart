import 'package:flutter/material.dart';
import 'package:wheather/db/cbservices.dart';
import 'package:wheather/screens/details.dart';
import 'package:wheather/screens/home.dart';
import 'package:wheather/screens/register.dart';
import 'package:wheather/screens/search.dart';
import 'package:wheather/screens/settings.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Dbservice dbservice=Dbservice();
 await dbservice.initialisedb();
  runApp(MaterialApp(
    home: RegisterPage(),
  ));
}


