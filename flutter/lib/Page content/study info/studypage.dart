import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/study%20info/study.dart';
import 'package:tarteeb_app/tablet&phone%20design/custompage.dart';

class Studypage extends StatefulWidget {
  const Studypage({super.key});

  @override
  State<Studypage> createState() => _StudypageState();
}

class _StudypageState extends State<Studypage> {
  @override
  Widget build(BuildContext context) {
    return Custompage(
      appbarcontant:Image.asset('assets/tarteeb.png') , 
      pagecontant: Studycontant(
        taskscompleted: 'bbbb', 
        completionscore: 'nnnnjj', 
        efficiencyscore: 'nnnnn', 
        effortscore: 'jjjjj', 
        finalscore: 'kjkjj', 
        grade: 'hbuh', 
        studyprogress:'jjjjk', 
        weak: 'gghh', 
        strong: 'hhj'
      ),
    );
  }
}