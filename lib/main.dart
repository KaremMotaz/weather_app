import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/pages/home_page.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherStates>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 4.0,
                shadowColor: getThemeColor(
                    BlocProvider.of<GetWeatherCubit>(context)
                        .weatherModel
                        ?.weatherCondition),
                color: getThemeColor(BlocProvider.of<GetWeatherCubit>(context)
                    .weatherModel
                    ?.weatherCondition),
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: getThemeColor(
                  BlocProvider.of<GetWeatherCubit>(context)
                      .weatherModel
                      ?.weatherCondition,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    case "Sunny":
      return Colors.orange;

    case "Partly cloudy":
    case "Cloudy":
    case "Overcast":
      return Colors.blueGrey;

    case "Mist":
    case "Fog":
    case "Blowing snow":
    case "Blizzard":
    case "Patchy snow possible":
    case "Patchy light snow":
    case "Light snow":
    case "Light snow showers":
    case "Patchy moderate snow":
    case "Moderate snow":
    case "Moderate or heavy snow showers":
    case "Patchy heavy snow":
    case "Heavy snow":
      return Colors.grey;

    case "Patchy rain possible":
    case "Patchy light drizzle":
    case "Light drizzle":
    case "Patchy light rain":
    case "Light rain":
    case "Light rain shower":
      return Colors.lightBlue;

    case "Moderate rain at times":
    case "Moderate rain":
    case "Moderate or heavy rain shower":
      return Colors.blue;

    case "Heavy rain at times":
    case "Heavy rain":
    case "Torrential rain shower":
      return Colors.indigo;

    case "Patchy sleet possible":
    case "Light sleet":
    case "Light sleet showers":
    case "Moderate or heavy sleet showers":
    case "Moderate or heavy sleet":
    case "Ice pellets":
    case "Light showers of ice pellets":
    case "Moderate or heavy showers of ice pellets":
    case "Patchy freezing drizzle possible":
    case "Freezing drizzle":
    case "Heavy freezing drizzle":
    case "Light freezing rain":
    case "Moderate or heavy freezing rain":
      return Colors.cyan;

    case "Thundery outbreaks possible":
    case "Patchy light rain with thunder":
    case "Moderate or heavy rain with thunder":
    case "Patchy light snow with thunder":
    case "Moderate or heavy snow with thunder":
      return Colors.deepPurple;

    default:
      return Colors.grey; // Default color for unrecognized conditions
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
