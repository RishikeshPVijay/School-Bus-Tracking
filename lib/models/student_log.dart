class StudentLog {
  final String id; // student id
  final String name;
  final String cls;
  final String admissionNumber;
  final String parent;
  final String busId;
  final String busNo;
  final String status;
  final double lat;
  final double lng;
  final DateTime createdAt;

  StudentLog({
    required this.id,
    required this.busId,
    required this.busNo,
    required this.name,
    required this.cls,
    required this.admissionNumber,
    required this.parent,
    required this.status,
    required this.lat,
    required this.lng,
    required this.createdAt,
  });

  StudentLog.fromFirestore(Map<String, dynamic> json)
      : id = json['id'],
        busId = json['busId'],
        name = json['name'],
        admissionNumber = json['admissionNumber'],
        cls = json['class'],
        parent = json['parent'],
        status = json['status'],
        lat = double.tryParse("${json['lat']}") ?? 0,
        lng = double.tryParse("${json['lng']}") ?? 0,
        createdAt = json['createdAt'].toDate(),
        busNo = json['busNo'];
}
