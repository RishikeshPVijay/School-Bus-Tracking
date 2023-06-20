// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:smart_school_bus/models/bus.dart' as _i14;
import 'package:smart_school_bus/models/student.dart' as _i15;
import 'package:smart_school_bus/views/add_bus_view/add_bus_view.dart' as _i8;
import 'package:smart_school_bus/views/add_student_view/add_student_view.dart'
    as _i10;
import 'package:smart_school_bus/views/bus_detailed_view/bus_detailed_view.dart'
    as _i11;
import 'package:smart_school_bus/views/bus_view/bus_view.dart' as _i7;
import 'package:smart_school_bus/views/home/home_view.dart' as _i4;
import 'package:smart_school_bus/views/initial_route_view/initial_route_view.dart'
    as _i5;
import 'package:smart_school_bus/views/login/login_view.dart' as _i2;
import 'package:smart_school_bus/views/map/map_view.dart' as _i6;
import 'package:smart_school_bus/views/sign_up/sign_up_view.dart' as _i3;
import 'package:smart_school_bus/views/student_detailed_view/student_detailed_view.dart'
    as _i12;
import 'package:smart_school_bus/views/student_view/student_view.dart' as _i9;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i16;

class Routes {
  static const loginView = '/';

  static const signUpView = '/sign-up-view';

  static const homeView = '/home-view';

  static const initialRouteView = '/initial-route-view';

  static const mapView = '/map-view';

  static const busView = '/bus-view';

  static const addBusView = '/add-bus-view';

  static const studentView = '/student-view';

  static const addStudentView = '/add-student-view';

  static const busDetailedView = '/bus-detailed-view';

  static const studentDetailedView = '/student-detailed-view';

  static const all = <String>{
    loginView,
    signUpView,
    homeView,
    initialRouteView,
    mapView,
    busView,
    addBusView,
    studentView,
    addStudentView,
    busDetailedView,
    studentDetailedView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.loginView,
      page: _i2.LoginView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i3.SignUpView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i4.HomeView,
    ),
    _i1.RouteDef(
      Routes.initialRouteView,
      page: _i5.InitialRouteView,
    ),
    _i1.RouteDef(
      Routes.mapView,
      page: _i6.MapView,
    ),
    _i1.RouteDef(
      Routes.busView,
      page: _i7.BusView,
    ),
    _i1.RouteDef(
      Routes.addBusView,
      page: _i8.AddBusView,
    ),
    _i1.RouteDef(
      Routes.studentView,
      page: _i9.StudentView,
    ),
    _i1.RouteDef(
      Routes.addStudentView,
      page: _i10.AddStudentView,
    ),
    _i1.RouteDef(
      Routes.busDetailedView,
      page: _i11.BusDetailedView,
    ),
    _i1.RouteDef(
      Routes.studentDetailedView,
      page: _i12.StudentDetailedView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.LoginView(),
        settings: data,
      );
    },
    _i3.SignUpView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.SignUpView(),
        settings: data,
      );
    },
    _i4.HomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.HomeView(),
        settings: data,
      );
    },
    _i5.InitialRouteView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.InitialRouteView(),
        settings: data,
      );
    },
    _i6.MapView: (data) {
      final args = data.getArgs<MapViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.MapView(key: args.key, bus: args.bus),
        settings: data,
      );
    },
    _i7.BusView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.BusView(),
        settings: data,
      );
    },
    _i8.AddBusView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.AddBusView(),
        settings: data,
      );
    },
    _i9.StudentView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.StudentView(),
        settings: data,
      );
    },
    _i10.AddStudentView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.AddStudentView(),
        settings: data,
      );
    },
    _i11.BusDetailedView: (data) {
      final args = data.getArgs<BusDetailedViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i11.BusDetailedView(key: args.key, bus: args.bus),
        settings: data,
      );
    },
    _i12.StudentDetailedView: (data) {
      final args = data.getArgs<StudentDetailedViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i12.StudentDetailedView(key: args.key, student: args.student),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class MapViewArguments {
  const MapViewArguments({
    this.key,
    required this.bus,
  });

  final _i13.Key? key;

  final _i14.Bus bus;

  @override
  String toString() {
    return '{"key": "$key", "bus": "$bus"}';
  }

  @override
  bool operator ==(covariant MapViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.bus == bus;
  }

  @override
  int get hashCode {
    return key.hashCode ^ bus.hashCode;
  }
}

class BusDetailedViewArguments {
  const BusDetailedViewArguments({
    this.key,
    required this.bus,
  });

  final _i13.Key? key;

  final _i14.Bus bus;

  @override
  String toString() {
    return '{"key": "$key", "bus": "$bus"}';
  }

  @override
  bool operator ==(covariant BusDetailedViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.bus == bus;
  }

  @override
  int get hashCode {
    return key.hashCode ^ bus.hashCode;
  }
}

class StudentDetailedViewArguments {
  const StudentDetailedViewArguments({
    this.key,
    required this.student,
  });

  final _i13.Key? key;

  final _i15.Student student;

  @override
  String toString() {
    return '{"key": "$key", "student": "$student"}';
  }

  @override
  bool operator ==(covariant StudentDetailedViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.student == student;
  }

  @override
  int get hashCode {
    return key.hashCode ^ student.hashCode;
  }
}

extension NavigatorStateExtension on _i16.NavigationService {
  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInitialRouteView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.initialRouteView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMapView({
    _i13.Key? key,
    required _i14.Bus bus,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.mapView,
        arguments: MapViewArguments(key: key, bus: bus),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBusView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.busView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddBusView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addBusView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStudentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.studentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAddStudentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.addStudentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBusDetailedView({
    _i13.Key? key,
    required _i14.Bus bus,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.busDetailedView,
        arguments: BusDetailedViewArguments(key: key, bus: bus),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStudentDetailedView({
    _i13.Key? key,
    required _i15.Student student,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.studentDetailedView,
        arguments: StudentDetailedViewArguments(key: key, student: student),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInitialRouteView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.initialRouteView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMapView({
    _i13.Key? key,
    required _i14.Bus bus,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.mapView,
        arguments: MapViewArguments(key: key, bus: bus),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBusView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.busView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddBusView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addBusView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStudentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.studentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAddStudentView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.addStudentView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBusDetailedView({
    _i13.Key? key,
    required _i14.Bus bus,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.busDetailedView,
        arguments: BusDetailedViewArguments(key: key, bus: bus),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStudentDetailedView({
    _i13.Key? key,
    required _i15.Student student,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.studentDetailedView,
        arguments: StudentDetailedViewArguments(key: key, student: student),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
