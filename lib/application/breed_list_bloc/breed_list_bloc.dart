import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reto_pragma/domain/models/breed.dart';
import 'package:reto_pragma/domain/repositories/breed_repository.dart';

part 'breed_list_bloc_event.dart';
part 'breed_list_bloc_state.dart';

class BreedListBloc extends Bloc<BreedListEvent, BreedListState> {
  final BreedRepository repository;

  BreedListBloc(this.repository) : super(BreedListBlocInitial()) {
    on<FetchBreedList>((event, emit) async {
      if (state is BreedListLoaded) {
        final currentState = state as BreedListLoaded;
        emit(currentState.copyWith(isLoadingMore: true));
        try {
          final moreBreeds = await repository.getBreeds(page: event.page, limit: event.limit);
          emit(BreedListLoaded([...currentState.breeds, ...moreBreeds]));
        } catch (e) {
          emit(BreedListError(e.toString()));
        }
      } else {
        emit(BreedListLoading());
        try {
          final breeds = await repository.getBreeds(page: event.page, limit: event.limit);
          emit(BreedListLoaded(breeds));
        } catch (e) {
          emit(BreedListError(e.toString()));
        }
      }
    });
  }
}
