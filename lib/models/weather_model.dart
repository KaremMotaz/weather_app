class WeatherModel {
  final String cityName;
  final String date;
  final double avgTemp;
  final double maxTemp;
  final double minTemp;
  final String weatherCondition;

  WeatherModel({
    required this.cityName,
    required this.date,
    required this.avgTemp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCondition,
  });

  factory WeatherModel.fromJson(json) {
    return WeatherModel(
      cityName: json["address"],
      date: json["days"][0]["datetime"],
      avgTemp: json["days"][0]["temp"],
      maxTemp: json["days"][0]["tempmax"],
      minTemp: json["days"][0]["tempmin"],
      weatherCondition: json["days"][0]["conditions"],
    );
  }
}
