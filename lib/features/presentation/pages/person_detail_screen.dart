import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/common/app_colors.dart';
import 'package:rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty/features/presentation/widgets/person_cached_image_widget.dart';

class PersonDetail extends StatelessWidget {
  final PersonEntity person;

  const PersonDetail({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charachter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                person.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: PersonCachedImage(
                  imageUrl: person.image, width: 280, height: 280),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Text('${person.status} - ${person.species}'),
              ],
            ),
            ..._buildText('Gender:', person.gender),
            ..._buildText(
                'Number of episodes:', person.episode.length.toString()),
            ..._buildText('Species:', person.species),
            ..._buildText('Last known location', person.location.name),
            ..._buildText('Origin', person.origin.name),
            ..._buildText('Was created:', person.created.toIso8601String())
          ],
        ),
      ),
    );
  }

  List<Widget> _buildText(String text, String value) {
    return [
      const SizedBox(
        height: 16,
      ),
      Text(
        text,
        style: const TextStyle(color: AppColors.greyColor),
      ),
      const SizedBox(height: 4),
      Text(value)
    ];
  }
}
