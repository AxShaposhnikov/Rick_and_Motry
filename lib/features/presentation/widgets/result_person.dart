import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty/features/presentation/widgets/person_cached_image_widget.dart';

class ResultPerson extends StatelessWidget {
  final PersonEntity resultPerson;
  const ResultPerson({Key? key, required this.resultPerson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: PersonCachedImage(imageUrl: resultPerson.image),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(resultPerson.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  resultPerson.location.name,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
