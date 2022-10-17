import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/common/app_colors.dart';
import 'package:rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty/features/presentation/pages/person_detail_screen.dart';
import 'package:rick_and_morty/features/presentation/widgets/person_cached_image_widget.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;
  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonDetail(person: person))),
      child: Container(
          decoration: BoxDecoration(
            color: AppColors.cellBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              PersonCachedImage(
                  height: 166, width: 166, imageUrl: person.image),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    person.name,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
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
                        child: Text('${person.status} - ${person.species}'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Last known location',
                    style: TextStyle(color: AppColors.greyColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    person.location.name,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text('Origin: ',
                      style: TextStyle(color: AppColors.greyColor)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(person.origin.name,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 1),
                  const SizedBox(height: 12),
                ],
              )),
              const SizedBox(width: 12)
            ],
          )),
    );
  }
}
