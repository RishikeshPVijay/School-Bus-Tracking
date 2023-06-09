enum UserType { parent, driver, admin }

extension ParseToString on UserType {
  String toShortString() {
    return toString().split('.').last;
  }
}
