import 'dart:convert';

import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

class Weather {
  String url =
      'http://api.openweathermap.org/data/2.5/weather?q=paris&appid=ca0873a42d04802307eab7bfa6d10f75';

  WeatherInfo weatherDataList = new WeatherInfo();

  Future<String> fetchWeather() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      // return WeatherInfo.fromJson(decodedJson);
      weatherDataList = WeatherInfo.fromJson(decodedJson);
      return "fetch data success";
    } else {
      throw Exception('Error Loading request URL info.');
    }
  }
}
