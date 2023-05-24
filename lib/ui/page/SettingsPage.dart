import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/data/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/data/database/HiveUtils.dart';
import 'package:weather_forecast/data/datamodel/Coordinates.dart';
import 'package:weather_forecast/enum/format/DateTimeFormat.dart';
import 'package:weather_forecast/enum/units/Pressure.dart';
import 'package:weather_forecast/enum/units/Speed.dart';
import 'package:weather_forecast/enum/units/Temp.dart' as Units;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: 'Settings',
      children: [
        TextInputSettingsTile(
          title: 'City',
          settingKey: 'city',
          initialValue: 'London',
          onChange: (String value) async {
            Coordinates coordinates = await fetchCoordinates(http.Client());
            Settings.setValue<String>('lat', coordinates.lat.toString());
            Settings.setValue<String>('lon', coordinates.lon.toString());
            setState(() {});
            fetchThenPutForecast();
          },
          borderColor: Theme.of(context).colorScheme.secondary,
          errorColor: Theme.of(context).colorScheme.error,
        ),
        // TODO: use same TextStyle
        ListTile(
          title: Text('Longitude'),
          subtitle: Text(Settings.getValue('lon') ?? ''),
        ),
        ListTile(
          title: Text('Latitude'),
          subtitle: Text(Settings.getValue('lat') ?? ''),
        ),
        TextInputSettingsTile(
          title: 'API Key',
          settingKey: 'api-key',
          obscureText: true,
          borderColor: Theme.of(context).colorScheme.secondary,
          errorColor: Theme.of(context).colorScheme.error,
        ),
        SettingsGroup(
          title: 'Localization',
          children: [
            RadioModalSettingsTile(
              title: 'Date and time',
              settingKey: 'datetime',
              selected: DateTimeFormat.System,
              values: <DateTimeFormat, String>{
                DateTimeFormat.System: 'System',
                DateTimeFormat.yyyyMMddHHmm: 'yyyy-MM-dd HH:mm',
                DateTimeFormat.iso8601: 'ISO 8601',
              },
            ),
            RadioModalSettingsTile(
              title: 'Temperature',
              settingKey: 'temp',
              selected: Units.Temp.Kelvin,
              values: <Units.Temp, String>{
                Units.Temp.Kelvin: 'Kelvin',
                Units.Temp.Celsius: 'Celsius',
              },
            ),
            RadioModalSettingsTile(
              title: 'Pressure',
              settingKey: 'pressure',
              selected: Pressure.hPa,
              values: <Pressure, String>{
                Pressure.hPa: 'hPa',
                Pressure.kPa: 'kPa',
                Pressure.mmHg: 'mmHg',
              },
            ),
            RadioModalSettingsTile(
              title: 'Speed',
              settingKey: 'speed',
              selected: Speed.ms,
              values: <Speed, String>{
                Speed.ms: 'm/s',
                Speed.kmh: 'km/h',
              },
            ),
          ],
        ),
      ],
    );
  }
}
