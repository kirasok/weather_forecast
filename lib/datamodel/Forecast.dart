import 'dart:core';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/utils/Utils.dart';

part 'Forecast.g.dart';

@HiveType(typeId: 0)
class Forecast extends HiveObject {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lon;
  @HiveField(2)
  final String timezone;
  @HiveField(3)
  final int timezone_offset;

  @HiveField(4)
  final Current current;
  @HiveField(5)
  final List<Minutely> minutely;
  @HiveField(6)
  final List<Hourly> hourly;
  @HiveField(7)
  final List<Daily> daily;

  Forecast({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezone_offset,
    required this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
  });

  static Forecast fromJson(Map<String, dynamic> json) => Forecast(
        lat: json['lat'],
        lon: json['lon'],
        timezone: json['timezone'],
        timezone_offset: json['timezone_offset'],
        current: Current.fromJson(json['current']),
        minutely: List.generate(
          61,
          (index) => Minutely.fromJson(json['minutely'][index]),
        ),
        hourly: List.generate(
          48,
          (index) => Hourly.fromJson(json['hourly'][index]),
        ),
        daily: List.generate(
          8,
          (index) => Daily.fromJson(json['daily'][index]),
        ),
      );

  List<charts.Series<ChartData, DateTime>> getTempData() {
    final min = List.generate(
      daily.length,
      (index) => ChartData(
        DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
        daily[index].temp.min,
      ),
    );
    final max = List.generate(
      daily.length,
      (index) => ChartData(
        DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
        daily[index].temp.max,
      ),
    );
    final morn = List.generate(
      daily.length,
      (index) => ChartData(
        DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
        daily[index].temp.morn,
      ),
    );
    final day = List.generate(
      daily.length,
      (index) => ChartData(
        DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
        daily[index].temp.day,
      ),
    );
    final eve = List.generate(
      daily.length,
      (index) => ChartData(
        DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
        daily[index].temp.eve,
      ),
    );
    final night = List.generate(
      daily.length,
      (index) => ChartData(
        DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
        daily[index].temp.night,
      ),
    );

    return [
      charts.Series<ChartData, DateTime>(
        id: 'Min',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getTempWithoutUnit(data.value),
        data: min,
      ),
      charts.Series<ChartData, DateTime>(
        id: 'Max',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getTempWithoutUnit(data.value),
        data: max,
      ),
      charts.Series<ChartData, DateTime>(
        id: 'Morning',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getTempWithoutUnit(data.value),
        data: morn,
      ),
      charts.Series<ChartData, DateTime>(
        id: 'Day',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getTempWithoutUnit(data.value),
        data: day,
      ),
      charts.Series<ChartData, DateTime>(
        id: 'Evening',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getTempWithoutUnit(data.value),
        data: eve,
      ),
      charts.Series<ChartData, DateTime>(
        id: 'Night',
        colorFn: (_, __) => charts.MaterialPalette.gray.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getTempWithoutUnit(data.value),
        data: night,
      ),
    ];
  }

  List<charts.Series<ChartData, DateTime>> getWindSpeedData() {
    final speed = List.generate(
      daily.length,
      (index) => ChartData(
        DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
        daily[index].wind_speed,
      ),
    );
    return [
      charts.Series<ChartData, DateTime>(
        id: 'Wind Speed',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getSpeedWithoutUnit(data.value),
        data: speed,
      ),
    ];
  }

  List<charts.Series<ChartData, DateTime>> getPressureData() {
    final pressure = List.generate(
      daily.length,
      (index) => ChartData(DateTime.fromMillisecondsSinceEpoch(daily[index].dt),
          daily[index].pressure),
    );
    return [
      charts.Series<ChartData, DateTime>(
        id: 'Pressure',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (ChartData data, _) => data.dt,
        measureFn: (ChartData data, _) => getPressureWithoutUnit(data.value),
        data: pressure,
      )
    ];
  }
}

class ChartData {
  final DateTime dt;
  final double value;

  ChartData(this.dt, this.value);
}

@HiveType(typeId: 1)
class Weather {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String main;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  static Weather fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );
}

@HiveType(typeId: 2)
class Current extends HiveObject {
  @HiveField(0)
  final int dt;
  @HiveField(1)
  final double temp;
  @HiveField(2)
  final double feels_like;
  @HiveField(3)
  final double pressure;
  @HiveField(4)
  final double humidity;
  @HiveField(5)
  final double dew_point;
  @HiveField(6)
  final double uvi;
  @HiveField(7)
  final double clouds;
  @HiveField(8)
  final double visibility;
  @HiveField(9)
  final double wind_speed;
  @HiveField(10)
  final double wind_gust; // Where available
  @HiveField(11)
  final double wind_deg;
  @HiveField(12)
  final double rain; // Where available
  @HiveField(13)
  final double snow; // Where available
  @HiveField(14)
  final Weather weather;

  Current({
    required this.dt,
    required this.temp,
    required this.feels_like,
    required this.pressure,
    required this.humidity,
    required this.dew_point,
    required this.clouds,
    required this.uvi,
    required this.visibility,
    required this.wind_speed,
    required this.wind_gust,
    required this.wind_deg,
    required this.rain,
    required this.snow,
    required this.weather,
  });

  static Current fromJson(Map<String, dynamic> json) {
    // Ensure that this keys present in map
    // Set their value to -1 to know that this keys was not present in the response
    var temp = Map<String, dynamic>();
    temp['1h'] = -1;
    json.putIfAbsent('wind_gust', () => -1);
    json.putIfAbsent('rain', () => temp);
    json.putIfAbsent('snow', () => temp);
    return Current(
      dt: json['dt'] * 1000,
      temp: json['temp'] * 1.0,
      feels_like: json['feels_like'] * 1.0,
      pressure: json['pressure'] * 1.0,
      // In Dart you cannot directly put int value to double
      humidity: json['humidity'] * 1.0,
      dew_point: json['dew_point'] * 1.0,
      clouds: json['clouds'] * 1.0,
      uvi: json['uvi'] * 1.0,
      visibility: json['visibility'] * 1.0,
      wind_speed: json['wind_speed'] * 1.0,
      wind_gust: json['wind_gust'] * 1.0,
      wind_deg: json['wind_deg'] * 1.0,
      rain: json['rain']['1h'] * 1.0,
      snow: json['snow']['1h'] * 1.0,
      weather: Weather.fromJson(json['weather'][0]),
    );
  }
}

@HiveType(typeId: 3)
class Minutely extends HiveObject {
  @HiveField(0)
  final int dt;
  @HiveField(1)
  final double precipitation;

  Minutely({
    required this.dt,
    required this.precipitation,
  });

  static Minutely fromJson(Map<String, dynamic> json) => Minutely(
        dt: json['dt'] * 1000,
        precipitation: json['precipitation'] * 1.0,
      );
}

@HiveType(typeId: 4)
class Hourly extends HiveObject {
  @HiveField(0)
  final Current current;
  @HiveField(1)
  final double pop;

  Hourly({
    required this.current,
    required this.pop,
  });

  static Hourly fromJson(Map<String, dynamic> json) => Hourly(
        current: Current.fromJson(json),
        pop: json['pop'] * 1.0,
      );
}

@HiveType(typeId: 5)
class Temp extends HiveObject {
  @HiveField(0)
  final double morn;
  @HiveField(1)
  final double day;
  @HiveField(2)
  final double eve;
  @HiveField(3)
  final double night;
  @HiveField(4)
  final double min;
  @HiveField(5)
  final double max;

  Temp({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
    required this.min,
    required this.max,
  });

  static Temp fromJson(Map<String, dynamic> json) => Temp(
        morn: json['morn'] * 1.0,
        day: json['day'] * 1.0,
        eve: json['eve'] * 1.0,
        night: json['night'] * 1.0,
        min: json['min'] * 1.0,
        max: json['max'] * 1.0,
      );
}

@HiveType(typeId: 6)
class Feels_like extends HiveObject {
  @HiveField(0)
  final double morn;
  @HiveField(1)
  final double day;
  @HiveField(2)
  final double eve;
  @HiveField(3)
  final double night;

  Feels_like({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
  });

  static Feels_like fromJson(Map<String, dynamic> json) => Feels_like(
        morn: json['morn'] * 1.0,
        day: json['day'] * 1.0,
        eve: json['eve'] * 1.0,
        night: json['night'] * 1.0,
      );
}

@HiveType(typeId: 7)
class Daily extends HiveObject {
  @HiveField(0)
  final int dt;
  @HiveField(1)
  final int sunrise;
  @HiveField(2)
  final int sunset;
  @HiveField(3)
  final int moonrise;
  @HiveField(4)
  final int moonset;
  @HiveField(5)
  final double moon_phase;
  @HiveField(6)
  final Temp temp;
  @HiveField(7)
  final Feels_like feels_like;
  @HiveField(8)
  final double pressure;
  @HiveField(9)
  final double humidity;
  @HiveField(10)
  final double dew_point;
  @HiveField(11)
  final double wind_speed;
  @HiveField(12)
  final double wind_gust; // Where available
  @HiveField(13)
  final double wind_deg;
  @HiveField(14)
  final double clouds;
  @HiveField(15)
  final double uvi;
  @HiveField(16)
  final double pop;
  @HiveField(17)
  final double rain; // Where available
  @HiveField(18)
  final double snow; // Where available
  @HiveField(19)
  final Weather weather;

  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moon_phase,
    required this.temp,
    required this.feels_like,
    required this.pressure,
    required this.humidity,
    required this.dew_point,
    required this.wind_speed,
    required this.wind_gust,
    required this.wind_deg,
    required this.clouds,
    required this.uvi,
    required this.pop,
    required this.rain,
    required this.snow,
    required this.weather,
  });

  static Daily fromJson(Map<String, dynamic> json) {
    // Ensure that this keys present in map
    // Set their value to -1 to know that this keys was not present in the response
    json.putIfAbsent('wind_gust', () => -1);
    json.putIfAbsent('rain', () => -1);
    json.putIfAbsent('snow', () => -1);
    return Daily(
      dt: json['dt'] * 1000,
      sunrise: json['sunrise'] * 1000,
      sunset: json['sunset'] * 1000,
      moonrise: json['moonrise'] * 1000,
      moonset: json['moonset'] * 1000,
      moon_phase: json['moon_phase'] * 1.0,
      temp: Temp.fromJson(json['temp']),
      feels_like: Feels_like.fromJson(json['feels_like']),
      pressure: json['pressure'] * 1.0,
      humidity: json['humidity'] * 1.0,
      dew_point: json['dew_point'] * 1.0,
      wind_speed: json['wind_speed'] * 1.0,
      wind_gust: json['wind_gust'] * 1.0,
      wind_deg: json['wind_deg'] * 1.0,
      clouds: json['clouds'] * 1.0,
      uvi: json['uvi'] * 1.0,
      pop: json['pop'] * 1.0,
      rain: json['rain'] * 1.0,
      snow: json['snow'] * 1.0,
      weather: Weather.fromJson(json['weather'][0]),
    );
  }
}
