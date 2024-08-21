import 'package:flutter/material.dart';

class Containerwidget extends StatelessWidget {
  final String location;
  final String text1;
  final String text2;
  final IconData icon1;
  final String time;
  final IconData icon2;


  const Containerwidget({super.key, required this.location, required this.text1, required this.text2, required this.icon1, required this.icon2, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15),
            ),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    location,
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(icon1),
                  SizedBox(
                    width: 140,
                  ),
                  Icon(icon2)
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        text1,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(time)
                    ],
                  ),
                  SizedBox(
                    width: 90,
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
