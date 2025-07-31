//nada
import 'package:flutter/material.dart';
import 'package:tarteeb_app/customes/customoptiontile.dart';

class Satisfied extends StatefulWidget {
  const Satisfied({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Satisfied> createState() => _SatisfiedState();
}

class _SatisfiedState extends State<Satisfied> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              child: Text('how satisfied are you with your organization'),
      
            ),
      
            const SizedBox(height: 40),
      
            Customoptiontile(
              emoji: "😎",
              text: "Super satisfied - I'm the organization wizard",
              ontap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              isHighlighted: selectedIndex == 0,
            ),
      
            const SizedBox(height: 12),
      
            Customoptiontile(
              emoji: "😅",
              text:"Room for improvement - I realize my disorganization before the exam.",
              ontap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              isHighlighted: selectedIndex == 1,
            ),
      
            if(selectedIndex==1)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFE7D8),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "💝 You are not alone!\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          "In the YourStep community, thousands of users are like you, working to discover a better version of themselves.",
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
      
            const SizedBox(height: 12),
      
            Customoptiontile(
              emoji: "😢",
              text: "Terrible - I'm a mess when it comes to organizing myself",
              ontap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
              isHighlighted: selectedIndex == 2,
            ),
      
            const SizedBox(height: 30),
      
            if(selectedIndex==2)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFE7D8),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "💝 You are not alone!\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          "In the YourStep community, thousands of users are like you, working to discover a better version of themselves.",
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ),
      
            if(selectedIndex!=null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed:(){
                Navigator.of(context).pop(); 
                widget.onNext();  
              },
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            )
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
//           introview: Satisfied(),
//         ),
//       );
//     });
//     super.initState();
//   }