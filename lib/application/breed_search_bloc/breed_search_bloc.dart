import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reto_pragma/domain/models/breed.dart';
import 'package:reto_pragma/domain/repositories/breed_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'breed_search_event.dart';
part 'breed_search_state.dart';

class BreedSearchBloc extends Bloc<BreedSearchEvent, BreedSearchState> {
  final BreedRepository repository;

  BreedSearchBloc(this.repository) : super(BreedSearchInitial()) {
    on<SearchBreeds>(
      _onSearchBreeds,
      transformer: debounceRestartable(const Duration(milliseconds: 400))
    );
    on<ClearSearchResults>(_onClearResults);
  }

  Future<void> _onSearchBreeds(SearchBreeds event, Emitter<BreedSearchState> emit) async {
    emit(BreedSearchLoading());

    try {
      final results = await repository.searchBreeds(event.query);
      emit(BreedSearchLoaded(results));
    } catch (e) {
      emit(BreedSearchError('Error searching breeds'));
    }
  }
  
  Future<void> _onClearResults(ClearSearchResults event, Emitter<BreedSearchState> emit) async {
    emit(BreedSearchInitial());
  }

  EventTransformer<T> debounceRestartable<T>(Duration duration) {
    return (events, mapper) => restartable<T>()(events.debounceTime(duration), mapper);
  }
}
