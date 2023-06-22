class Location {
  final String busId;
  final DateTime createdAt;
  final double lat;
  final double lng;

  Location({
    required this.busId,
    required this.createdAt,
    required this.lat,
    required this.lng,
  });

  Location.fromFirestore(Map<String, dynamic> json)
      : busId = json['busId'],
        createdAt = json['createdAt'].toDate(),
        lat = double.tryParse("${json['lat']}") ?? 0,
        lng = double.tryParse("${json['lng']}") ?? 0;
}
