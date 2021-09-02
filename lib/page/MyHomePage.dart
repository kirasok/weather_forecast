import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
    Row(
      children: [
        Text('+14'),
        Icon(Icons.access_alarm),
      ],
    ),
    Column(
      children: [Icon(Icons.arrow_back_rounded), Text('4 m/s')],
    ),
    Text('4 mm'),
    Text('1000 hPa'),
    Text('90%'),
    Text('0'),
    Text('3'),
  ];
}
