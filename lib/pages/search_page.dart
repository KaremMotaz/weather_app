import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController mycontroller = TextEditingController();

  @override
  void dispose() {
    mycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search City',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: mycontroller,
            onSubmitted: (value) {
              GetWeatherCubit getWeatherCubit =
                  BlocProvider.of<GetWeatherCubit>(context);
              getWeatherCubit.getWeather(cityName: value);
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                suffixIcon: IconButton(
                  onPressed: () {
                    GetWeatherCubit getWeatherCubit =
                        BlocProvider.of<GetWeatherCubit>(context);
                    getWeatherCubit.getWeather(cityName: mycontroller.text);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.search),
                ),
                hintText: 'Enter City Name',
                labelText: 'Search',
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder()),
          ),
        ),
      ),
    );
  }
}
