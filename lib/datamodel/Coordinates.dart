class Coordinates {
  double lan, lon;

  Coordinates({
    required this.lan,
    required this.lon,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lan: json['lan'] as double,
        lon: json['lon'] as double,
      );
}
