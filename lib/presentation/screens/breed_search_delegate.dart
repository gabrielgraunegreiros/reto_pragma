import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reto_pragma/application/breed_search_bloc/breed_search_bloc.dart';
import 'package:reto_pragma/config/theme/app_theme.dart';
import 'package:reto_pragma/shared/utils/search_storage.dart';
import 'package:reto_pragma/shared/widgets/widgets.dart';

class BreedSearchDelegate extends SearchDelegate<String> {
  final BreedSearchBloc breedSearchBloc;
  BreedSearchDelegate(this.breedSearchBloc);

  String? _lastQuery;
  final ValueNotifier<List<String>> _recentQueries = ValueNotifier([]);

  @override
  String? get searchFieldLabel => 'Search breeds';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return AppTheme().getTheme().copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: false,
        contentPadding: EdgeInsets.all(0),
        isDense: false
      )
    );
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear, color: onSurfaceColor),
          onPressed: () {
            query = '';
            breedSearchBloc.add(ClearSearchResults());
          },
        ),
    ];
  }
  
  @override
  Widget? buildLeading(BuildContext context) {
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;
    return BackButton(onPressed: () => close(context, ''), color: onSurfaceColor);
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      SearchStorage.getRecentQueries().then((list) {
        _recentQueries.value = list;
      });
    }
    if (_lastQuery != query.trim()) {
      _lastQuery = query.trim();
      breedSearchBloc.add(SearchBreeds(_lastQuery!));
    }
    
    return BlocBuilder<BreedSearchBloc, BreedSearchState>(
      bloc: breedSearchBloc,
      builder: (context, state) {
        if (state is BreedSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BreedSearchLoaded) {
          if (query.isEmpty) {
            return ValueListenableBuilder<List<String>>(
              valueListenable: _recentQueries,
              builder: (context, recentList, _) {
                if (recentList.isEmpty) {
                  return const Center(child: Text('No recent searches'));
                }
                return ListView.separated(
                  itemCount: recentList.length,
                  itemBuilder: (context, index) {
                    final recent = recentList[index];
                    return ListTile(
                      leading: const Icon(Icons.history),
                      contentPadding: EdgeInsets.only(left: 16, right: 8),
                      title: Text(recent),
                      onTap: () {
                        query = recent;
                        showResults(context);
                      },
                      trailing: IconButton(
                        iconSize: 18,
                        icon: const Icon(Icons.close),
                        onPressed: () async {
                          final updated = List<String>.from(_recentQueries.value)..removeAt(index);
                          _recentQueries.value = updated;
                          await SearchStorage.saveRecentQueries(updated);
                        },
                      ),
                    );
                  },
                  separatorBuilder: ( _ , _ ) => const Divider(),
                );
              },
            );
          }

          return ListView.separated(
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              final breed = state.results[index];
              final breedImage = 'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg';
              return BreedCustomTile(
                breed: breed,
                breedImage: breedImage,
                onTap: () {
                  final currentContext = context;
                  if (!_recentQueries.value.contains(query)) {
                    final updated = [query, ..._recentQueries.value];
                    _recentQueries.value = updated;
                    SearchStorage.saveRecentQueries(updated);
                  }
                  currentContext.push('/breed_detail', extra: breed.id);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        } else if (state is BreedSearchError) {
          return ErrorStateWidget(message: state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}