import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';
import 'city_weather_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:geolocator/geolocator.dart';

final cityWeatherDataProvider = Provider((ref) => WeatherData());

class WeatherData {
  String locationData = '';
  double lat, long;
  //Get Location Fuction Using Geolocator
  Future<CityWeatherData> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    lat = position.latitude;
    long = position.longitude;
    return getAllData(search: true, lat: lat, long: long);
  }

  //To convert Time From Milliseconds to User read format
  String _convertFromDateToHoursAndMinutes(var timeInMilliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeInMilliseconds);
    String result = "";
    result = DateFormat('h:m').format(dateTime);
    if (dateTime.hour > 12) {
      result += "pm";
    } else {
      result += "am";
    }
    return result;
  }

  //Get Data from API
  Future<CityWeatherData> getAllData(
      {bool search = false, double lat, double long, String cityName}) async {
    var sunriseInMilliseconds, sunsetInMilliseconds;
    String url = '';
    if (search) {
      url = 'http://api.openweathermap.org/data/2.5/weather?' +
          'lat=$lat&lon=$long&appid=55fd80dc528ac8b849b0a235078e8154';
    } else {
      url = 'http://api.openweathermap.org/data/2.5/weather?' +
          'q=$cityName&appid=55fd80dc528ac8b849b0a235078e8154';
    }
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      sunsetInMilliseconds = jsonResponse['sys']['sunset'];
      sunriseInMilliseconds = jsonResponse['sys']['sunrise'];
      CityWeatherData weatherData = CityWeatherData(
          temp: (jsonResponse['main']['temp'].toDouble() - 273.15),
          minTemp: (jsonResponse['main']['temp_min'].toDouble() - 273.15),
          maxTemp: (jsonResponse['main']['temp_max'].toDouble() - 273.15),
          feelsLikeTemp:
              (jsonResponse['main']['feels_like'].toDouble() - 273.15),
          pressure: jsonResponse['main']['pressure'],
          description: jsonResponse['weather'][0]['description'],
          cityName: jsonResponse['name'],
          sunRise: _convertFromDateToHoursAndMinutes(sunriseInMilliseconds),
          sunSet: _convertFromDateToHoursAndMinutes(sunsetInMilliseconds),
          stateOfWeather: jsonResponse['weather'][0]['main'].toString());
      return weatherData;
    } else {
      var jsonResponse = convert.jsonDecode(response.body);
      throw Exception(jsonResponse['message']);
    }
  }
}
