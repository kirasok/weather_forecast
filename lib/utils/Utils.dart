import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/enum/format/DateTimeFormat.dart';
import 'package:weather_forecast/enum/units/Pressure.dart';
import 'package:weather_forecast/enum/units/Speed.dart';
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

String getPressure(double pressure) {
  Pressure format = Settings.getValue<Pressure>('pressure', Pressure.hPa);
  switch(format) {
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
  switch(format) {
    case Speed.ms:
      return toMS(speed);
    case Speed.kmh:
      return toKmH(speed);
  }
}

String getDateTime(DateTime dateTime) {
  DateTimeFormat format = Settings.getValue<DateTimeFormat>('datetime', DateTimeFormat.System);
  dateTime = dateTime.toLocal();
  switch(format) {
    case DateTimeFormat.System:
      // TODO: use System locale
      return DateFormat('y-M-d H:m').format(dateTime);
    case DateTimeFormat.yyyyMMddHHmm:
      return DateFormat('y-M-d H:m').format(dateTime);
  }
}