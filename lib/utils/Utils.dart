String toKelvin(double temp) {
  return temp.toString() + ' K';
}

String toCelsius(double temp) {
  double celsius = temp - 273.15;
  return celsius.toString() + ' °C';
}

String toHPa(double pressure) {
  return pressure.toString() + ' hPa';
}

String toKPa(double pressure) {
  return (pressure / 10).toString() + ' kPa';
}

String toMmHg(double pressure) {
  return (pressure * 0.7500616827).toString() + ' mmHg';
}
