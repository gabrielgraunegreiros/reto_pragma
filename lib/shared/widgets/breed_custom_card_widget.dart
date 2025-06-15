import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reto_pragma/domain/models/breed.dart';

class BreedCustomCard extends StatelessWidget {
  const BreedCustomCard({
    super.key,
    required this.breed,
    required this.breedImage,
    this.redirectTo,
  });

  final Breed breed;
  final String breedImage;
  final Function()? redirectTo;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 16),
        child: Column(
          children: [
            CardTitle(name: breed.name, redirectTo: redirectTo),
            CardImage(breedImage: breedImage),
            const SizedBox(height: 16),
            CardDescription(origin: breed.origin, temperament: breed.temperament)                
          ],
        ),
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  const CardTitle({
    super.key,
    required this.name,
    required this.redirectTo,
  });

  final String name;
  final Function()? redirectTo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        TextButton(onPressed: redirectTo, child: const Text('More...'))
      ],
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.breedImage,
  });

  final String breedImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(4),
      child: CachedNetworkImage(
        imageUrl: breedImage,
        progressIndicatorBuilder: ( _ , _ , _ ) => Image(image: AssetImage('assets/gifs/oia-uia.gif')),
        errorWidget: ( _ , _ , _ ) => const Image(image: AssetImage('assets/images/peeking_cat.png')),
        width: double.maxFinite,
        height: 188,
        fit: BoxFit.cover,
      ),
    );
  }
}

class CardDescription extends StatelessWidget {
  const CardDescription({
    super.key,
    required this.origin,
    required this.temperament
  });

  final String origin;
  final String temperament;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(origin),
        Text(temperament.split(',').first.trim()),
      ],
    );
  }
}