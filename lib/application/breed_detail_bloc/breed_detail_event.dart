part of 'breed_detail_bloc.dart';

sealed class BreedDetailEvent extends Equatable {
  const BreedDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchBreedDetail extends BreedDetailEvent {
  final String breedId;
  const FetchBreedDetail(this.breedId);
}
