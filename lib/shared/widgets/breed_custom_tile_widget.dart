import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reto_pragma/domain/models/breed.dart';

class BreedCustomTile extends StatelessWidget {
  const BreedCustomTile({
    super.key,
    required this.breed,
    required this.breedImage,
    required this.onTap,
  });

  final Breed breed;
  final String breedImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(breed.name),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      tileColor: Colors.white,
      leading: LeadingImage(breedImage: breedImage),
      subtitle: TileSubtitle(origin: breed.origin),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
      onTap: onTap
    );
  }
}

class LeadingImage extends StatelessWidget {
  const LeadingImage({
    super.key,
    required this.breedImage,
  });

  final String breedImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(12),
      child: CachedNetworkImage(
        imageUrl: breedImage,
        progressIndicatorBuilder: ( _ , _ , _ ) => Image(image: AssetImage('assets/gifs/oia-uia.gif')),
        errorWidget: ( _ , _ , _ ) => const Image(image: AssetImage('assets/images/peeking_cat.png')),
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TileSubtitle extends StatelessWidget {
  const TileSubtitle({
    super.key,
    required this.origin,
  });

  final String origin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Native country:'),
        const SizedBox(width: 8),
        Expanded(child: Text(origin, softWrap: true, overflow: TextOverflow.ellipsis))
      ],
    );
  }
}