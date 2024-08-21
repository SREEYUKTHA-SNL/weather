import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  final String time;
  final String temp;
  final String rain;
  final String image;

  ForecastWidget({
    required this.time,
    required this.temp,
    required this.rain, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        SizedBox(height: 5.0),
       Image.network(image),
        SizedBox(height: 5.0),
        Text(
          temp,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 5.0),
        Text(
          rain,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
