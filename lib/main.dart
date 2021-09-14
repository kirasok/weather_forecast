import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/MainApp.dart';

void main() async {
  await Settings.init();
  await Hive.initFlutter();
  runApp(MainApp());
}