import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({super.key, required this.screenwidth, required this.text, required this.lottie, required this.screenheight, required this.onPressed});
  final double screenwidth;
  final double screenheight;
  final String text;
  final String lottie;
  final void Function() onPressed;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox( 
      width: screenwidth*0.8 ,
      height: screenheight*0.1,
      child: ElevatedButton(
        style:ElevatedButton.styleFrom(
          backgroundColor:Color(0xffFFD3B6) ,
          shape:RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20) ,
          ) ,
        ),
        onPressed:onPressed ,
        child:Row(
          children: [
            Expanded(child: Text(text,style: TextStyle(color: Color(0xff1E1B73)))),
            Expanded(child: Lottie.asset(lottie))
          ],
        ) ,
      ),
    );
  }
}