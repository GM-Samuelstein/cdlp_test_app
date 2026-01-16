import 'package:flutter/material.dart';

import '../../../_core_/services/navigation_service/navigation_service.dart';

class DashboardViewModel extends ChangeNotifier {
  DashboardViewModel() {
    init();
  }

  // ----------------------------
  // Lifecycle
  // ----------------------------
  Future<void> init() async {}

  // ----------------------------
  // Actions
  // ----------------------------
  void logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              navigationService.navigateToAndRemoveAll(
                destinationScreen: AppRoutes.loginScreen,
                direction: .left,
              );
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}

final dashboardViewModel = DashboardViewModel();
