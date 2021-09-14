// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Forecast.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForecastAdapter extends TypeAdapter<Forecast> {
  @override
  final int typeId = 0;

  @override
  Forecast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Forecast(
      lat: fields[0] as double,
      lon: fields[1] as double,
      timezone: fields[2] as String,
      timezone_offset: fields[3] as int,
      current: fields[4] as Current,
      minutely: (fields[5] as HiveList).castHiveList(),
      hourly: (fields[6] as HiveList).castHiveList(),
      daily: (fields[7] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, Forecast obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.lat)
      ..writeByte(1)
      ..write(obj.lon)
      ..writeByte(2)
      ..write(obj.timezone)
      ..writeByte(3)
      ..write(obj.timezone_offset)
      ..writeByte(4)
      ..write(obj.current)
      ..writeByte(5)
      ..write(obj.minutely)
      ..writeByte(6)
      ..write(obj.hourly)
      ..writeByte(7)
      ..write(obj.daily);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForecastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherAdapter extends TypeAdapter<Weather> {
  @override
  final int typeId = 1;

  @override
  Weather read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Weather(
      id: fields[0] as int,
      main: fields[1] as String,
      description: fields[2] as String,
      icon: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Weather obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.main)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CurrentAdapter extends TypeAdapter<Current> {
  @override
  final int typeId = 2;

  @override
  Current read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Current(
      dt: fields[0] as int,
      temp: fields[1] as double,
      feels_like: fields[2] as double,
      pressure: fields[3] as double,
      humidity: fields[4] as double,
      dew_point: fields[5] as double,
      clouds: fields[7] as double,
      uvi: fields[6] as double,
      visibility: fields[8] as double,
      wind_speed: fields[9] as double,
      wind_gust: fields[10] as double,
      wind_deg: fields[11] as double,
      rain: fields[12] as double,
      snow: fields[13] as double,
      weather: fields[14] as Weather,
    );
  }

  @override
  void write(BinaryWriter writer, Current obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.feels_like)
      ..writeByte(3)
      ..write(obj.pressure)
      ..writeByte(4)
      ..write(obj.humidity)
      ..writeByte(5)
      ..write(obj.dew_point)
      ..writeByte(6)
      ..write(obj.uvi)
      ..writeByte(7)
      ..write(obj.clouds)
      ..writeByte(8)
      ..write(obj.visibility)
      ..writeByte(9)
      ..write(obj.wind_speed)
      ..writeByte(10)
      ..write(obj.wind_gust)
      ..writeByte(11)
      ..write(obj.wind_deg)
      ..writeByte(12)
      ..write(obj.rain)
      ..writeByte(13)
      ..write(obj.snow)
      ..writeByte(14)
      ..write(obj.weather);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MinutelyAdapter extends TypeAdapter<Minutely> {
  @override
  final int typeId = 3;

  @override
  Minutely read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Minutely(
      dt: fields[0] as int,
      precipitation: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Minutely obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.precipitation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MinutelyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HourlyAdapter extends TypeAdapter<Hourly> {
  @override
  final int typeId = 4;

  @override
  Hourly read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hourly(
      current: fields[0] as Current,
      pop: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Hourly obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.current)
      ..writeByte(1)
      ..write(obj.pop);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourlyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TempAdapter extends TypeAdapter<Temp> {
  @override
  final int typeId = 5;

  @override
  Temp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Temp(
      morn: fields[0] as double,
      day: fields[1] as double,
      eve: fields[2] as double,
      night: fields[3] as double,
      min: fields[4] as double,
      max: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Temp obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.morn)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.eve)
      ..writeByte(3)
      ..write(obj.night)
      ..writeByte(4)
      ..write(obj.min)
      ..writeByte(5)
      ..write(obj.max);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TempAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FeelslikeAdapter extends TypeAdapter<Feels_like> {
  @override
  final int typeId = 6;

  @override
  Feels_like read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Feels_like(
      morn: fields[0] as double,
      day: fields[1] as double,
      eve: fields[2] as double,
      night: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Feels_like obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.morn)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.eve)
      ..writeByte(3)
      ..write(obj.night);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeelslikeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyAdapter extends TypeAdapter<Daily> {
  @override
  final int typeId = 7;

  @override
  Daily read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Daily(
      dt: fields[0] as int,
      sunrise: fields[1] as int,
      sunset: fields[2] as int,
      moonrise: fields[3] as int,
      moonset: fields[4] as int,
      moon_phase: fields[5] as double,
      temp: fields[6] as Temp,
      feels_like: fields[7] as Feels_like,
      pressure: fields[8] as double,
      humidity: fields[9] as double,
      dew_point: fields[10] as double,
      wind_speed: fields[11] as double,
      wind_gust: fields[12] as double,
      wind_deg: fields[13] as double,
      clouds: fields[14] as double,
      uvi: fields[15] as double,
      pop: fields[16] as double,
      rain: fields[17] as double,
      snow: fields[18] as double,
      weather: fields[19] as Weather,
    );
  }

  @override
  void write(BinaryWriter writer, Daily obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.dt)
      ..writeByte(1)
      ..write(obj.sunrise)
      ..writeByte(2)
      ..write(obj.sunset)
      ..writeByte(3)
      ..write(obj.moonrise)
      ..writeByte(4)
      ..write(obj.moonset)
      ..writeByte(5)
      ..write(obj.moon_phase)
      ..writeByte(6)
      ..write(obj.temp)
      ..writeByte(7)
      ..write(obj.feels_like)
      ..writeByte(8)
      ..write(obj.pressure)
      ..writeByte(9)
      ..write(obj.humidity)
      ..writeByte(10)
      ..write(obj.dew_point)
      ..writeByte(11)
      ..write(obj.wind_speed)
      ..writeByte(12)
      ..write(obj.wind_gust)
      ..writeByte(13)
      ..write(obj.wind_deg)
      ..writeByte(14)
      ..write(obj.clouds)
      ..writeByte(15)
      ..write(obj.uvi)
      ..writeByte(16)
      ..write(obj.pop)
      ..writeByte(17)
      ..write(obj.rain)
      ..writeByte(18)
      ..write(obj.snow)
      ..writeByte(19)
      ..write(obj.weather);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
