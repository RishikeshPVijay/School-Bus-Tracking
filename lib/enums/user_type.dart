enum UserType {
  parent,
  admin;

  static UserType getUserTypeFromShortString(String shortString) {
    return UserType.values
        .firstWhere((element) => element.toShortString() == shortString);
  }
}

extension ParseToString on UserType {
  String toShortString() {
    return toString().split('.').last;
  }
}
