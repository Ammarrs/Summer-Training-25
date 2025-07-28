//nada
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tarteeb_app/Page%20content/login&rejister/login_rejister.dart';

class Intropage extends StatefulWidget {
  const Intropage({super.key});

  @override
  State<Intropage> createState() => _IntropageState();
}

class _IntropageState extends State<Intropage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginrejisterpage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: LottieBuilder.asset('assets/Cat feeling love emotionsexpression. Emojisticker animation.json')
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/robot intro.png')
          )
        ],
      ),
    );
  }
}