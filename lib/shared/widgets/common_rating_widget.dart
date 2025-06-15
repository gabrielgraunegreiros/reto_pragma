import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommonRating extends StatelessWidget {
  const CommonRating({
    super.key,
    required this.rating,
    required this.fullIcon,
    required this.emptyIcon,
    this.itemSize
  });

  final int rating;
  final Widget fullIcon;
  final Widget emptyIcon;
  final double? itemSize;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      allowHalfRating: false,
      ignoreGestures: true,
      initialRating: rating.toDouble(),
      ratingWidget: RatingWidget(
        full: fullIcon,
        half: const SizedBox.shrink(),
        empty: emptyIcon
      ),
      maxRating: 5,
      itemPadding: EdgeInsetsGeometry.only(left: 8),
      itemSize: itemSize ?? 24,
      onRatingUpdate: (value) => {},
    );
  }
}
