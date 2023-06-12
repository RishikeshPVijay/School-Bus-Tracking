class Bus {
  final String id;
  final String busNo;
  final String route;
  final String driver;

  Bus({
    required this.id,
    required this.driver,
    required this.busNo,
    required this.route,
  });

  Bus.fromFirestore(Map<String, dynamic> json)
      : id = json['id'],
        busNo = json['busNo'],
        route = json['route'],
        driver = json['driver'];
}
