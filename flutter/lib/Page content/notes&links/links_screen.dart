import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LinksScreen extends StatefulWidget {
  const LinksScreen({super.key});
  @override
  State<LinksScreen> createState() => _LinksScreenState();
}

class _LinksScreenState extends State<LinksScreen> {
  late Box linksBox;
  bool isNotesSelected = false;
  @override
  void initState() {
    super.initState();
    linksBox = Hive.box('linksBox');
  }

  void showLinkDialog({Map? existingLink, int? index}) {
    final titleCtrl = TextEditingController(text: existingLink?['title']);
    final urlCtrl = TextEditingController(text: existingLink?['url']);
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
              controller: urlCtrl,
              decoration: InputDecoration(
                labelText: 'URL',
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
                final newLink = {
                  'title': titleCtrl.text,
                  'url': urlCtrl.text,
                };
                if (existingLink == null) {
                  linksBox.add(newLink);
                } else {
                  linksBox.putAt(index!, newLink);
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
    //  final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showLinkDialog(),
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
                    valueListenable: linksBox.listenable(),
                    builder: (context, Box box, _) {
                      if (box.isEmpty) {
                        return const Center(child: Text(""));
                      }
                      return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context, index) {
                          final link = box.getAt(index) as Map;
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
                                    Text(link['title'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(link['url'],
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit,
                                          color: Colors.grey),
                                      onPressed: () => showLinkDialog(
                                          existingLink: link, index: index),
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
