import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:weather_forecast/enum/format/DateTimeFormat.dart';
import 'package:weather_forecast/enum/units/Pressure.dart';
import 'package:weather_forecast/enum/units/Speed.dart';
import 'package:weather_forecast/enum/units/Temp.dart';

String toKelvin(double temp) {
  return temp.toStringAsFixed(2) + ' K';
}

String toCelsius(double temp) {
  double celsius = temp - 273.15;
  return celsius.toStringAsFixed(2) + ' °C';
}

String toHPa(double pressure) {
  return pressure.toStringAsFixed(2) + ' hPa';
}

String toKPa(double pressure) {
  return (pressure / 10).toStringAsFixed(2) + ' kPa';
}

String toMmHg(double pressure) {
  return (pressure * 0.7500616827).toStringAsFixed(2) + ' mmHg';
}

String toMS(double speed) {
  return speed.toStringAsFixed(2) + ' m/s';
}

String toKmH(double speed) {
  return (speed * 3.6).toStringAsFixed(2) + ' km/h';
}

String getTemp(double temp) {
  Temp format = Settings.getValue<Temp>('temp', Temp.Kelvin);
  switch (format) {
    case Temp.Kelvin:
      return toKelvin(temp);
    case Temp.Celsius:
      return toCelsius(temp);
  }
}

String getPressure(double pressure) {
  Pressure format = Settings.getValue<Pressure>('pressure', Pressure.hPa);
  switch (format) {
    case Pressure.hPa:
      return toHPa(pressure);
    case Pressure.kPa:
      return toKPa(pressure);
    case Pressure.mmHg:
      return toMmHg(pressure);
  }
}

String getSpeed(double speed) {
  Speed format = Settings.getValue<Speed>('speed', Speed.ms);
  switch (format) {
    case Speed.ms:
      return toMS(speed);
    case Speed.kmh:
      return toKmH(speed);
  }
}

String getDateTime(DateTime dateTime) {
  DateTimeFormat format =
      Settings.getValue<DateTimeFormat>('datetime', DateTimeFormat.System);
  dateTime = dateTime.toLocal();
  switch (format) {
    case DateTimeFormat.System:
      // TODO: use System locale
      return dateTime.toString();
    case DateTimeFormat.yyyyMMddHHmm:
      return dateTime.toIso8601String();
  }
}
