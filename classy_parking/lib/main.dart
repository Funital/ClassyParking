import 'package:classy_parking/app/classyparking_app.dart';
import 'package:flutter/material.dart';

import 'core/router/route_path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final initialRoute = RoutePath.splash;
  // final initialRoute = RoutePath.myPage;

  runApp(ClassyparkingApp(initialRoute: initialRoute));
}
