import '_core_/repositories/posts_repository.dart';
import '_core_/services/api_client_service/api_client_service.dart';
import '_core_/services/connectivity_service/connectivity_service.dart';

final apiClient = ApiClientService(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  connectivityService: connectivityService,
);

final postsRepository = PostsRepository(apiClient);
