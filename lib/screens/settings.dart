import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    height: 800,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff62B8F6),
                          Color(0xff2C79C1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      )),
                                  SizedBox(width: 50),
                                  Text(
                                    'Setting',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                                'UNIT',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Text('Temperature unit',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  Spacer(),
                                  Text('c',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Text('Wind speed unit',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  Spacer(),
                                  Text('km/h',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Text(' Atmospheric pressure unit',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  Spacer(),
                                  Text('mbar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              indent: 17,
                              endIndent: 17,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('EXTRA',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('About',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Privacy policy',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ],
                              ),
                            ),
                          ]),
                    )))));
  }
}
