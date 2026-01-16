import 'package:flutter/material.dart';

import '../../../_core_/models/post_model.dart';
import '../../../_core_/repositories/posts_repository.dart';
import '../../../_core_/services/navigation_service/navigation_service.dart';
import '../../../dependencies.dart';

class DashboardViewModel extends ChangeNotifier {
  final PostsRepository _repository;

  DashboardViewModel(this._repository) {
    init();
  }

  Future<void> init() async {
    fetchPosts();
  }

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

  /// ========================================
  /// posts
  /// ========================================
  final List<PostModel> _posts = [];
  List<PostModel> get posts => List.unmodifiable(_posts);

  //////////////////////////////////////////////// [Methods]
  /// ========================================
  /// logout
  /// ========================================
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

  /// ========================================
  /// fetchPosts
  /// ========================================
  Future<void> fetchPosts() async {
    _setLoading(true);
    final data = await _repository.fetchPosts();

    _posts
      ..clear()
      ..addAll(data.take(24));
    _setLoading(false);
  }

  /// ========================================
  /// createPost
  /// ========================================
  Future<void> createPost(String title, String body) async {
    final created = await _repository.createPost(title: title, body: body);

    _posts.insert(0, created.copyWith());
    notifyListeners();
  }

  /// ========================================
  ///  updatePost
  /// ========================================
  Future<void> updatePost(PostModel post) async {
    final updated = await _repository.updatePost(post);

    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index] = updated;
      notifyListeners();
    }
  }
}

final dashboardViewModel = DashboardViewModel(postsRepository);
