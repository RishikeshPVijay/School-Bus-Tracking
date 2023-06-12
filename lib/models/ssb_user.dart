import 'package:smart_school_bus/enums/user_type.dart';

class SSBUser {
  final String id;
  final String name;
  final String email;
  final UserType userType;

  SSBUser({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
  });
}
