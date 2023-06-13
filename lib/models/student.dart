class Student {
  final String id;
  final String busId;
  final String name;
  final String cls;
  final String admissionNumber;
  final String address;
  final String? rfid;

  Student({
    required this.id,
    required this.name,
    required this.busId,
    required this.cls,
    required this.admissionNumber,
    required this.address,
    this.rfid,
  });

  Student.fromFirestore(Map<String, dynamic> json)
      : id = json['id'],
        busId = json['busId'],
        name = json['name'],
        admissionNumber = json['admissionNumber'],
        address = json['address'],
        cls = json['class'],
        rfid = json['rfid'];
}
