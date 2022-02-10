import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String icon;

  const WeatherIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    // If in dark mode
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      decoration = BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.5),
        shape: BoxShape.circle,
      );
      // If in light mode
    } else {
      decoration = BoxDecoration();
    }

    return Container(
      margin: EdgeInsets.all(16),
      decoration: decoration,
      child: CachedNetworkImage(
        imageUrl: 'https://openweathermap.org/img/wn/$icon@2x.png',
        placeholder: (_, __) => SizedBox(
          height: 100,
          width: 100,
        ),
        errorWidget: (_, __, ___) => SizedBox(
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
