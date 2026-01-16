import 'package:flutter/material.dart';

import '../navigation_service/navigation_service.dart';

abstract class SnackbarService {
  static BuildContext globalcontext =
      navigationService.navigatorKey.currentContext!;

  static void showSnackBar(String message, {bool autoDismiss = true}) {
    ScaffoldMessenger.of(globalcontext).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: autoDismiss
            ? const Duration(seconds: 4)
            : const Duration(days: 1),
        showCloseIcon: autoDismiss ? false : true,
      ),
    );
  }

  static void dismissAllSnackBars() {
    ScaffoldMessenger.of(globalcontext).clearSnackBars();
  }
}
