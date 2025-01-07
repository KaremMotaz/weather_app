import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/';
  final String apiKey = 'D5HZGU8X37E3FBKQ7TQZBGDCP';
  WeatherService(this.dio);
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response =
          await dio.get('$baseUrl/$cityName?unitGroup=metric&include=days&key=$apiKey&contentType=json');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errmessage = e.response?.data["error"]["message"] ??
          "Oops there was an error, try later";
      throw Exception(errmessage);
    } catch (e) {
      throw Exception('Oops there was an error');
    }
  }
}

// https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Cairo?unitGroup=metric&include=days&key=D5HZGU8X37E3FBKQ7TQZBGDCP&contentType=json