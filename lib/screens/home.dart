import 'package:flutter/material.dart';

import 'package:wheather/widget/forecast.dart';
import 'package:wheather/widget/infowidget.dart';
import 'package:wheather/widget/weekwidget.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> forecastData = [
      {'time': 'Now', 'temp': '20°/24°', 'rain': '74% rain'},
      {'time': '10:00', 'temp': '20°/24°', 'rain': '69% rain'},
      {'time': '11:00', 'temp': '20°/24°', 'rain': '62% rain'},
      {'time': '12:00', 'temp': '20°/24°', 'rain': '53% rain'},
      {'time': '13:00', 'temp': '22°/24°', 'rain': '45% rain'},
      {'time': '13:00', 'temp': '22°/24°', 'rain': '45% rain'},
    ];
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
      body: SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                            iconSize: 40,
                            color: Colors.white,
                          ),
                          Text(
                            'Current Location',
                            style: TextStyle(color: Colors.white, fontSize: 20),
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
                        child: Image.asset(
                          'asset/images/Sun cloud angled rain.png',
                        ),
                      ),
                      Text(
                        'Sunday | Nov 14',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '24°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Heavy Rain',
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoWidget(
                                  icon: Icons.telegram,
                                  label: '3.7 km/h',
                                  sublabel: 'Wind',
                                ),
                                SizedBox(height: 20),
                                InfoWidget(
                                  icon: Icons.thermostat,
                                  label: '1010 mbar',
                                  sublabel: 'Pressure',
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoWidget(
                                  icon: Icons.cloud_queue,
                                  label: '74%',
                                  sublabel: 'Chance of rain',
                                ),
                                SizedBox(height: 20),
                                InfoWidget(
                                  icon: Icons.water_drop,
                                  label: '83%',
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
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: forecastData.length,
                        itemBuilder: (context, index) {
                          final forecast = forecastData[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ForecastWidget(
                              time: forecast['time']!,
                              temp: forecast['temp']!,
                              rain: forecast['rain']!,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 300,
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
      ),
    );
  }
}
