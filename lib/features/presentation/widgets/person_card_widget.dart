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
            Expanded(
                child: Column(
              children: [
                Text(person.name),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: (person.status == 'Alive')
                              ? Colors.green
                              : (person.status == 'Dead')
                                  ? Colors.red
                                  : Colors.grey,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text('${person.status} - ${person.type}'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Last known location'),
                const SizedBox(
                  height: 16,
                ),
                Text(person.location.name),
                const SizedBox(
                  height: 16,
                ),
                const Text('Origin: '),
                const SizedBox(
                  height: 16,
                ),
                Text(person.origin.name),
              ],
            )),
            const SizedBox(width: 12)
          ],
        ));
  }
}
