import '../models/post_model.dart';
import '../services/api_client_service/api_client_service.dart';
import '../services/api_client_service/api_result.dart';

class PostsRepository {
  final ApiClientService _api;

  PostsRepository(this._api);

  // --------------------------------------------------
  // FETCH POSTS (LIST)
  // --------------------------------------------------
  Future<ApiResult<List<PostModel>>> fetchPosts() async {
    final ApiResult<List<dynamic>> result = await _api.get<List<dynamic>>(
      ApiEndpoints.posts,
    );

    if (result is ApiSuccess<List<dynamic>>) {
      final posts = result.data
          .map((post) => PostModel.fromJson(post))
          .toList();

      return ApiSuccess<List<PostModel>>(posts);
    }

    final failure = result as ApiFailure<List<dynamic>>;
    return ApiFailure<List<PostModel>>(
      failure.message,
      statusCode: failure.statusCode,
    );
  }

  // --------------------------------------------------
  // FETCH SINGLE POST
  // --------------------------------------------------
  Future<ApiResult<PostModel>> fetchPost(int id) async {
    final ApiResult<Map<String, dynamic>> result = await _api
        .get<Map<String, dynamic>>('${ApiEndpoints.posts}/$id');

    if (result is ApiSuccess<Map<String, dynamic>>) {
      final post = PostModel.fromJson(result.data);
      return ApiSuccess<PostModel>(post);
    }

    final failure = result as ApiFailure<Map<String, dynamic>>;
    return ApiFailure<PostModel>(
      failure.message,
      statusCode: failure.statusCode,
    );
  }

  // --------------------------------------------------
  // CREATE POST (SIMULATED PERSISTENCE)
  // --------------------------------------------------
  Future<ApiResult<PostModel>> createPost({
    required String title,
    required String body,
  }) async {
    final ApiResult<Map<String, dynamic>> result = await _api
        .post<Map<String, dynamic>>(
          ApiEndpoints.posts,
          data: {'title': title, 'body': body, 'userId': 1},
        );

    if (result is ApiSuccess<Map<String, dynamic>>) {
      final post = PostModel.fromJson(result.data);
      return ApiSuccess<PostModel>(post);
    }

    final failure = result as ApiFailure<Map<String, dynamic>>;
    return ApiFailure<PostModel>(
      failure.message,
      statusCode: failure.statusCode,
    );
  }

  // --------------------------------------------------
  // UPDATE POST (SIMULATED PERSISTENCE)
  // --------------------------------------------------
  Future<ApiResult<PostModel>> updatePost(PostModel post) async {
    final ApiResult<Map<String, dynamic>> result = await _api
        .put<Map<String, dynamic>>(
          '${ApiEndpoints.posts}/${post.id}',
          data: post.toJson(),
        );

    if (result is ApiSuccess<Map<String, dynamic>>) {
      final updatedPost = PostModel.fromJson(result.data);
      return ApiSuccess<PostModel>(updatedPost);
    }

    final failure = result as ApiFailure<Map<String, dynamic>>;
    return ApiFailure<PostModel>(
      failure.message,
      statusCode: failure.statusCode,
    );
  }
}
