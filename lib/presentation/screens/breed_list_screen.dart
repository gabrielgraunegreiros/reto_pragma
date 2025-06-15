import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reto_pragma/application/breed_list_bloc/breed_list_bloc.dart';
import 'package:reto_pragma/data/providers/breed_api_provider.dart';
import 'package:reto_pragma/data/repositories/breed_repository_impl.dart';

import '../../shared/widgets/widgets.dart';

class BreedListScreen extends StatelessWidget {
  const BreedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = BreedRepositoryImpl(BreedApiProvider());
    return BlocProvider(
      create: (_) => BreedListBloc(repository)..add(const FetchBreedList()),
      child: const ListWidget(),
    );
  }
}

class ListWidget extends StatefulWidget {
  const ListWidget({
    super.key,
  });

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final ScrollController _scrollController = ScrollController();
  int _page = 0;
  final int _limit = 10;


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      final breedListBloc = context.read<BreedListBloc>();
      if (breedListBloc.state is BreedListLoaded) {
        breedListBloc.add(FetchBreedList(page: ++_page, limit: _limit));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedListBloc, BreedListState>(
      builder: (context, state) {
        if (state is BreedListLoading && _page == 0) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BreedListLoaded) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: state.breeds.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.breeds.length) {
                return const Center(child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                ));
              }
              final breed = state.breeds[index];
              final breedImage = 'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg';
              return BreedCustomCard(
                breed: breed,
                breedImage: breedImage,
                redirectTo: () => context.push('/breed_detail', extra: breed.id),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
          );
        } else if (state is BreedListError && _page == 0) {
          return ErrorStateWidget(message: state.message);
        }
        return SizedBox();
      }
    );
  }
}