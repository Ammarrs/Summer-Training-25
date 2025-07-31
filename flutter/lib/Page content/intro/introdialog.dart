//nada
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Introdialog extends StatefulWidget {
  const Introdialog({super.key, required this.introview});
  final Widget introview;
  @override
  State<Introdialog> createState() => _IntrodialogState();
}

class _IntrodialogState extends State<Introdialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: height * 0.8, 
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 0.2*height,
              child: Lottie.asset('assets/ai read.json')
            ),
            Flexible(
              child: widget.introview,
            ),
          ],
        ),
      ),
    );
  }
}