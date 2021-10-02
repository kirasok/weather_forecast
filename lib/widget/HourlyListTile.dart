import 'package:flutter/material.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/Utils.dart';

class HourlyListTile extends StatelessWidget {
  final Hourly hourly;

  const HourlyListTile({
    Key? key,
    required this.hourly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
          'https://openweathermap.org/img/wn/${hourly.current.weather.icon}@2x.png'),
      title: Text(
        getDateTime(
          DateTime.fromMillisecondsSinceEpoch(
            hourly.current.dt * 1000,
            isUtc: true,
          ),
        ),
      ),
    );
  }
}
