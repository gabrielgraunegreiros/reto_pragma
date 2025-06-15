import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reto_pragma/domain/models/breed_detail.dart';
import 'package:reto_pragma/domain/repositories/breed_repository.dart';

part 'breed_detail_event.dart';
part 'breed_detail_state.dart';

class BreedDetailBloc extends Bloc<BreedDetailEvent, BreedDetailState> {
  final BreedRepository repository;
  
  BreedDetailBloc(this.repository) : super(BreedDetailInitial()) {
    on<FetchBreedDetail>((event, emit) async {
      emit(BreedDetailLoading());
      try {
        final breed = await repository.getBreedById(event.breedId);
        emit(BreedDetailLoaded(breed));
      } catch (e) {
        emit(BreedDetailError(e.toString()));
      }
    });
  }
}
