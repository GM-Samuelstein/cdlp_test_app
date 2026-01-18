import 'package:flutter/material.dart';

import '../../../_core_/models/post_model.dart';
import '../../../_core_/repositories/auth_repository.dart';
import '../../../_core_/repositories/posts_repository.dart';
import '../../../_core_/services/api_client_service/api_result.dart';
import '../../../_core_/services/navigation_service/navigation_service.dart';
import '../../../_core_/services/snackbar_service/snackbar_service.dart';
import '../../../dependencies.dart';

class DashboardViewModel extends ChangeNotifier {
  final PostsRepository _postsRepository;

  DashboardViewModel(this._postsRepository) {
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

  /// ========================================
  /// selected post
  /// ========================================
  PostModel? _selectedPost;
  PostModel? get selectedPost => _selectedPost;

  void setSelectedPost(PostModel? post) {
    _selectedPost = post;
    notifyListeners();
  }

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

              authRepository.logout();

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

    final result = await _postsRepository.fetchPosts();

    if (result is ApiSuccess<List<PostModel>>) {
      _posts
        ..clear()
        ..addAll(result.data.take(24));
    } else if (result is ApiFailure<List<PostModel>>) {
      SnackbarService.showSnackBar(result.message);
    }

    _setLoading(false);
  }

  /// ========================================
  /// goToCreatePost
  /// ========================================
  void goToCreatePost() {
    setSelectedPost(null);
    navigationService.navigateTo(destinationScreen: AppRoutes.postFormScreen);
  }

  /// ========================================
  /// createPost
  /// ========================================
  Future<bool> createPost({required String title, required String body}) async {
    final result = await _postsRepository.createPost(title: title, body: body);

    if (result is ApiSuccess<PostModel>) {
      _posts.insert(0, result.data);
      notifyListeners();
      SnackbarService.showSnackBar("Post created successfully.");
      return true;
    } else if (result is ApiFailure<PostModel>) {
      SnackbarService.showSnackBar(result.message);
      return false;
    }

    return false;
  }

  /// ========================================
  /// goToEditPost
  /// ========================================
  void goToEditPost() {
    navigationService.navigateTo(destinationScreen: AppRoutes.postFormScreen);
  }

  /// ========================================
  ///  updatePost
  /// ========================================
  Future<bool> updatePost({required String title, required String body}) async {
    PostModel post = _selectedPost!.copyWith(title: title, body: body);

    final result = await _postsRepository.updatePost(post);

    if (result is ApiSuccess<PostModel>) {
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = result.data;
        setSelectedPost(result.data);
        notifyListeners();
        SnackbarService.showSnackBar("Post updated successfully.");
        return true;
      }
    } else if (result is ApiFailure<PostModel>) {
      SnackbarService.showSnackBar(result.message);
      return false;
    }

    return false;
  }
}

final dashboardViewModel = DashboardViewModel(postsRepository);
