String toKelvin(double temp) {
  return temp.toString() + ' K';
}

String toCelsium(double temp) {
  double celsium = temp - 273.15;
  return celsium.toString() + ' °C';
}

String toFahrenheit(double temp) {
  double fahrenheit = ((temp - 273.15) * 9) / 5 + 32;
  return fahrenheit.toString() + ' °F';
}