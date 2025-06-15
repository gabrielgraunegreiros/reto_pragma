import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_pragma/application/breed_search_bloc/breed_search_bloc.dart';
import 'package:reto_pragma/data/providers/breed_api_provider.dart';
import 'package:reto_pragma/data/repositories/breed_repository_impl.dart';
import 'package:reto_pragma/presentation/screens/breed_list_screen.dart';
import 'package:reto_pragma/presentation/screens/breed_search_delegate.dart';

class HomeScreen extends StatelessWidget  {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BreedListScreen(),
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  

  const _CustomAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60);

  @override
  Widget build(BuildContext context) {
    final repository = BreedRepositoryImpl(BreedApiProvider());
    return BlocProvider(
      create: ( _ ) => BreedSearchBloc(repository),
      child: AppBarWidget(preferredSize: preferredSize)
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final Size preferredSize;
  
  const AppBarWidget({super.key, required this.preferredSize});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text('CatBreeds'),
          const SizedBox(height: 10),
          TextField(
            readOnly: true,
            onTap: () {
              showSearch(context: context, delegate: BreedSearchDelegate(context.read<BreedSearchBloc>()));
            },
            decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: Icon(Icons.search_rounded),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              isDense: true
            ),
          )
        ],
      ),
      toolbarHeight: preferredSize.height,
      centerTitle: true,
    );
  }
}