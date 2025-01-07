class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class WeatherLoadingState extends WeatherStates {}

class WeatherLoadedState extends WeatherStates {}

class WeatherErrorState extends WeatherStates {
  final String errorMessage;
  WeatherErrorState({required this.errorMessage});
}
