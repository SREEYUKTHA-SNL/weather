import 'package:flutter/material.dart';

class WeeklyForcast extends StatelessWidget {
  const WeeklyForcast(
      {super.key,
      required this.text,
      required this.text2,
      required this.text3,
      required this.icon});
  final String text;
  final String text2;
  final String text3;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            width: 60,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text2,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            width: 60,
          ),
          Text(text3, style: TextStyle(color: Colors.white, fontSize: 16))
        ],
      ),
    );
  }
}