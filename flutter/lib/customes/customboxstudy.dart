import 'package:flutter/material.dart';

class Customboxstudy extends StatefulWidget {
  const Customboxstudy({super.key, required this.info, required this.result});
  final String info;
  final String result;
  @override
  State<Customboxstudy> createState() => _CustomboxstudyState();
}

class _CustomboxstudyState extends State<Customboxstudy> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E1B73),
              border: Border.all(
                color: Colors.black, 
                width: 1.5,
              ),
            ),
            child: Text(
              widget.info,
              style: const TextStyle(
                color: Color(0xFFFFD3B6),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFD3B6),
              border: Border.all(
                color: Colors.black, 
                width: 1.5,
              ),
            ),
            child: Text(widget.result,
              style: const TextStyle(
                color: Color(0xFF1E1B73),  
              ),
            ),
          ),
        ),
      ],
    );
  }
}