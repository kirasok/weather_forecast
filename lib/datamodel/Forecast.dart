import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_forecast/Constants.dart';

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
  final HiveList<Minutely> minutely;
  @HiveField(6)
  final HiveList<Hourly> hourly;
  @HiveField(7)
  final HiveList<Daily> daily;

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
        minutely: HiveList(
          Hive.box(Constants.forecast_box),
          objects: List.generate(
            61,
            (index) => Minutely.fromJson(json['minutely'][index]),
          ),
        ),
        hourly: HiveList(
          Hive.box(Constants.forecast_box),
          objects: List.generate(
            48,
            (index) => Hourly.fromJson(json['hourly'][index]),
          ),
        ),
        daily: HiveList(
          Hive.box(Constants.forecast_box),
          objects: List.generate(8, (index) => json['daily'][index]),
        ),
      );
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
    json.putIfAbsent('wind_gust', () => -1);
    json.putIfAbsent('rain', () => -1);
    json.putIfAbsent('snow', () => -1);
    return Current(
      dt: json['dt'],
      temp: json['temp'],
      feels_like: json['feels_like'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      dew_point: json['dew_point'],
      clouds: json['clouds'],
      uvi: json['uvi'],
      visibility: json['visibility'],
      wind_speed: json['wind_speed'],
      wind_gust: json['wind_gust'],
      wind_deg: json['wind_deg'],
      rain: json['rain'],
      snow: json['snow'],
      weather: Weather.fromJson(json['weather']['0']),
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
        dt: json['dt'],
        precipitation: json['precipitation'],
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
        pop: json['pop'],
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
        morn: json['morn'],
        day: json['day'],
        eve: json['eve'],
        night: json['night'],
        min: json['min'],
        max: json['max'],
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
        morn: json['morn'],
        day: json['day'],
        eve: json['eve'],
        night: json['night'],
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
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moon_phase: json['moon_phase'],
      temp: Temp.fromJson(json['temp']),
      feels_like: Feels_like.fromJson(json['feels_like3']),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dew_point: json['dew_point'],
      wind_speed: json['wind_speed'],
      wind_gust: json['wind_gust'],
      wind_deg: json['wind_deg'],
      clouds: json['clouds'],
      uvi: json['uvi'],
      pop: json['pop'],
      rain: json['rain'],
      snow: json['snow'],
      weather: json['weather'],
    );
  }
}
