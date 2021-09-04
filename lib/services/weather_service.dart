import '../model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  Future<WeatherInfo> fetchWeather() async {
    String url =
        'http://api.openweathermap.org/data/2.5/weather?q=paris&appid=ca0873a42d04802307eab7bfa6d10f75';
    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = json.decode(response.body);
      return WeatherInfo.fromJson(decodedJson);
    } else {
      throw Exception('Error Loading request URL info.');
    }
  }
}
