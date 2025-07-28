import 'package:flutter/material.dart';

import 'CustomPage.dart';
import 'links_screen.dart';
import 'notes_screen.dart';

class NotesLinks extends StatefulWidget {
  const NotesLinks({super.key});
  @override
  State<NotesLinks> createState() => _NotesLinksState();
}

class _NotesLinksState extends State<NotesLinks> {
  bool isLinks = false;

  @override
  Widget build(BuildContext context) {
    return Custompage(
      appbarcontant: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            isLinks ? 'assets/links.png' : 'assets/notes.png',
            fit: BoxFit.contain,
            height: 80,
          ),
        ),
      ),
      pagecontant: isLinks ? const LinksScreen() : const NotesScreen(),
      bottomNavigationBar: BottomAppBar(
        elevation: 0, // هذا يزيل الظل والخط الافتراضي
        color: const Color(0xFFFFD3B6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLinks ? "for notes" : "for links",
              style: const TextStyle(fontSize: 24, color: Color(0xFF1E1B73)),
            ),
            Switch(
              value: isLinks,
              onChanged: (value) => setState(() => isLinks = value),
              activeColor: const Color(0xFFDCA47C),
              activeTrackColor: const Color(0xFF1E1B73),
              inactiveThumbColor: const Color(0xFFDCA47C),
              inactiveTrackColor: const Color(0xFF1E1B73),
            ),
          ],
        ),
      ),
    );
  }
}
