import 'package:equatable/equatable.dart';
import 'package:flare_flutter/base/actor_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather_model.dart';
import 'package:weather/weather_repository.dart';

//These is our base class for events which will extends the equatable because we need it to be comparable
class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

//These are the events which can be generated
class FetchWeather extends WeatherEvent {
  final _city;

  FetchWeather(this._city);

  @override
  List<Object?> get props => [_city];
}

class ResetWeather extends WeatherEvent {}

//This our base class for State

class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

//These are the states we can encounter on the event
class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherIsLoaded(this._weather);
  WeatherModel get getWeather => _weather;
  @override
  List<Object?> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {}

//Now we create our bloc class
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc(WeatherRepository weatherRepository)
      : _weatherRepository = weatherRepository,
        super(WeatherIsNotSearched());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherIsLoading();
      try {
        WeatherModel weather = await _weatherRepository.getWeather(event._city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
