import 'package:flutter/material.dart';

class DocumentListCard extends StatelessWidget {
  const DocumentListCard({Key? key, required this.color, required this.text})
      : super(key: key);
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 5,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        )),
      ),
    );
  }
}
