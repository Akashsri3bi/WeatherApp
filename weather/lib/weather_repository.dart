//Repository files is the files that get the data from network mainly it will contain
//The code for api calling , or fetching data from data base

import 'dart:convert';

import 'package:weather/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<WeatherModel> getWeather(String cityName) async {
    String url = "https://api.openweathermap.org/data/2.5/weather?q=" +
        cityName +
        "&APPID=43ea6baaad7663dc17637e22ee6f78f2";
    final result = await http.get(Uri.parse(url));
    if (result.statusCode != 200) {
      throw Exception();
    } else {
      return parseJson(result.body);
    }
  }

  WeatherModel parseJson(final response) {
    final jsonDecoded = jsonDecode(response);
    final data = jsonDecoded["main"];
    return WeatherModel.fromJson(data);
  }
}
