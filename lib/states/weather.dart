import 'dart:convert';

import 'package:location/location.dart';
import 'package:weather_app/models/weather_info.dart';
import 'package:http/http.dart' as http;

class Weather {
  String API_KEY = 'ca0873a42d04802307eab7bfa6d10f75';

  // Weather() {
  //   String url =
  //       'http://api.openweathermap.org/data/2.5/weather?q=paris&appid=$API_KEY';
  // }

  Future<String> getCurrentLocation() async {
    LocationData _locationData = await Location().getLocation();
    return "https://api.openweathermap.org/data/2.5/find?lat=${_locationData.latitude}&lon=${_locationData.longitude}&cnt=1&units=metric&appid=$API_KEY";
  }

  Future<WeatherInfo> fetchWeather() async {
    http.Response response = await http.get(
      Uri.parse(await getCurrentLocation()),
    );

    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      return WeatherInfo.fromJson(decodedJson['list'][0]);
    } else {
      throw Exception('Error Loading request URL info.');
    }
  }
}
