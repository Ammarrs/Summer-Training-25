//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/intro/daily_studyhours.dart';

class Daystudy extends StatefulWidget {
  const Daystudy({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Daystudy> createState() => _DaystudyState();
}

class _DaystudyState extends State<Daystudy> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Tell us the days and hours you want to study",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 10),

          DailyStudyhours(),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); 
              widget.onNext();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Next", style: TextStyle(color: Colors.white)),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}