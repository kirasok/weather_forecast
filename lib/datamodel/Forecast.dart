import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Forecast extends HiveObject {
  final double lat;
  final double lon;
  final String timezone;
  final int timezone_offset;

  final Current current;
  final List<Minutely> minutely;
  final List<Hourly> hourly;
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
}

@HiveType(typeId: 1)
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
}

@HiveType(typeId: 2)
class Current {
  final int dt;
  final double temp;
  final double feels_like;
  final double pressure;
  final double humidity;
  final double dew_point;
  final double uvi;
  final double clouds;
  final double visibility;
  final double wind_speed;
  final double wind_gust; // Where available
  final double wind_deg;
  final double rain; // Where available
  final double snow; // Where available
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
}

@HiveType(typeId: 3)
class Minutely {
  final int dt;
  final double precipitation;

  Minutely({
    required this.dt,
    required this.precipitation,
  });
}

@HiveType(typeId: 4)
class Hourly {
  final Current current;
  final double pop;

  Hourly({
    required this.current,
    required this.pop,
  });
}

@HiveType(typeId: 5)
class Temp {
  final double morn;
  final double day;
  final double eve;
  final double night;
  final double min;
  final double max;

  Temp({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
    required this.min,
    required this.max,
  });
}

@HiveType(typeId: 6)
class Feels_like {
  final double morn;
  final double day;
  final double eve;
  final double night;

  Feels_like({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
  });
}

@HiveType(typeId: 7)
class Daily {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moon_phase;
  final Temp temp;
  final Feels_like feels_like;
  final double pressure;
  final double humidity;
  final double dew_point;
  final double wind_speed;
  final double wind_gust; // Where available
  final double wind_deg, clouds;
  final double uvi;
  final double pop;
  final double rain; // Where available
  final double snow; // Where available
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
}
