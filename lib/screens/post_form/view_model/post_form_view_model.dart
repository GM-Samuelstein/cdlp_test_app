import 'package:cdlp_test_app/_core_/services/navigation_service/navigation_service.dart';
import 'package:flutter/material.dart';

import '../../dashboard/view_model/dashboard_view_model.dart';

class PostFormViewModel extends ChangeNotifier {
  ////////////////////////////////////////////////
  /// State
  ////////////////////////////////////////////////
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ////////////////////////////////////////////////
  /// Create post
  ////////////////////////////////////////////////
  Future<void> createPost({required String title, required String body}) async {
    _setLoading(true);

    final result = await dashboardViewModel.createPost(
      title: title,
      body: body,
    );

    _setLoading(false);

    if (result) {
      navigationService.goBack();
    }
  }

  ////////////////////////////////////////////////
  /// Update post
  ////////////////////////////////////////////////
  Future<void> updatePost({required String title, required String body}) async {
    _setLoading(true);

    final result = await dashboardViewModel.updatePost(
      title: title,
      body: body,
    );

    _setLoading(false);

    if (result) {
      navigationService.goBack();
    }
  }
}

final postFormViewModel = PostFormViewModel();
