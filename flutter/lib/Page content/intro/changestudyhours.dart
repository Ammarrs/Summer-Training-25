//nada
import 'package:flutter/material.dart';

class Changestudyhours extends StatefulWidget {
  const Changestudyhours({
    super.key, 
    required this.day, 
    required this.initialhour
  });
  final String day;
  final int initialhour;

  @override
  State<Changestudyhours> createState() => _ChangestudyhoursState();
}

class _ChangestudyhoursState extends State<Changestudyhours> {
  int? selectedhour;
    @override
  void initState() {
    super.initState();
    selectedhour = widget.initialhour;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How many hours do you want to spend on ${widget.day}?'),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Expanded(
              child: ListWheelScrollView.useDelegate(
                itemExtent: 40,
                onSelectedItemChanged: (value) {
                  setState(() {
                    selectedhour = value;
                  });
                },
                physics: FixedExtentScrollPhysics(),
                controller: FixedExtentScrollController(initialItem: selectedhour ?? 0),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) => Center(child: Text('$index')),
                  childCount: 15,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {

            });
            Navigator.pop(context,selectedhour);
          },
          child: Text("Change"),
        ),
      ],
    );
  }
}
