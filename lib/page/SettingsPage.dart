import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/datamodel/Coordinates.dart';

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
            Settings.setValue<String>('lan', coordinates.lan.toString());
            Settings.setValue<String>('lon', coordinates.lon.toString());
          },
          borderColor: Theme.of(context).accentColor,
          errorColor: Theme.of(context).errorColor,
        ),
        TextInputSettingsTile(
          title: 'Longitude',
          settingKey: 'lon',
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          borderColor: Theme.of(context).accentColor,
          errorColor: Theme.of(context).errorColor,
        ),
        TextInputSettingsTile(
          title: 'Latitude',
          settingKey: 'lan',
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          borderColor: Theme.of(context).accentColor,
          errorColor: Theme.of(context).errorColor,
        ),
        TextInputSettingsTile(
          title: 'API Key',
          settingKey: 'api-key',
          obscureText: true,
          borderColor: Theme.of(context).accentColor,
          errorColor: Theme.of(context).errorColor,
        ),
      ],
    );
  }
}
