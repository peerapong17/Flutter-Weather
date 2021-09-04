class WeatherInfo {
  String? weather;
  String? location;
  double? temp;
  double? tempMax;
  double? tempMin;
  int? humidity;
  double? windSpeed;

  WeatherInfo(
      {this.weather,
      this.location,
      this.temp,
      this.tempMax,
      this.tempMin,
      this.humidity,
      this.windSpeed});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(weather: json['weather'][0]['description'],
    location: json['name'],
    temp: json['main']['temp'],
    tempMax: json['main']['temp_max'],
    tempMin: json['main']['temp_min'],
    humidity: json['main']['humidity'],
    windSpeed: json['wind']['speed']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weather'] = this.weather;
    data['location'] = this.location;
    data['temp'] = this.temp;
    data['tempMax'] = this.tempMax;
    data['tempMin'] = this.tempMin;
    data['humidity'] = this.humidity;
    data['windSpeed'] = this.windSpeed;
    return data;
  }
}