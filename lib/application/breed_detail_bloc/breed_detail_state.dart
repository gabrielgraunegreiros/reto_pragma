part of 'breed_detail_bloc.dart';

sealed class BreedDetailState extends Equatable {
  const BreedDetailState();
  
  @override
  List<Object> get props => [];
}

final class BreedDetailInitial extends BreedDetailState {}

class BreedDetailLoading extends BreedDetailState {}

class BreedDetailLoaded extends BreedDetailState {
  final BreedDetail breedDetail;
  const BreedDetailLoaded(this.breedDetail);
}

class BreedDetailError extends BreedDetailState {
  final String message;
  const BreedDetailError(this.message);
}
