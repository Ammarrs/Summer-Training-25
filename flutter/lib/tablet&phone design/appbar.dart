//nada
import 'package:flutter/material.dart';

class AppBarPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Color(0xffFFD3B6)
    ..style = PaintingStyle.fill;
    final paintShadow = Paint()
    ..color = const Color(0xFFDCA47C)
    ..maskFilter = MaskFilter.blur(BlurStyle.solid, 40); 
    final path=Path()
    ..moveTo(0, 0)
    ..lineTo(0, size.height*0.6)
    ..quadraticBezierTo(size.width*0.10,size.height*0.95 ,size.width*0.25 ,size.height*0.75)
    ..quadraticBezierTo(size.width*0.4, size.height*0.45,size.width*0.55 , size.height*0.75)
    ..quadraticBezierTo(size.width*0.75, size.height*1,size.width*1, 0)
    ..lineTo(0, 0)
    ..close()
    ;
    canvas.drawPath(path.shift(Offset(0, 30)), paintShadow);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(AppBarPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(AppBarPainter oldDelegate) => false;
}