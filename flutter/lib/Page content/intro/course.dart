//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/customes/customtextfield.dart';

class Courses extends StatefulWidget {
  const Courses({super.key, required this.nocourse});
  final int nocourse;
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  late List<Map<String, dynamic>> coursesData;

  @override
  void initState() {
    super.initState();
    coursesData = List.generate(widget.nocourse, (_) => {
      'name': '',
      'type': 'Memorization',
      'priority': 'Medium',
    });
  }

  bool _allCoursesHaveNames() {
    return coursesData.every((course) => course['name'].trim().isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.nocourse,
                itemBuilder: (context, index) {
                  return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: "Course name",
                          keyboardType: TextInputType.text,
                          onchange: (value) {
                            coursesData[index]['name'] = value;
                            setState(() {}); 
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: coursesData[index]['type'],
                                decoration: const InputDecoration(labelText: 'Type'),
                                items: ['Memorization', 'Understanding']
                                    .map((type) => DropdownMenuItem(
                                          value: type,
                                          child: Text(type),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    coursesData[index]['type'] = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: coursesData[index]['priority'],
                                decoration: const InputDecoration(labelText: 'Priority'),
                                items: ['High', 'Medium', 'Low']
                                    .map((priority) => DropdownMenuItem(
                                          value: priority,
                                          child: Text(priority),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    coursesData[index]['priority'] = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
                },
              ),
            ),
            if (_allCoursesHaveNames())
              ElevatedButton(
                onPressed: () {
                  print("All courses filled. Proceed to next step.");
                  Navigator.of(context).pop();    
                },
                child: const Text("Next"),
              ),
          ],
        ),
    );
  }
}




