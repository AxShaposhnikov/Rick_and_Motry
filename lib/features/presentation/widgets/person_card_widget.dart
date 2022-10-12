import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/common/app_colors.dart';
import 'package:rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty/features/presentation/widgets/person_cached_image_widget.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;
  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            PersonCachedImage(height: 166, width: 166, imageUrl: person.image),
            const SizedBox(
              width: 16,
            ),
            Expanded(child: Column()),
            const SizedBox(width: 12)
          ],
        ));
  }
}
