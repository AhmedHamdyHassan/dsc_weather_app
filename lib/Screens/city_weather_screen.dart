import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/weather_custom_design.dart';
import '../Screens/error_screen.dart';
import '../Models/weather_data.dart';
import '../Screens/loading_screen.dart';
import '../widgets/custom_fragment.dart';
import '../Models/city_weather_data.dart';
import '../Models/designColors.dart';

//Provider that will be excuted when the consumer builds
var responseProvider =
    FutureProvider.family<CityWeatherData, String>((ref, cityName) async {
  print("Excuted");
  if (cityName == '') {
    return ref.read(cityWeatherDataProvider).determinePosition();
  } else {
    return ref.read(cityWeatherDataProvider).getAllData(cityName: cityName);
  }
});

class CityWeatherScreen extends StatefulWidget {
  static String routeKey = 'CityWeatherScreen';
  @override
  _CityWeatherScreenState createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  bool isSearchActive = false;
  String searchValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final response = watch(responseProvider(searchValue));
          return response.map(
              data: (data) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        design[data.value.stateOfWeather]['image'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        isSearchActive
                            ?
                            //Shows the Search bar
                            TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white24,
                                  border: InputBorder.none,
                                  hintText: 'Enter city to know it\'s weather.',
                                ),
                                onSubmitted: (value) {
                                  setState(() {
                                    searchValue = value;
                                    isSearchActive = false;
                                  });
                                },
                              )
                            :
                            //app bar with the city name and the search icon
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Text(
                                      data.value.cityName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: design[data.value.stateOfWeather]
                                            ['primaryColor'],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isSearchActive = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.search,
                                        size: 30,
                                        color: design[data.value.stateOfWeather]
                                            ['primaryColor'],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        //هنا بيعرض اليوم
                        WeatherCustomDesign(
                          weatherData: data.value,
                        ),
                        //هنا بيعرض حالة الطقس الخاصه باليوم
                        CustomFragment(
                          sunrise: data.value.sunRise,
                          sunset: data.value.sunSet,
                          minTemp: data.value.minTemp.toStringAsFixed(0) + '°c',
                          maxTemp: data.value.maxTemp.toStringAsFixed(0) + '°c',
                          description: data.value.description,
                          pressure: data.value.pressure.toString() + ' hPa',
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: (value) => LoadingScreen(),
              error: (data) {
                return ErrorScreen(data.error.toString());
              });
        },
      ),
    );
  }
}
