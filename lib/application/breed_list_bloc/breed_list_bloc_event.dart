part of 'breed_list_bloc.dart';

sealed class BreedListEvent extends Equatable {
  const BreedListEvent();

  @override
  List<Object?> get props => [];
}

class FetchBreedList extends BreedListEvent {
  final int limit;
  final int page;

  const FetchBreedList({this.limit = 10, this.page = 0});

  @override
  List<Object?> get props => [limit, page];
}
