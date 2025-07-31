//nada
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Studyprofile extends StatefulWidget {
  const Studyprofile({super.key, required this.onNext});
  final void Function(int subjectCount) onNext;

  @override
  State<Studyprofile> createState() => _StudyprofileState();
}

class _StudyprofileState extends State<Studyprofile> {
  String? studySpeed;
  double preferenceSlider = 0.5;
  double selfRating = 3;
  String? sessionType;
  int subjectCount = 5;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text('study profile'),
            ),
      
            const SizedBox(height: 20),
      
            Text('select your study speed?',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
      
      
            Wrap(
              spacing: 10,
              children: ['Slow', 'Average', 'Fast'].map((speed) {
                return ChoiceChip(
                  label: Text(speed),
                  selected: studySpeed == speed,
                  onSelected: (_) {
                    setState(() {
                      studySpeed = speed;
                    });
                  },
                );
              }).toList(),
            ),
      
            const SizedBox(height: 10),
      
            const Text('Determine your level of love for memorization and understanding',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
      
            Slider(
              value: preferenceSlider,
              onChanged: (val) {
                setState(() {
                  preferenceSlider = val;
                });
              },
              min: 0,
              max: 1,
              divisions: 10,
              label: preferenceSlider < 0.5 ? 'Memorization' : (preferenceSlider > 0.5 ? 'Understanding' : 'Balanced'),
            ),
      
            const SizedBox(height: 10),
      
            const Text('rate yourself as a student',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
      
            RatingBar.builder(
              initialRating: selfRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                setState(() {
                  selfRating = rating;
                });
              },
            ),
      
            const SizedBox(height: 10),
      
            const Text('your preferred study session style...',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            
            Wrap(
              spacing: 10,
              children: ['Continuous', 'Interrupted'].map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: sessionType == type,
                  onSelected: (_) {
                    setState(() {
                      sessionType = type;
                    });
                  },
                );
              }).toList(),
            ),
      
            const SizedBox(height: 10),
      
            const Text('How many subjects are you studying?',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
      
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: subjectCount.toDouble(),
                    min: 1,
                    max: 12,
                    divisions: 11,
                    label: '$subjectCount',
                    onChanged: (val) {
                      setState(() {
                        subjectCount = val.toInt();
                      });
                    },
                  ),
                ),
                Text('$subjectCount subjects'),
              ],
            ),
      
            const SizedBox(height: 40),
      
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Study Speed: $studySpeed');
                  print('Preference: ${preferenceSlider < 0.5 ? 'Memorization' : (preferenceSlider > 0.5 ? 'Understanding' : 'Balanced')}');
                  print('Rating: $selfRating');
                  print('Session Type: $sessionType');
                  print('Subjects: $subjectCount');

                  Navigator.of(context).pop(); 
                  widget.onNext(subjectCount);
                },
                child: const Text('next'),
              ),
            ),
      
          ],
        ),
      ),
    );
  }
}





// @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (_) =>Introdialog(
//           introview: Studyprofile(),
//         ),
//       );
//     });
//     super.initState();
//   }