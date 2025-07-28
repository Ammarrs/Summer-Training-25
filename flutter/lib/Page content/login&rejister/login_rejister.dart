//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/login&rejister/login.dart';
import 'package:tarteeb_app/Page%20content/login&rejister/rejister.dart';
import 'package:tarteeb_app/tablet&phone%20design/custompage.dart';

class Loginrejisterpage extends StatefulWidget {
  const Loginrejisterpage({super.key});

  @override
  State<Loginrejisterpage> createState() => _LoginrejisterpageState();
}

class _LoginrejisterpageState extends State<Loginrejisterpage> {
  bool islogin=false;
  
  @override
  Widget build(BuildContext context) {
    return Custompage(
      appbarcontant:SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/tarteeb.png',fit: BoxFit.contain)
      ), 
      pagecontant: SingleChildScrollView(
        child:  islogin? Login():Rejister()
      ),
      bottomNavigationBar:BottomAppBar(
        color: Color(0xFFFFD3B6),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              islogin ? "for rejister" : "for login",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF1E1B73)
              ),
            ),
            Switch(
              value: islogin,
              onChanged: (value) {
              setState(() {
              islogin = value;
              });
              },
              activeColor: const Color(0xFFDCA47C), 
              activeTrackColor: const Color(0xFF1E1B73), 
              inactiveThumbColor: const Color(0xFFDCA47C), 
              inactiveTrackColor: const Color(0xFF1E1B73),  
            )
          ],
        ), 
      ) ,
    );
  }
}