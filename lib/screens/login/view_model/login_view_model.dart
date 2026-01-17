import 'package:flutter/material.dart';

import '../../../_core_/repositories/auth_repository.dart';
import '../../../_core_/services/api_client_service/api_result.dart';
import '../../../_core_/services/navigation_service/navigation_service.dart';
import '../../../_core_/services/snackbar_service/snackbar_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository);

  //////////////////////////////////////////////// [Fields]
  /// ========================================
  /// isLoading
  /// ========================================
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //////////////////////////////////////////////// [Methods]
  /// ========================================
  /// login
  /// ========================================
  Future<void> login({required String email, required String password}) async {
    _setLoading(true);

    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    _setLoading(false);

    if (result is ApiSuccess<bool>) {
      navigationService.navigateToAndRemoveAll(
        destinationScreen: AppRoutes.dashboardScreen,
      );
    } else if (result is ApiFailure<bool>) {
      SnackbarService.showSnackBar(result.message);
    }
  }
}

final loginViewModel = LoginViewModel(authRepository);
