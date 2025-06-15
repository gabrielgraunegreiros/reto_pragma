import 'package:reto_pragma/domain/models/breed.dart';
import 'package:reto_pragma/domain/models/breed_detail.dart';

import '../../domain/repositories/breed_repository.dart';
import '../providers/breed_api_provider.dart';

class BreedRepositoryImpl implements BreedRepository {
  final BreedApiProvider apiProvider;

  BreedRepositoryImpl(this.apiProvider);

  @override
  Future<List<Breed>> getBreeds({int limit = 10, int page = 0}) {
    return apiProvider.fetchBreeds(limit: limit, page: page);
  }

  @override
  Future<BreedDetail> getBreedById(String id) {
    return apiProvider.fetchBreedById(id);
  }

  @override
  Future<List<Breed>> searchBreeds(String query) {
    return apiProvider.searchBreeds(query);
  }
}