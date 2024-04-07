# [Weather Forecast](https://kirasok.github.io/weather_forecast)

An app that shows the current weather, 1-hour detailed weather forecast for 48 hours and 1-day detailed for 7 days.

- Supports different units
- Organises data in charts
- Supports light/dark themes
- Uses OpenWeatherMap as data provider

## Get OpenWeatherMap API key

> [!warning]
> This app supports only v2.5 of OneCall API  
> OpenWeatherMap **doesn't allow new accounts** to use v2.5 of OneCall API

This app uses OpenWeatherMap API so you need it's key.  
Follow this steps if you don't have one:

1. [Sign up in OpenWeatherMap](https://openweathermap.org/home/sign_up)
1. You will find API Key in a confirmation email or you can go to [account page](https://home.openweathermap.org/api_keys).
1. You can enter API key on first start or in settings.

## Build

### Android

Follow steps to [sign your app](https://flutter.dev/docs/deployment/android#signing-the-app)

#### Linux CLI

Run:

```sh
git clone https://github.com/kirasok/weather_forecast.git
cd weather_forecast
flutter pub get
flutter build apk --obfuscate --split-debug-info=split_debug_info
```

Now you can get apk in `build/app/outputs/flutter-apk/app-release.apk`

## License

Source code available under [GNU GENERAL PUBLIC LICENSE](https://www.gnu.org/licenses).
