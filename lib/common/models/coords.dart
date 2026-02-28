class Coords {
  final double lat;
  final double lon;
  Coords({required this.lat, required this.lon});
  Map<String, double> toJson() => {'lat': lat, 'lon': lon};
  factory Coords.fromJson(Map<String, dynamic> json) {
    return Coords(lat: json['lat'], lon: json['lon']);
  }
}
