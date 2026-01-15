import 'package:flutter/material.dart';

import 'services/navigation_service/navigation_service.dart';

void main() {
  runApp(const CdlTestApp());
}

class CdlTestApp extends StatelessWidget {
  const CdlTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: AppRoutes.loginScreen,
    );
  }
}
