class Bus {
  final String id;
  final String busNo;
  final String route;
  final String driver;
  final List<dynamic>? parents; // it's List<String>, but causing error

  Bus({
    required this.id,
    required this.driver,
    required this.busNo,
    required this.route,
    this.parents,
  });

  Bus.fromFirestore(Map<String, dynamic> json)
      : id = json['id'],
        busNo = json['busNo'],
        route = json['route'],
        parents = json['parents'],
        driver = json['driver'];
}
