import 'package:flutter/material.dart';

class Customoptiontile extends StatelessWidget {
  const Customoptiontile({super.key, required this.emoji, required this.text, required this.ontap, this.isHighlighted=false});
  final String emoji;
  final String text;
  final VoidCallback ontap;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isHighlighted ? const Color(0xFFFFE4B8) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: isHighlighted
              ? Border.all(color: const Color(0xFFFF9800), width: 2)
              : null,
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),

      ),
    );
  }
}