import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/show_weather.dart';
import 'package:weather/weather_bloc.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Our animated Globe image is here
        Center(
          child: Container(
            height: 300,
            width: 300,
            child: const FlareActor(
              "assets/WorldSpin.flr",
              fit: BoxFit.contain,
              animation: "roll",
            ),
          ),
        ),

        //We will be using BlocBuilder which will build the widget according to the state which comes from BlocProvider
        BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherIsNotSearched) {
            return Container(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              child: Column(
                children: [
                  const Text(
                    "Search Weather",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70),
                  ),
                  const Text(
                    "Instanly",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w200,
                        color: Colors.white54),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: cityController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        hintText: "CityName",
                        hintStyle: TextStyle(color: Colors.white70),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue, style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid))),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        color: Colors.lightBlue,
                        child: const Text(
                          "Search",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        onPressed: () {
                          weatherBloc.add(FetchWeather(cityController.text));
                        }),
                  ),
                ],
              ),
            );
          } else if (state is WeatherIsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherIsLoaded) {
            return ShowWeather(state.getWeather, cityController.text);
          } else {
            return const Text(
              "Error",
              style: TextStyle(color: Colors.white),
            );
          }
        })
      ],
    );
  }
}
