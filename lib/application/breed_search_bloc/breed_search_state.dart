part of 'breed_search_bloc.dart';

sealed class BreedSearchState extends Equatable {
  const BreedSearchState();
  
  @override
  List<Object> get props => [];
}

final class BreedSearchInitial extends BreedSearchState {}

class BreedSearchLoading extends BreedSearchState {}

class BreedSearchLoaded extends BreedSearchState {
  final List<Breed> results;
  const BreedSearchLoaded(this.results);
}

class BreedSearchError extends BreedSearchState {
  final String message;
  const BreedSearchError(this.message);
}
