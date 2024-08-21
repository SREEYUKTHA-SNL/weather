import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wheather/db/sharedservice.dart';

import 'package:wheather/widget/forecast.dart';
import 'package:wheather/widget/infowidget.dart';
import 'package:wheather/widget/weekwidget.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  State<Homepage1> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage1> {
  String? _currentAddress;
  Position? _currentPosition;

  bool showForecastContainer = false;
  String formattedTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }


  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled.Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }



  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);

      _getAddressFromLatLng(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<dynamic> fetchdetails() async {
    final response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=11.258753&lon=75.780411&appid=f78296d33921dc7d954eb128aed10690'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      throw Exception('Something went wrong......');
    }
  }

  Future<dynamic> fetchforecast() async {
    final response = await http.get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=f78296d33921dc7d954eb128aed10690'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      return decodedData;
    } else {
      throw Exception('Something went wrong......');
    }
  }

  Future<void> _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = " ${place.locality}";
      });
    } catch (e) {
      setState(() {
        _currentAddress = "Error fetching address: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    getvalues();
  }

bool isloading=false;
Map?data;

void getvalues()async{
  setState(() {
    isloading=true;
  });
  data=await Spservice().getData();
  setState(() {
    isloading=false;
  });
  print(data);

}



  @override
  Widget build(BuildContext context) {
   
    final List<WeeklyForcast> weeklyForecastData = [
      WeeklyForcast(
          text: 'Sun',
          icon: Icons.cloudy_snowing,
          text2: '74% rain',
          text3: '20°/24°'),
      WeeklyForcast(
          text: 'Mon',
          icon: Icons.cloudy_snowing,
          text2: '74% rain',
          text3: '20°/24°'),
      WeeklyForcast(
          text: 'Tue',
          icon: Icons.cloudy_snowing,
          text2: '74% rain',
          text3: '20°/24°'),
      WeeklyForcast(
          text: 'Wed',
          icon: Icons.cloudy_snowing,
          text2: '74% rain',
          text3: '20°/24°'),
      WeeklyForcast(
          text: 'Thu',
          icon: Icons.cloudy_snowing,
          text2: '74% rain',
          text3: '20°/24°'),
      WeeklyForcast(
          text: 'Fri',
          icon: Icons.cloudy_snowing,
          text2: '74% rain',
          text3: '20°/24°'),
      WeeklyForcast(
          text: 'Sat',
          icon: Icons.cloudy_snowing,
          text2: '74% rain',
          text3: '20°/24°'),
    ];

    return Scaffold(
      body: FutureBuilder(
          future: fetchdetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else {
              String temp =
                  (snapshot.data['main']['temp'] - 273.15).toStringAsFixed(1);
              String icon = snapshot.data['weather'][0]['icon'];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
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
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add),
                                    iconSize: 40,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '$_currentAddress',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Image.network(
                                  'https://openweathermap.org/img/wn/$icon@2x.png',
                                ),
                              ),
                              Text(
                                'Sunday | Nov 14',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                "$temp",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data['weather'][0]['description'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InfoWidget(
                                          icon: Icons.telegram,
                                          label: snapshot.data['wind']['speed']
                                              .toString(),
                                          sublabel: 'Wind',
                                        ),
                                        SizedBox(height: 20),
                                        InfoWidget(
                                          icon: Icons.thermostat,
                                          label: snapshot.data['main']
                                                  ['pressure']
                                              .toString(),
                                          sublabel: 'Pressure',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InfoWidget(
                                          icon: Icons.cloud_queue,
                                          label: '74%',
                                          sublabel: 'Chance of rain',
                                        ),
                                        SizedBox(height: 20),
                                        InfoWidget(
                                          icon: Icons.water_drop,
                                          label: snapshot.data['main']
                                                  ['humidity']
                                              .toString(),
                                          sublabel: 'Humidity',
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                            Text(
                              'Sunday | Nov 14',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Expanded(
                              child: FutureBuilder(
                                  future: fetchforecast(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.blueAccent,
                                      ));
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child: Text(
                                              'Error: ${snapshot.error.toString()}'));
                                    } else {
                                      final forecast = snapshot.data['list'];
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: forecast.length,
                                        itemBuilder: (context, index) {
                                          final String image =
                                              'https://openweathermap.org/img/wn/${snapshot.data['list'][index]['weather'][0]['icon']}@2x.png';

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: ForecastWidget(
                                              time: formattedTime(
                                                  snapshot.data['list'][index]
                                                      ['dt_txt']),
                                              temp: (snapshot.data['list']
                                                              [index]['main']
                                                          ['temp'] -
                                                      273.15)
                                                  .toStringAsFixed(1),
                                              rain: snapshot.data['list'][index]
                                                          ['weather'][0]
                                                      ['description'] ??
                                                  '',
                                              image: image,
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!showForecastContainer)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forecasts For 7 Days',
                              style: TextStyle(
                                  color: Color(0xff2C79C1), fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  showForecastContainer = true;
                                });
                              },
                              icon: Icon(
                                Icons.keyboard_double_arrow_down_sharp,
                                color: Color(0xff2C79C1),
                              ))
                        ],
                      ),
                    if (showForecastContainer)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Forcats for 7 Days',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                height: 400, // Adjust this height as needed
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: weeklyForecastData.length,
                                  itemBuilder: (context, index) {
                                    final forecast = weeklyForecastData[index];
                                    return WeeklyForcast(
                                      icon: forecast.icon,
                                      text: forecast.text,
                                      text2: forecast.text2,
                                      text3: forecast.text3,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
