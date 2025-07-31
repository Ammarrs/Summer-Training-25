//nada
import 'package:flutter/material.dart';

class Customzekracard extends StatelessWidget {
  const Customzekracard({
    super.key, 
    required this.isshared, 
    required this.iszekra, 
    required this.imgpath, 
    required this.title, 
    required this.description
  });
  final bool isshared;
  final bool iszekra;
  final String imgpath;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4CBB6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imgpath,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              color: Color(0xFF1B1464), 
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF1B1464),
            ),
          ),
          const SizedBox(height: 16),
          if (!iszekra) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B1464), 
              ),
              onPressed: () {
                
              },
              child: Text(
                isshared ? 'Stop Share' : 'Share',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ]
        ]
      )
    );
  }
}