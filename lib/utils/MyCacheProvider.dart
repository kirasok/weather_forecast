import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:weather_forecast/enum/format/DateTimeFormat.dart';
import 'package:weather_forecast/enum/units/Pressure.dart';
import 'package:weather_forecast/enum/units/Speed.dart';
import 'package:weather_forecast/enum/units/Temp.dart';

class MyCacheProvider extends SharePreferenceCache {
  @override
  Future<void> setObject<T>(String key, T value) {
    if (value is DateTimeFormat) return setDateTimeFormat(key, value);
    if (value is Pressure) return setPressure(key, value);
    if (value is Speed) return setSpeed(key, value);
    if (value is Temp) return setTemp(key, value);
    return super.setObject<T>(key, value);
  }

  @override
  T getValue<T>(String key, T defaultValue) {
    if (defaultValue is DateTimeFormat) return getDateTimeFormat(key) as T;
    if (defaultValue is Pressure) return getPressure(key) as T;
    if (defaultValue is Speed) return getSpeed(key) as T;
    if (defaultValue is Temp) return getTemp(key) as T;
    return super.getValue<T>(key, defaultValue);
  }

  Future<void> setDateTimeFormat(String key, DateTimeFormat? value,
      {DateTimeFormat? defaultValue}) {
    return super.setString(key, value.toString(),
        defaultValue: defaultValue.toString());
  }

  DateTimeFormat? getDateTimeFormat(String key) {
    String? format = super.getString(key);
    if (format != null) {
      switch (format) {
        case 'DateTimeFormat.System':
          return DateTimeFormat.System;
        case 'DateTimeFormat.yyyyMMddHHmm':
          return DateTimeFormat.yyyyMMddHHmm;
        default:
          throw Exception('Unknown format $format');
      }
    } else
      return null;
  }

  Future<void> setPressure(String key, Pressure? value,
      {Pressure? defaultValue}) {
    return super.setString(key, value.toString(),
        defaultValue: defaultValue.toString());
  }

  Pressure? getPressure(String key) {
    String? pressure = super.getString(key);
    if (pressure != null) {
      switch (pressure) {
        case 'Pressure.hPa':
          return Pressure.hPa;
        case 'Pressure.kPa':
          return Pressure.kPa;
        case 'Pressure.mmHg':
          return Pressure.mmHg;
        default:
          throw Exception('Unknown pressure $pressure');
      }
    } else
      return null;
  }

  Future<void> setSpeed(String key, Speed? value, {Speed? defaultValue}) {
    return super.setString(key, value.toString(),
        defaultValue: defaultValue.toString());
  }

  Speed? getSpeed(String key) {
    String? speed = super.getString(key);
    if (speed != null) {
      switch (speed) {
        case 'Speed.ms':
          return Speed.ms;
        case 'Speed.kmh':
          return Speed.kmh;
        default:
          throw Exception('Unknown speed $speed');
      }
    } else
      return null;
  }

  Future<void> setTemp(String key, Temp? value, {Temp? defaultValue}) {
    return super.setString(key, value.toString(),
        defaultValue: defaultValue.toString());
  }

  Temp? getTemp(String key) {
    String? temp = super.getString(key);
    if (temp != null) {
      switch (temp) {
        case 'Temp.Kelvin':
          return Temp.Kelvin;
        case 'Temp.Celsius':
          return Temp.Celsius;
        default:
          throw Exception('Unknown temp $temp');
      }
    } else
      return null;
  }
}
