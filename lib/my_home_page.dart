import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<WeatherInfo> futureWeather;
  Future<WeatherInfo> fetchWeather() async {
    final url =
        'http://api.openweathermap.org/data/2.5/weather?q=paris&appid=ca0873a42d04802307eab7bfa6d10f75';
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return WeatherInfo.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Error Loading request URL info.');
    }
  }

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
        future: fetchWeather(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.data.location);
          if (snapshot.hasData) {
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
                        "${snapshot.data.location}",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "${snapshot.data.temp}",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                              color: Colors.blue),
                        ),
                      ),
                      Text(
                        "High of ${snapshot.data.tempMax}, Low of ${snapshot.data.tempMin}",
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
                        Center(
                          child: ListTile(
                            leading: Icon(
                              Icons.thermostat_outlined,
                              color: Colors.purple,
                            ),
                            title: Text(
                              'Temperature',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            subtitle: Text("${snapshot.data.temp}"),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.filter_drama_outlined,
                            color: Colors.blue,
                          ),
                          title: Text(
                            'Weather',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          subtitle: Text("${snapshot.data.weather}"),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.wb_sunny_outlined,
                            color: Colors.amberAccent[900],
                          ),
                          title: Text(
                            'Humidity',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          subtitle: Text("${snapshot.data.humidity}"),
                        ),
                        ListTile(
                          leading: Icon(Icons.waves_outlined,
                              color: Colors.greenAccent),
                          title: Text(
                            'Wind Speed',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          subtitle: Text("${snapshot.data.windSpeed}"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(futureWeather);
        },
      ),
    );
  }
}
