import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'AddReminder.dart';
import 'package:tarteeb_app/tablet&phone%20design/appbar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  final Box remindersBox = Hive.box('reminders');

  List<Map> _getRemindersForDay(DateTime day) {
    return remindersBox.values
        .where((r) {
          final reminder = r as Map;
          final dueDate = DateTime.parse(reminder['dueDate']);
          return dueDate.year == day.year &&
              dueDate.month == day.month &&
              dueDate.day == day.day;
        })
        .map((r) => r as Map)
        .toList();
  }

  double get statusBarHeight => MediaQuery.of(context).padding.top;

  void deleteReminder(int index, Map reminder) async {
    final key =
        remindersBox.keys.firstWhere((k) => remindersBox.get(k) == reminder);
    await remindersBox.delete(key);
    setState(() {}); // refresh UI
  }

  @override
  Widget build(BuildContext context) {
    final reminders = _getRemindersForDay(_selectedDay);

    return Scaffold(
      body: Stack(
        children: [
          // Custom Painted AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 150 + statusBarHeight,
              width: double.infinity,
              child: CustomPaint(
                painter: AppBarPainter(),
              ),
            ),
          ),
          Positioned(
            top: statusBarHeight + 10,
            left: 20,
            child: Text(
              'Calendar',
              style: GoogleFonts.dancingScript(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: EdgeInsets.only(
              top: 150 + statusBarHeight,
              bottom: 60,
            ),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030),
                  focusedDay: _selectedDay,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                  onDaySelected: (selected, focused) {
                    setState(() => _selectedDay = selected);
                  },
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: reminders.isEmpty
                      ? const Center(child: Text('No reminders on this day.'))
                      : ListView.builder(
                          itemCount: reminders.length,
                          itemBuilder: (context, index) {
                            final reminder = reminders[index];
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                title: Text(reminder['title']),
                                subtitle: Text(
                                  '${reminder['type']} | ${reminder['time']}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () =>
                                      deleteReminder(index, reminder),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Positioned(
        bottom: 16,
        right: 16,
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddReminderScreen()),
            );
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
