part of 'breed_search_bloc.dart';

sealed class BreedSearchEvent extends Equatable {
  const BreedSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchBreeds extends BreedSearchEvent {
  final String query;
  const SearchBreeds(this.query);
}

class ClearSearchResults extends BreedSearchEvent {}