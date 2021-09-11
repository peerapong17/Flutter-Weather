import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather.dart';
import 'components/weather_data_list.dart';
import './services/weather_service.dart';
import 'models/weather.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Weather(),
      child: Consumer<Weather>(
        builder: (context, weather, child) => Scaffold(
          body: FutureBuilder<String>(
            future: weather.fetchWeather(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                          weather.weatherDataList.location??"I have no idea",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w900),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            weather.weatherDataList.temp?.toString() ??
                                "No data",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: Colors.blue),
                          ),
                        ),
                        Text(
                          "High of ${weather.weatherDataList.tempMax ?? "No data"}, Low of ${weather.weatherDataList.tempMin ?? "No data"}",
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
                              subtitle:
                                  weather.weatherDataList.temp?.toString() ??
                                      "No data",
                              color: Colors.purple),
                          weatherDataList(
                              icon: Icons.filter_drama_outlined,
                              title: 'Weather',
                              subtitle:
                                  weather.weatherDataList.weather ?? "No data",
                              color: Colors.blue),
                          weatherDataList(
                              icon: Icons.wb_sunny_outlined,
                              title: 'Humidity',
                              subtitle: weather.weatherDataList.humidity
                                      ?.toString() ??
                                  "No data",
                              color: Colors.amberAccent.shade700),
                          weatherDataList(
                              icon: Icons.waves_outlined,
                              title: 'Wind Speed',
                              subtitle: weather.weatherDataList.windSpeed
                                      ?.toString() ??
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
        ),
      ),
    );
  }
}
