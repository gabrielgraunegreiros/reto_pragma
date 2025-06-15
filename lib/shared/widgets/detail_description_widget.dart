import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reto_pragma/domain/models/breed_detail.dart';
import 'package:reto_pragma/shared/widgets/common_rating_widget.dart';

class DetailDescriptionWidget extends StatelessWidget {
  const DetailDescriptionWidget({
    super.key,
    required this.breedDetail,
    required this.breedTemperament,
  });

  final BreedDetail breedDetail;
  final List<String> breedTemperament;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(breedDetail.description, textAlign: TextAlign.justify),
        const SizedBox(height: 16),
        CustomDescriptionRow(title: 'Native country', value: breedDetail.origin),
        const SizedBox(height: 16),
        CustomDescriptionRow(
          title: 'Intelligence',
          onlyText: false,
          customWidget: CommonRating(
            rating: breedDetail.intelligence,
            fullIcon: Icon(Icons.lightbulb, color: Colors.yellow),
            emptyIcon: Icon(Icons.lightbulb_outline_rounded),
          )
        ),
        const SizedBox(height: 16),
        CustomDescriptionRow(
          title: 'Adaptability',
          onlyText: false,
          customWidget: CommonRating(
            rating: breedDetail.adaptability,
            fullIcon: Icon(Icons.autorenew, color: Colors.lightGreen),
            emptyIcon: Icon(Icons.lightbulb_outline_rounded),
          )
        ),
        const SizedBox(height: 16),
        CustomDescriptionRow(title: 'Life span', value: '${breedDetail.lifeSpan} years old'),
        const SizedBox(height: 16),
        CustomDescriptionRow(title: 'Health issues', onlyText: false, customWidget: HealthRating(healthRating: breedDetail.healthIssues)),
        const SizedBox(height: 16),
        CustomDescriptionRow(
          title: 'Dog friendly',
          onlyText: false,
          customWidget: CommonRating(
            rating: breedDetail.dogFriendly,
            fullIcon: Image(image: AssetImage('assets/images/dog_face_filled.png')),
            emptyIcon: Image(image: AssetImage('assets/images/dog_face_empty_2.png')),
          )
        ),
        const SizedBox(height: 16),
        CustomDescriptionRow(title: 'Temperament', onlyText: false, customWidget: const SizedBox.shrink()),
        const SizedBox(height: 4),
        TemperamentGrid(breedTemperament: breedTemperament),
      ],
    );
  }
}

class CustomDescriptionRow extends StatelessWidget {
  const CustomDescriptionRow({
    super.key,
    required this.title,
    this.onlyText = true,
    this.value,
    this.customWidget
  });

  final bool onlyText;
  final String title;
  final String? value;
  final Widget? customWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title:', style: TextStyle(fontWeight: FontWeight.bold)),
        onlyText ? Text(value!) : customWidget!
      ],
    );
  }
}

class HealthRating extends StatelessWidget {
  const HealthRating({
    super.key,
    required this.healthRating,
  });

  final int healthRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          allowHalfRating: false,
          ignoreGestures: true,
          initialRating: healthRating.toDouble(),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(Icons.sentiment_very_satisfied_rounded, color: Colors.green,);
              case 1:
                return Icon(Icons.sentiment_satisfied_alt_rounded, color: Colors.lightGreen,);
              case 2:
                return Icon(Icons.sentiment_neutral_rounded, color: Colors.black87,);
              case 3:
                return Icon(Icons.sentiment_dissatisfied_rounded, color: Colors.orangeAccent,);
              case 4:
                return Icon(Icons.sentiment_very_dissatisfied_rounded, color: Colors.redAccent,);
              default:
                return Icon(Icons.sentiment_neutral_rounded, color: Colors.grey);
            }
          },
          maxRating: 5,
          itemPadding: EdgeInsetsGeometry.only(left: 8),
          itemSize: 24,
          onRatingUpdate: (value) => {}
        ),
        const SizedBox(width: 8),
        Text(healthRating.toString())
      ],
    );
  }
}

class TemperamentGrid extends StatelessWidget {
  const TemperamentGrid({
    super.key,
    required this.breedTemperament,
  });

  final List<String> breedTemperament;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, 
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 4
      ),
      itemCount: breedTemperament.length,
      itemBuilder: (context, index) {
        final text = breedTemperament[index];
        final alignmentIndex = index % 3;
        
        TextAlign textAlign;
        Alignment alignment;
        
        switch (alignmentIndex) {
          case 0:
            textAlign = TextAlign.left;
            alignment = Alignment.centerLeft;
            break;
          case 1:
            textAlign = TextAlign.center;
            alignment = Alignment.center;
            break;
          case 2:
          default:
            textAlign = TextAlign.right;
            alignment = Alignment.centerRight;
            break;
        }
        return Align(
          alignment: alignment,
          child: Text(
            text,
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}