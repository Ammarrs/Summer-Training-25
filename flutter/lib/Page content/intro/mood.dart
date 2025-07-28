//nada
import 'package:flutter/material.dart';

class Mooddialog extends StatefulWidget {
  const Mooddialog({super.key, required this.onSelected});
  
  final void Function(String emoji) onSelected;
  @override
  State<Mooddialog> createState() => _MooddialogState();
}

class _MooddialogState extends State<Mooddialog> {
  String? selectedEmoji;
  final List<Map<String, String>> options = [
    {"emoji": "😁", "label": "super"},
    {"emoji": "😀", "label": "cheerful"},
    {"emoji": "😊", "label": "happy"},
    {"emoji": "🙂", "label": "normal"},
    {"emoji": "😓", "label": "tired"},
    {"emoji": "😭", "label": "sad"},
    {"emoji": "🙃", "label": "bored"},
  ];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child:SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text('select your mood', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))
            ),
            SizedBox(
              height: 500,
              child: GridView.builder(
              
                  itemCount: options.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3 ,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ), 
                  itemBuilder:(context,index){
                    final item =options[index];
                    final isSelected = selectedEmoji == item["emoji"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedEmoji = item["emoji"];
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item["emoji"]!,
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(height: 8),
                            Text(
                              item["label"]!,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  } ,
                ),
            ),
            SizedBox(
              child: TextButton(
              onPressed: selectedEmoji == null? null: () {
                widget.onSelected(selectedEmoji!);
                Navigator.of(context).pop();
              },
              child: Text("confirm"),
              style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ),
            )
          ],
        ),
      ) ,
    );
  }
}