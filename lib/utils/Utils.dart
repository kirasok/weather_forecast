import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:weather_forecast/enum/units/Temp.dart';

String toKelvin(double temp) {
  return temp.toString() + ' K';
}

String toCelsius(double temp) {
  double celsius = temp - 273.15;
  return celsius.toString() + ' °C';
}

String toHPa(double pressure) {
  return pressure.toString() + ' hPa';
}

String toKPa(double pressure) {
  return (pressure / 10).toString() + ' kPa';
}

String toMmHg(double pressure) {
  return (pressure * 0.7500616827).toString() + ' mmHg';
}

String toMS(double speed) {
  return speed.toString() + ' m/s';
}

String toKmH(double speed) {
  return (speed * 3.6).toString() + ' km/h';
}

String getTemp(double temp) {
  Temp format = Settings.getValue<Temp>('temp', Temp.Kelvin);
  switch(format) {
    case Temp.Kelvin:
      return toKelvin(temp);
    case Temp.Celsius:
      return toCelsius(temp);
  }
}