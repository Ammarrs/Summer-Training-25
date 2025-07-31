//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/Page%20content/intro/changestudyhours.dart';

class DailyStudyhours extends StatefulWidget {
  const DailyStudyhours({super.key});

  @override
  State<DailyStudyhours> createState() => _DailyStudyhoursState();
}

class _DailyStudyhoursState extends State<DailyStudyhours> {
  final List<Map<String, dynamic>> studyPlan = [
    {"day": "M", "hours": 4},
    {"day": "T", "hours": 4},
    {"day": "W", "hours": 4},
    {"day": "T", "hours": 4},
    {"day": "F", "hours": 4},
    {"day": "S", "hours": 2},
    {"day": "S", "hours": 2},
  ];

  List<String> fullDayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 10,
      children:List.generate(studyPlan.length, (index) {
        return GestureDetector(
          onTap: () async {
            int? newHour = await showDialog(
              context: context,
              builder: (context) => Changestudyhours(
                day: fullDayNames[index],     
                initialhour: studyPlan[index]['hours'],  
              ),
            );
            if (newHour != null) {
              setState(() {
                studyPlan[index]['hours'] = newHour;
              });
            }
          },
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black87,
                child: Text(
                  studyPlan[index]['day'],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 5),
              Text("${studyPlan[index]['hours']}h"),
            ],
          ),
        );

      },)
    );
  }
}