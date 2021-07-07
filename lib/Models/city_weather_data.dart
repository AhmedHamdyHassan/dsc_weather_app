//Model of the API Excuted Data
class CityWeatherData {
  final double temp, feelsLikeTemp, maxTemp, minTemp;
  int pressure;
  final String description, sunRise, sunSet, cityName, stateOfWeather;
  CityWeatherData(
      {this.description,
      this.temp,
      this.minTemp,
      this.maxTemp,
      this.feelsLikeTemp,
      this.pressure,
      this.sunRise,
      this.sunSet,
      this.cityName,
      this.stateOfWeather});
}
