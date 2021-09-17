String toKelvin(double temp) {
  return temp.toString() + ' K';
}

String toCelsius(double temp) {
  double celsius = temp - 273.15;
  return celsius.toString() + ' °C';
}

String toFahrenheit(double temp) {
  double fahrenheit = ((temp - 273.15) * 9) / 5 + 32;
  return fahrenheit.toString() + ' °F';
}
