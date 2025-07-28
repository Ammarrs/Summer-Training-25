import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final notesController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String remindBefore = '1 day before';
  String type = 'exam';

  void saveReminder() async {
    final box = Hive.box('reminders');

    final reminder = {
      'title': titleController.text,
      'dueDate': selectedDate.toIso8601String(),
      'time': timeController.text,
      'remindBefore': remindBefore,
      'notes': notesController.text,
      'type': type,
    };

    await box.add(reminder);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Reminder'),
            ),
            ListTile(
              title: Text('Due Date: ${selectedDate.toLocal()}'.split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
            ),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(labelText: 'Time'),
            ),
            DropdownButton<String>(
              value: remindBefore,
              items: ['1 day before', '2 day before', '6 day before']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => remindBefore = val!),
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            DropdownButton<String>(
              value: type,
              items: ['exam', 'homework', 'project']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => type = val!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveReminder,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
