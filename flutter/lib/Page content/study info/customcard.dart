import 'package:flutter/material.dart';
class Customcard extends StatefulWidget {
  const Customcard({super.key, required this.subject, required this.chapter});
  final String subject;
  final String chapter;
  
  @override
  State<Customcard> createState() => _CustomcardState();
}

class _CustomcardState extends State<Customcard> {
  double progressPercent = 0.0;

 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.subject),
          subtitle: Align(
            alignment: Alignment.topLeft,
            child: Text(widget.chapter),
          ),
        ),
        Slider(
          value: progressPercent,
          min: 0,
          max: 100,
          divisions: 100,
          label: "${progressPercent.toInt()}%",
          onChanged: (value) {
            setState(() {
              progressPercent = value;
            });
          },
        ),
      ],
    );
  }
}