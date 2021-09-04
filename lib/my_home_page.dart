import 'dart:ui';
import 'package:flutter/material.dart';
import 'components/weather_data_list.dart';
import './services/weather_service.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherService weatherService = new WeatherService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: weatherService.fetchWeather(),
        builder: (BuildContext context, AsyncSnapshot<WeatherInfo> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.height / 2,
                height: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Paris",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        snapshot.data!.temp?.toString() ?? "No data",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w900,
                            color: Colors.blue),
                      ),
                    ),
                    Text(
                      "High of ${snapshot.data!.tempMax ?? "No data"}, Low of ${snapshot.data!.tempMin ?? "No data"}",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      weatherDataList(
                          icon: Icons.thermostat_outlined,
                          title: 'Temperature',
                          subtitle: snapshot.data!.temp?.toString() ??
                              "No data",
                          color: Colors.purple),
                      weatherDataList(
                          icon: Icons.filter_drama_outlined,
                          title: 'Weather',
                          subtitle: snapshot.data!.weather ?? "No data",
                          color: Colors.blue),
                      weatherDataList(
                          icon: Icons.wb_sunny_outlined,
                          title: 'Humidity',
                          subtitle:
                              snapshot.data!.humidity?.toString() ??
                                  "No data",
                          color: Colors.amberAccent.shade700),
                      weatherDataList(
                          icon: Icons.waves_outlined,
                          title: 'Wind Speed',
                          subtitle:
                              snapshot.data!.windSpeed?.toString() ??
                                  "No data",
                          color: Colors.greenAccent),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
