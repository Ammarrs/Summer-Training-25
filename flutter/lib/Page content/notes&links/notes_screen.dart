import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Box notesBox;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box('notesBox');
  }

  void showNoteDialog({Map? existingNote, int? index}) {
    final titleCtrl = TextEditingController(text: existingNote?['title']);
    final contentCtrl = TextEditingController(text: existingNote?['content']);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
                fillColor: Color(0xFFFFD3B6),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentCtrl,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Content',
                fillColor: const Color(0xFFFFD3B6),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newNote = {
                  'title': titleCtrl.text,
                  'content': contentCtrl.text,
                };
                if (existingNote == null) {
                  notesBox.add(newNote);
                } else {
                  notesBox.putAt(index!, newNote);
                }
                Navigator.pop(context);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showNoteDialog(),
        backgroundColor: Colors.blue,
        elevation: 2,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: notesBox.listenable(),
                    builder: (context, Box box, _) {
                      if (box.isEmpty) {
                        return const Center(child: Text(""));
                      }
                      return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final note = box.getAt(index) as Map;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD3B6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(note['title'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(note['content'],
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.grey),
                                      onPressed: () => showNoteDialog(
                                          existingNote: note, index: index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.redAccent),
                                      onPressed: () {
                                        box.deleteAt(index);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
