import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_pragma/application/breed_detail_bloc/breed_detail_bloc.dart';
import 'package:reto_pragma/data/providers/breed_api_provider.dart';
import 'package:reto_pragma/data/repositories/breed_repository_impl.dart';
import 'package:reto_pragma/shared/widgets/widgets.dart';

class BreedDetailScreen extends StatelessWidget {
  final String breedId;
  const BreedDetailScreen({super.key, required this.breedId});

  @override
  Widget build(BuildContext context) {
    final repository = BreedRepositoryImpl(BreedApiProvider());
    return BlocProvider(
      create: (_) => BreedDetailBloc(repository)..add(FetchBreedDetail(breedId)),
      child: DetailWidget()
    );
  }
}

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedDetailBloc, BreedDetailState>(
      builder: (context, state) {
        if (state is BreedDetailLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('Detalle de raza'), centerTitle: true),
            body: const Center(child: CircularProgressIndicator())
          );
        } else if (state is BreedDetailLoaded) {
          final size = MediaQuery.sizeOf(context);
          final breedDetail = state.breedDetail;
          final breedImage = 'https://cdn2.thecatapi.com/images/${breedDetail.referenceImageId}.jpg';
          final breedTemperament = breedDetail.temperament.contains(',')
            ? breedDetail.temperament.split(',').map((e) => e.trim()).toList()
            : [breedDetail.temperament.trim()];
          return Scaffold(
            appBar: AppBar(
              title: Text(state.breedDetail.name),
              centerTitle: true,
            ),
            body: Column(
              children: [
                FadeInImage(
                  placeholder: AssetImage('assets/gifs/oia-uia.gif'),
                  image: NetworkImage(breedImage),
                  imageErrorBuilder: ( _ , _ , _ ) => Image(image: AssetImage('assets/images/peeking_cat.png')),
                  height: size.height * 0.5,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: DetailDescriptionWidget(breedDetail: breedDetail, breedTemperament: breedTemperament),
                  ),
                )
              ],
            )
          );
        } else if (state is BreedDetailError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Breed Detail'), centerTitle: true),
            body: ErrorStateWidget(message: state.message)
          );
        }
        return SizedBox();
      },
    );
  }
}