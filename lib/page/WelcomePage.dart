import 'package:flutter/material.dart';
import 'package:weather_forecast/widget/NextPageButton.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: size.height / 2,
            width: size.width * 0.66,
            child: Text(
              'Welcome to\nWeather Forecast',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .apply(fontWeightDelta: 3),
            ),
          ),
          NextPageButton(
            onPressed: () {},
            size: size,
          ),
        ],
      ),
    );
  }
}
