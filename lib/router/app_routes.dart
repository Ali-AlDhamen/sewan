import 'package:sewan/core/models/route_model.dart';

class AppRoutes {
  static final RouteModel signUp = RouteModel(
    path: "/signup",
    name: "SignUpScreen",
  );
  static final RouteModel login = RouteModel(
    path: "/login",
    name: "loginScreen",
  );

  static final RouteModel home = RouteModel(
    path: "/home",
    name: "HomeScreen",
  );
}

class AppSubRoutes {}
