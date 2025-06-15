part of 'breed_list_bloc.dart';

sealed class BreedListState extends Equatable {
  const BreedListState();
  
  @override
  List<Object?> get props => [];
}

final class BreedListBlocInitial extends BreedListState {}

final class BreedListLoading extends BreedListState {}

class BreedListLoaded extends BreedListState {
  final List<Breed> breeds;
  final bool isLoadingMore;

  const BreedListLoaded(this.breeds, {this.isLoadingMore = false});

  BreedListLoaded copyWith({
    List<Breed>? breeds,
    bool? isLoadingMore,
  }) {
    return BreedListLoaded(
      breeds ?? this.breeds,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [breeds, isLoadingMore];
}

class BreedListError extends BreedListState {
  final String message;

  const BreedListError(this.message);

  @override
  List<Object?> get props => [message];
}