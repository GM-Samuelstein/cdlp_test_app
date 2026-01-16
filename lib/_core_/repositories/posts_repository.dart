import '../models/post_model.dart';
import '../services/api_client_service/api_client_service.dart';

class PostsRepository {
  final ApiClientService _api;

  PostsRepository(this._api);

  Future<List<PostModel>> fetchPosts() async {
    final response = await _api.get(ApiEndpoints.posts);

    final List data = response.data;
    return data.map((post) => PostModel.fromJson(post)).toList();
  }

  Future<PostModel> fetchPost(int id) async {
    final response = await _api.get('${ApiEndpoints.posts}/$id');
    return PostModel.fromJson(response.data);
  }

  Future<PostModel> createPost({
    required String title,
    required String body,
  }) async {
    final response = await _api.post(
      ApiEndpoints.posts,
      data: {'title': title, 'body': body, 'userId': 1},
    );

    return PostModel.fromJson(response.data);
  }

  Future<PostModel> updatePost(PostModel post) async {
    final response = await _api.put(
      '${ApiEndpoints.posts}/${post.id}',
      data: post.toJson(),
    );

    return PostModel.fromJson(response.data);
  }
}
