import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';
import 'package:weather_forecast/database/HiveUtils.dart';
import 'package:weather_forecast/datamodel/Coordinates.dart';
import 'package:weather_forecast/page/ForecastPage.dart';
import 'package:weather_forecast/widget/NextPageButton.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var key = '';
    var city = '';

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
                      .headline5!
                      .apply(fontWeightDelta: 3),
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
                    onChanged: (value) => key = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(32, 4, 48, 4),
                  alignment: AlignmentDirectional.topEnd,
                  child: InkWell(
                    child: Text(
                      'Where to get one?',
                      style: Theme.of(context).textTheme.overline!.apply(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSizeFactor: 1.2,
                          ),
                    ),
                    onTap: () => launch(
                      'https://github.com/kirillmokretsov/weather_forecast/blob/master/README.md#get-openweathermap-api-key',
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
                    onChanged: (value) => city = value,
                  ),
                )
              ],
            ),
          ),
          NextPageButton(
            onPressed: () async {
              try {
                await Settings.setValue('api-key', key);
                await Settings.setValue('city', city);
                Coordinates coordinates = await fetchCoordinates(http.Client());
                await Settings.setValue<String>(
                    'lat', coordinates.lat.toString());
                await Settings.setValue<String>(
                    'lon', coordinates.lon.toString());
                await Settings.setValue<String>('city', city);
                await fetchThenPutForecast();
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
