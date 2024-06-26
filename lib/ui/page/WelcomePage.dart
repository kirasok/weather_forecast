import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_forecast/data/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/data/database/HiveUtils.dart';
import 'package:weather_forecast/data/datamodel/Coordinates.dart';
import 'package:weather_forecast/widget/NextPageButton.dart';

import 'ForecastPage.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to\nWeather Forecast',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.apply(fontWeightDelta: 3),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(32, 32, 32, 4),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'OpenWeatherMap API Key',
                    ),
                    controller: _keyController,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(32, 4, 48, 4),
                  alignment: AlignmentDirectional.topEnd,
                  child: InkWell(
                    child: Text(
                      'Where to get one?',
                      style: Theme.of(context).textTheme.labelSmall?.apply(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSizeFactor: 1.2,
                          ),
                    ),
                    onTap: () => launchUrl(
                      Uri.https(
                        'github.com',
                        "/kirasok/weather_forecast/blob/main/README.md",
                        {'#': 'get-openweathermap-api-key'},
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 8,
                  ),
                  child: TextField(
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_on),
                      labelText: 'City',
                    ),
                    controller: _cityController,
                  ),
                )
              ],
            ),
          ),
          NextPageButton(
            onPressed: () async {
              try {
                final key = _keyController.value.text.toString();
                final city = _cityController.value.text.toString();
                await Settings.setValue('api-key', key);
                await Settings.setValue('city', city);
                Coordinates coordinates = await fetchCoordinates(http.Client());
                await Settings.setValue<String>(
                    'lat', coordinates.lat.toString());
                await Settings.setValue<String>(
                    'lon', coordinates.lon.toString());
                await fetchThenPutForecast();
                await Settings.setValue('isIntroPlayed', true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ForecastPage(),
                  ),
                );
              } catch (e) {
                var code = int.parse(e.toString().substring(11));
                switch (code) {
                  case 401:
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Wrong API key'),
                      ),
                    );
                    break;
                  case 400:
                  case 404:
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Wrong city name'),
                      ),
                    );
                    break;
                }
              }
            },
            size: size,
          ),
          Positioned(
            height: size.height * 0.25,
            bottom: -(size.height * 0.08),
            child: Image.asset('assets/background/welcome/bottom-left.png'),
          ),
          Positioned(
            height: size.height * 0.25,
            child: Image.asset('assets/background/welcome/top-left.png'),
          ),
          Positioned(
            height: size.height * 0.15,
            right: 0,
            top: size.height * 0.13,
            child: Image.asset('assets/background/welcome/right.png'),
          ),
        ],
      ),
    );
  }
}
