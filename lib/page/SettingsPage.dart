import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/database/HiveUtils.dart';
import 'package:weather_forecast/datamodel/Coordinates.dart';
import 'package:weather_forecast/datamodel/Forecast.dart';

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
            Forecast forecast = await fetchForecast(http.Client());
            putForecast(forecast);
          },
          borderColor: Theme.of(context).colorScheme.secondary,
          errorColor: Theme.of(context).errorColor,
        ),
        // TODO: use same TextStyle
        ListTile(
          title: Text('Longitude'),
          subtitle: Text(Settings.getValue('lon', '')),
        ),
        ListTile(
          title: Text('Latitude'),
          subtitle: Text(Settings.getValue('lat', '')),
        ),
        TextInputSettingsTile(
          title: 'API Key',
          settingKey: 'api-key',
          obscureText: true,
          borderColor: Theme.of(context).colorScheme.secondary,
          errorColor: Theme.of(context).errorColor,
        ),
        SettingsGroup(
          title: 'Localization',
          children: [
            RadioModalSettingsTile(
              title: 'Date and time',
              settingKey: 'datetime',
              selected: 0,
              values: <int, String>{
                0: 'System',
                1: 'yyyy-MM-dd HH:mm',
              },
            ),
            RadioModalSettingsTile(
              title: 'Temperature',
              settingKey: 'temp',
              selected: 0,
              values: <int, String>{
                0: 'System',
                1: 'Kelvin',
                2: 'Celsius',
              },
            ),
            RadioModalSettingsTile(
              title: 'Pressure',
              settingKey: 'pressure',
              selected: 0,
              values: <int, String>{
                0: 'System',
                3: 'kPa',
                4: 'mmHg',
              },
            ),
            RadioModalSettingsTile(
              title: 'Speed',
              settingKey: 'speed',
              selected: 0,
              values: <int, String>{
                0: 'System',
                1: 'm/s',
                2: 'km/h',
              },
            ),
          ],
        ),
      ],
    );
  }
}
