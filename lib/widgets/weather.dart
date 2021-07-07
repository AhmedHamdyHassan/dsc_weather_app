import 'package:flutter/material.dart';
import '../Models/designColors.dart';

class Weather extends StatelessWidget {
  final String temp, feelsLikeTemp, stateOfWeather, icon;
  const Weather(
      {this.temp, this.feelsLikeTemp, this.stateOfWeather, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              temp,
              style: TextStyle(
                color: design[stateOfWeather]['primaryColor'],
                fontWeight: FontWeight.w400,
                fontSize: 75,
              ),
            ),
            Text(
              'c',
              style: TextStyle(
                color: design[stateOfWeather]['primaryColor'],
                fontWeight: FontWeight.w600,
                fontSize: 50,
              ),
            ),
          ],
        ),
        Text(
          'Feels like $feelsLikeTemp°c',
          style: TextStyle(
              color: design[stateOfWeather][
                  'accentColor'], //Color(0xFFC0C0C0), //Colors.red /*Color(0xFF4D566F)*/,
              fontWeight: FontWeight.w900),
        )
      ],
    );
  }
}
