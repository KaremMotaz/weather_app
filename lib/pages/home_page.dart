import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/widgets/no_weather_body.dart';
import 'package:weather_app/widgets/weather_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //elevation: 1,
        title: const Text(
          'Weather App',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchPage();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: BlocBuilder<GetWeatherCubit, WeatherStates>(
        builder: (context, state) {
          if (state is WeatherInitialState) {
            return const NoWeatherBody();
          } else if (state is WeatherLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else if (state is WeatherLoadedState) {
            // ignore: prefer_const_constructors
            return WeatherBody();
          } else {
            return const Center(child: Text('Oops there was an error'));
          }
        },
      ),
    );
  }
}
