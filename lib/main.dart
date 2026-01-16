import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'services/navigation_service/navigation_service.dart';

void main() {
  runApp(const CdlTestApp());
}

class CdlTestApp extends StatelessWidget {
  const CdlTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: navigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        home: AppRoutes.loginScreen,
      ),
    );
  }
}
