import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/common/app_colors.dart';
import 'package:rick_and_morty/features/domain/entities/person_entity.dart';

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
          children: [Text(person.name)],
        ),
      ),
    );
  }

  List<Widget> _buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(color: AppColors.greyColor),
      ),
      const SizedBox(height: 4),
      Text(value)
    ];
  }
}
