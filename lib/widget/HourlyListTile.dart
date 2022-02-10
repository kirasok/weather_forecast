import 'package:flutter/material.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';
import 'package:weather_forecast/utils/Utils.dart';
import 'package:weather_forecast/widget/WeatherIcon.dart';
import 'package:weather_icons/weather_icons.dart';

class HourlyListTile extends StatelessWidget {
  final Hourly hourly;

  const HourlyListTile({
    Key? key,
    required this.hourly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double precipitation = 0;
    if (hourly.current.rain > 0) precipitation += hourly.current.rain;
    if (hourly.current.snow > 0) precipitation += hourly.current.snow;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 8, 0, 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Text(
                    getDateTime(
                      DateTime.fromMillisecondsSinceEpoch(hourly.current.dt,
                          isUtc: true),
                    ),
                    style: Theme.of(context).textTheme.overline,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getTemp(hourly.current.temp),
                    ),
                    WindIcon(
                      degree: hourly.current.wind_deg,
                    ),
                    Text(getSpeed(hourly.current.wind_speed)),
                  ],
                ),
                Text(
                  'Pressure: ' + getPressure(hourly.current.pressure),
                ),
                Text('Humidity: ' + toPercentage(hourly.current.humidity)),
                Text('Clouds: ' + toPercentage(hourly.current.clouds)),
                Text('Probability of precipitation: ' +
                    toPercentage(hourly.pop)),
                Text('Last hour precipitation: $precipitation mm'),
              ],
            ),
            Expanded(
              child: WeatherIcon(
                icon: hourly.current.weather.icon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
