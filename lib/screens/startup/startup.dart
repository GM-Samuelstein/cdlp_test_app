import 'package:flutter/material.dart';

import '../../_core_/repositories/auth_repository.dart';
import '../../_core_/services/navigation_service/navigation_service.dart';

class Startup extends StatefulWidget {
  const Startup({super.key});

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFFF5F7FA));
  }

  void _redirect() async {
    final status = await authRepository.isLoggedIn();

    if (status) {
      await authRepository.getLoggedInUser();
      navigationService.navigateToAndRemoveAll(
        destinationScreen: AppRoutes.dashboardScreen,
      );
    } else {
      navigationService.navigateToAndRemoveAll(
        destinationScreen: AppRoutes.loginScreen,
      );
    }
  }
}
