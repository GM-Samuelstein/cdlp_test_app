import '_core_/repositories/posts_repository.dart';
import '_core_/services/api_client_service/api_client_service.dart';

final apiClient = ApiClientService(
  baseUrl: 'https://jsonplaceholder.typicode.com',
);

final postsRepository = PostsRepository(apiClient);
