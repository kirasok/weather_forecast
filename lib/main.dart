import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'app/MainApp.dart';

void main() async {
  await Settings.init();
  runApp(MainApp());
}