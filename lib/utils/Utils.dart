import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/enum/format/DateTimeFormat.dart';
import 'package:weather_forecast/enum/units/Pressure.dart';
import 'package:weather_forecast/enum/units/Speed.dart';
import 'package:weather_forecast/enum/units/Temp.dart';

String formatDouble(double value) {
  final formatter = NumberFormat();
  formatter.minimumFractionDigits = 0;
  formatter.maximumFractionDigits = 2;
  return formatter.format(value);
}

String toKelvin(double temp) => formatDouble(temp) + ' K';

String toCelsius(double temp) => formatDouble((temp - 273.15)) + ' °C';

String toHPa(double pressure) => formatDouble(pressure) + ' hPa';

String toKPa(double pressure) => formatDouble(pressure / 10) + ' kPa';

String toMmHg(double pressure) =>
    formatDouble((pressure * 0.7500616827)) + ' mmHg';

String toMS(double speed) => formatDouble(speed) + ' m/s';

String toKmH(double speed) => formatDouble((speed * 3.6)) + ' km/h';

String toPercentage(double percentage) => formatDouble(percentage) + '%';

String toDistance(double distance) => formatDouble(distance) + ' m';

String getTemp(double temp) {
  final format = Settings.getValue<Temp>('temp') ?? Temp.Kelvin;
  switch (format) {
    case Temp.Kelvin:
      return toKelvin(temp);
    case Temp.Celsius:
      return toCelsius(temp);
  }
}

double getTempWithoutUnit(double temp) {
  final format = Settings.getValue<Temp>('temp') ?? Temp.Kelvin;
  switch (format) {
    case Temp.Kelvin:
      return temp;
    case Temp.Celsius:
      return (temp - 273.15);
  }
}

String getPressure(double pressure) {
  final format = Settings.getValue<Pressure>('pressure') ?? Pressure.hPa;
  switch (format) {
    case Pressure.hPa:
      return toHPa(pressure);
    case Pressure.kPa:
      return toKPa(pressure);
    case Pressure.mmHg:
      return toMmHg(pressure);
  }
}

double getPressureWithoutUnit(double pressure) {
  final format = Settings.getValue<Pressure>('pressure') ?? Pressure.hPa;
  switch (format) {
    case Pressure.hPa:
      return pressure;
    case Pressure.kPa:
      return pressure / 10;
    case Pressure.mmHg:
      return pressure * 0.7500616827;
  }
}

String getSpeed(double speed) {
  final format = Settings.getValue<Speed>('speed') ?? Speed.ms;
  switch (format) {
    case Speed.ms:
      return toMS(speed);
    case Speed.kmh:
      return toKmH(speed);
  }
}

double getSpeedWithoutUnit(double speed) {
  final format = Settings.getValue<Speed>('speed') ?? Speed.ms;
  switch (format) {
    case Speed.ms:
      return speed;
    case Speed.kmh:
      return speed * 3.6;
  }
}

String getDateTime(DateTime dateTime) {
  final format =
      Settings.getValue<DateTimeFormat>('datetime') ?? DateTimeFormat.System;
  dateTime = dateTime.toLocal();
  switch (format) {
    case DateTimeFormat.System:
      var dateFormat = DateFormat.yMd().add_Hm();
      return dateFormat.format(dateTime);
    case DateTimeFormat.yyyyMMddHHmm:
      var string = dateTime.toString();
      string = string.substring(0, string.length - 7);
      return string;
    case DateTimeFormat.iso8601:
      return dateTime.toIso8601String();
  }
}
