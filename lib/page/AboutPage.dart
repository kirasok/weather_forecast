import 'package:about/about.dart';
import 'package:flutter/material.dart';

// TODO: use package_info_plus
// TODO: add link to GitHub

class AboutPage {
  static Future<void> showAbout(BuildContext context) async {
    return showAboutPage(
      context: context,
      values: {
        'year': DateTime.now().year.toString(),
      },
      title: Text('Weather Forecast'),
      applicationName: 'Weather Forecast',
      applicationVersion: '1.0.0',
      applicationIcon: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset(
          'assets/icon/app.png',
          fit: BoxFit.scaleDown,
        ),
      ),
      applicationLegalese: 'Copyright © Kirill Mokretsov, {{ year }}',
      applicationDescription: Text(
        'Weather Forecast using OpenWeatherMap API',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      children: <Widget>[
        MarkdownPageListTile(
          icon: Icon(Icons.menu_book_outlined),
          title: Text("View README"),
          filename: "README.md",
        ),
        // TODO: add changelog
        MarkdownPageListTile(
          icon: Icon(Icons.description),
          title: Text("View license"),
          filename: "LICENSE.md",
        ),
        // TODO: add contributing
        // TODO: add code of conduct
        LicensesPageListTile(
          icon: Icon(Icons.favorite),
          title: Text("Open source licenses"),
        ),
      ],
    );
  }
}
