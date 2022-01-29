import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather_bloc.dart';
import 'package:weather/weather_model.dart';

class ShowWeather extends StatelessWidget {
  final city;
  WeatherModel weather;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          children: [
            Text(
              city,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              weather.getTemp.round().toString() + "C",
              style: const TextStyle(color: Colors.white70, fontSize: 50),
            ),
            const Text(
              "Temprature",
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      weather.getMinTemp.round().toString() + "C",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    const Text(
                      "Min Temprature",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      weather.getMaxTemp.round().toString() + "C",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 30),
                    ),
                    const Text(
                      "Max Temperature",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                },
                color: Colors.lightBlue,
                child: const Text(
                  "Search",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ),
          ],
        ));
  }
}
