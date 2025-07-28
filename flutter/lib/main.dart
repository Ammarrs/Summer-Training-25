//nada
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tarteeb_app/Page%20content/intro/intropage.dart';
import 'package:tarteeb_app/Page%20content/login&rejister/homepage.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notesBox');
  await Hive.openBox('linksBox');
  await Hive.openBox('reminders');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Intropage(), 
      // home: Homepage(
      //   username: 'nada',
      //   img: 'assets/Lemon Spring Shoot!  — Sarah driscoll.jpg', 
      //   isFromLogin:true, 
      //   iswomen: false, 
      // ),
      );  
  }
}
