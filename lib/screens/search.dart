import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wheather/db/cbservices.dart';
import 'package:wheather/screens/details.dart';
// Import the Detailspage

import 'package:wheather/widget/containerwidget.dart';

class Managepage extends StatefulWidget {
  const Managepage({super.key});

  @override
  State<Managepage> createState() => _ManagepageState();
}

class _ManagepageState extends State<Managepage> {
  List storedata = [];
  List revlist = [];
  @override
  void initState() {
    super.initState();
    initdata();
  }

  void initdata() async {
    storedata = await dbservice.getvalues();
    revlist = storedata.reversed.toList();
  }

  String getCurrentTimeFormatted() {
    final now = DateTime.now();
    final formatter = DateFormat('h.mm a');
    return formatter.format(now).toString();
  }

  Dbservice dbservice = Dbservice();
  bool locationcontainer = false;

  TextEditingController searchcontroller = TextEditingController();
  Future<dynamic>? futureLocation;
  List<Map<String, dynamic>> searchedLocations = [];

  Future<dynamic> searchlocation() async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${searchcontroller.text}&appid=f78296d33921dc7d954eb128aed10690&units=metric'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      throw Exception('Something went wrong...........');
    }
  }

  void search() async {
    final locationData = await searchlocation();

    futureLocation = Future.value(locationData);
    if (locationData != null) {
      final location = locationData['name'];
      final temp = locationData['main']['temp'];
      final weather = locationData['weather'][0]['description'];

      try {
        await dbservice.addvalues(
            location: location,
            temperature: temp.toString(),
            weather: weather,
            time: getCurrentTimeFormatted());
      } catch (e) {
        print(e);
      }

      if (!searchedLocations.any((element) => element['name'] == location)) {
        searchedLocations.add({
          'name': location,
          'temp': temp,
          'weather': weather,
          'time': getCurrentTimeFormatted()
        });
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
            child: Column(
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
                        ),
                      ),
                      SizedBox(width: 50),
                      Text(
                        'Manage location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchcontroller,
                    onEditingComplete: search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search Your City',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                FutureBuilder<dynamic>(
                  future: futureLocation,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final data = snapshot.data;
                      final location = data['name'];
                      final temp = data['main']['temp'];
                      final weather = data['weather'][0]['description'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detailspage(
                                location: location,
                                temperature: '${temp.toString()}°C',
                                weather: weather,
                              ),
                            ),
                          );
                        },
                        child: Containerwidget(
                          location: location,
                          text1: '${temp.toString()}°C',
                          text2: weather,
                          time: getCurrentTimeFormatted(),
                          icon1: Icons.location_on_sharp,
                          icon2: Icons.cloud,
                        ),
                      );
                    } else {
                      return Text('No location');
                    }
                  },
                ),
                Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                if (!locationcontainer)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show Search History',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            locationcontainer = true;
                          });
                        },
                        icon: Icon(
                          Icons.keyboard_double_arrow_down_sharp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                if (locationcontainer)
                  Expanded(
                    child: ListView.builder(
                      itemCount: revlist.length,
                      itemBuilder: (context, index) {
                        final location = revlist[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detailspage(
                                  location: location['location'],
                                  temperature: '${location['temperature']}°C',
                                  weather: location['weather'],
                                ),
                              ),
                            );
                          },
                          child: Containerwidget(
                            location: location['location'],
                            text1: '${location['temperature']}°C',
                            text2: location['weather'],
                            icon1: Icons.location_on_sharp,
                            icon2: Icons.cloud,
                            time: getCurrentTimeFormatted(),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
