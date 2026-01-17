import 'dart:convert';

import '../models/user_model.dart';
import '../services/api_client_service/api_result.dart';
import '../services/cache_service/cache_service.dart';

class AuthRepository {
  UserModel? loggedInUser;

  /// --------------------------------
  /// Hardcoded users (mock database)
  /// --------------------------------
  final List<UserModel> _users = const [
    UserModel(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      password: 'password123',
    ),
    UserModel(
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane@example.com',
      password: 'qwerty',
    ),
    UserModel(
      firstName: 'Test',
      lastName: 'User',
      email: 'test@demo.com',
      password: '123456',
    ),
  ];

  // --------------------------------------------------
  // LOG USER IN
  // --------------------------------------------------
  Future<ApiResult<bool>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // 1. Check if user exists
    final user = _users.where((u) => u.email == email).toList();

    if (user.isEmpty) {
      return const ApiFailure<bool>(
        'No account found with this email.',
        statusCode: 404,
      );
    }

    // 2. Check password
    final matchedUser = user.first;
    if (matchedUser.password != password) {
      return const ApiFailure<bool>('Incorrect password.', statusCode: 401);
    }

    // 3. Persist login
    loggedInUser = user.first;

    final userJson = jsonEncode(loggedInUser!.toJson());
    await cacheService.setBool(CacheConstants.isLoggedIn, true);
    await cacheService.setString(CacheConstants.loggedInUser, userJson);

    return const ApiSuccess<bool>(true);
  }

  // --------------------------------------------------
  // LOG USER OUT
  // --------------------------------------------------
  Future<void> logout() async {
    await cacheService.clear();
  }

  // -------------------------------
  // CHECK LOGIN STATUS
  // -------------------------------
  Future<bool> isLoggedIn() async {
    final bool status =
        await cacheService.getBool(CacheConstants.isLoggedIn) ?? false;

    return status;
  }

  // -------------------------------
  // GET LOGGED IN USER
  // -------------------------------
  Future<void> getLoggedInUser() async {
    final String userJson =
        await cacheService.getString(CacheConstants.loggedInUser) ?? "";

    if (userJson.isNotEmpty) {
      loggedInUser = UserModel.fromJson(jsonDecode(userJson));
    }
  }
}

final authRepository = AuthRepository();
