import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:http/http.dart' as http;

Future<http.Response> fetchCoordinates(http.Client client) async {
  String city = Settings.getValue<String>('city', 'London');
  String key = Settings.getValue<String>('api-key', '');
  return client.get(
    Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$key'),
  );
}
