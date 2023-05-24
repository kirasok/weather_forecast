class Coordinates {
  double lat, lon;

  Coordinates({
    required this.lat,
    required this.lon,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json['coord']['lat'] as double,
        lon: json['coord']['lon'] as double,
      );
}
