import 'package:flutter/material.dart';

import '../../../screens/dashboard/view/dashboard_screen.dart';
import '../../../screens/login/view/login_screen.dart';
import '../../../screens/startup/startup.dart';

abstract class AppRoutes {
  static const Widget startup = Startup();
  static const Widget loginScreen = LoginScreen();
  static const Widget dashboardScreen = DashboardScreen();
}
