import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/api/OpenWeatherMapApi.dart';

import 'SettingsPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    fetchForecast(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: _widgets.length,
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(54.0)),
          child: Center(
            child: _widgets[index],
          ),
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index % 3 == 0 ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        padding: EdgeInsets.all(8),
      ),
    );
  }

  List<Widget> _widgets = <Widget>[
    // Temperature
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('+14'),
            Icon(Icons.access_alarm),
          ],
        ),
        Text('Real feel +13'),
        Text('Updated 19:04'),
      ],
    ),
    // Wind
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.arrow_back_rounded),
        Text('4 m/s'),
        Text('Gusts 9 m/s'),
      ],
    ),
    // Precipitation
    Text('4 mm'),
    // Pressure
    Text('1000 hPa'),
    // Humidity
    Text('90%'),
    // Clouds
    Text('100%'),
    // UV-index
    Text('0'),
    // Visibility
    Text('10 km'),
  ];
}
