import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/study%20info/customcard.dart';
import 'package:tarteeb_app/customes/customboxstudy.dart';

class Studycontant extends StatefulWidget {
  const Studycontant({
    super.key, 
    required this.taskscompleted, 
    required this.completionscore, 
    required this.efficiencyscore, 
    required this.effortscore, 
    required this.finalscore, 
    required this.grade, 
    required this.studyprogress, 
    required this.weak, 
    required this.strong
  });
  final String taskscompleted;
  final String completionscore;
  final String efficiencyscore;
  final String effortscore;
  final String finalscore;
  final String grade;
  final String studyprogress;
  final String weak;
  final String strong;

  @override
  State<Studycontant> createState() => _StudycontantState();
}

class _StudycontantState extends State<Studycontant> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Customboxstudy(
            info: '✅ tasks completed ', 
            result: widget.taskscompleted
          ),
          Customboxstudy(
            info:'completion score' , 
            result: widget.completionscore
          ),
          Customboxstudy(
            info: 'efficiency score', 
            result: widget.efficiencyscore
          ),
          Customboxstudy(
            info:'effort score' , 
            result: widget.effortscore
          ),
          Customboxstudy(
            info:'final score' , 
            result: widget.finalscore
          ),
          Customboxstudy(
            info:'grade' , 
            result: widget.grade
          ),
          Customboxstudy(
            info: 'study progress by subject/chapter/topic', 
            result: widget.studyprogress
          ),
          Customboxstudy(
            info: 'weak areas detected', 
            result:widget.weak 
          ),
          Customboxstudy(
            info:'strong areas detected' , 
            result: widget.strong
          ),

          Text(
            "Tell us the days and hours you want to study",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Customcard(
                subject: 'comp', 
                chapter: 'three'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Customcard(
                subject: 'comp', 
                chapter: 'three'
              ),
            ),
          )
        ],
      )
    );
  }
}