import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/city_weather_data.dart';
import '../Models/designColors.dart';
import '../widgets/weather.dart';

class WeatherCustomDesign extends StatelessWidget {
  const WeatherCustomDesign({
    @required this.weatherData,
  });

  final CityWeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Today',
          style: TextStyle(
            color: design[weatherData.stateOfWeather]['primaryColor'],
            fontWeight: FontWeight.w600,
            fontSize: 35,
          ),
        ),
        Text(
          DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(DateTime.now()),
          style: TextStyle(
            color: design[weatherData.stateOfWeather]
                ['accentColor'], // Color(0xFFC0C0C0), //Color(0xFF616471),
            fontWeight: FontWeight.w900,
          ),
        ),
        Weather(
          temp: weatherData.temp.toStringAsFixed(0) + "°",
          feelsLikeTemp: weatherData.feelsLikeTemp.toStringAsFixed(0),
          stateOfWeather: weatherData.stateOfWeather,
        ),
      ],
    );
  }
}
