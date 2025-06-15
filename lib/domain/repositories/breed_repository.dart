import 'package:reto_pragma/domain/models/breed.dart';
import 'package:reto_pragma/domain/models/breed_detail.dart';

abstract class BreedRepository {
  Future<List<Breed>> getBreeds({int limit = 10, int page = 0});
  Future<BreedDetail> getBreedById(String id);
  Future<List<Breed>> searchBreeds(String query);
}