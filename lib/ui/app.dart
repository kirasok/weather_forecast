import 'package:dynamic_color/dynamic_color.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'page/ForecastPage.dart';
import 'page/WelcomePage.dart';
import 'theme/colors.dart';

class MainApp extends StatelessWidget {
  ColorScheme _staticColorscheme(Brightness brightness) =>
      SeedColorScheme.fromSeeds(
          primaryKey: primaryColorSeed,
          secondaryKey: secondaryColorSeed,
          tertiaryKey: tertiaryColorSeed,
          brightness: brightness,
          tones: FlexTones.vivid(brightness));

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) {
          var themeLight = ThemeData.light().copyWith(
            useMaterial3: true,
            colorScheme: lightDynamic ?? _staticColorscheme(Brightness.light),
            cardTheme: CardTheme.of(context).copyWith(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 5,
              margin: EdgeInsets.all(8),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
            ),
          );

          var themeDark = ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: darkDynamic ?? _staticColorscheme(Brightness.dark),
            cardTheme: CardTheme.of(context).copyWith(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              elevation: 5,
              margin: EdgeInsets.all(8),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
            ),
          );

          final isIntroPlayed =
              Settings.getValue<bool>('isIntroPlayed') ?? false;
          Widget home;

          if (isIntroPlayed)
            home = ForecastPage();
          else
            home = WelcomePage();
          return MaterialApp(
            title: 'Weather Forecast',
            theme: themeLight,
            darkTheme: themeDark,
            themeMode: ThemeMode.system,
            home: home,
          );
        },
      );
}
