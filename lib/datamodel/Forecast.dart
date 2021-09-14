class Forecast {
  final double lat, lon;
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

class Weather {
  final int id;
  final String main, description, icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
}

class Current {
  final int dt;
  final double temp,
      feels_like,
      pressure,
      humidity,
      dew_point,
      uvi,
      clouds,
      visibility,
      wind_speed,
      wind_gust, // Where available
      wind_deg,
      rain, // Where available
      snow; // Where available
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

class Minutely {
  final int dt;
  final double precipitation;

  Minutely({
    required this.dt,
    required this.precipitation,
  });
}

class Hourly {
  final Current current;
  final double pop;

  Hourly({
    required this.current,
    required this.pop,
  });
}

class Temp {
  final double morn, day, eve, night, min, max;

  Temp({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
    required this.min,
    required this.max,
  });
}

class Feels_like {
  final double morn, day, eve, night;

  Feels_like({
    required this.morn,
    required this.day,
    required this.eve,
    required this.night,
  });
}

class Daily {
  final int dt, sunrise, sunset, moonrise, moonset;
  final double moon_phase;
  final Temp temp;
  final Feels_like feels_like;
  final double pressure,
      humidity,
      dew_point,
      wind_speed,
      wind_gust, // Where available
      wind_deg,
      clouds,
      uvi,
      pop,
      rain, // Where available
      snow; // Where available
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
