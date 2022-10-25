import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/features/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty/features/presentation/widgets/result_person.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: 'Search for characters...');

  final _suggestions = [
    'Rick',
    'Morty',
    'Summer',
    'Beth',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(context).add(SearchPersons(query));
    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
      builder: (BuildContext context, state) {
        if (state is PersonSearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PersonSearchLoaded) {
          final persons = state.persons;
          if (persons.isEmpty) {
            _showErrorMessage('No Characters with that name found');
          }

          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: persons.isNotEmpty ? persons.length : 0,
              itemBuilder: (context, index) {
                final PersonEntity resultPerson = persons[index];
                return ResultPerson(resultPerson: resultPerson);
              });
        } else if (state is PersonSearchError) {
          return _showErrorMessage(state.message);
        } else {
          return const Center(
            child: Icon(Icons.now_wallpaper),
          );
        }
      },
    );
  }

  Widget _showErrorMessage(String message) {
    return Container(
      color: Colors.black,
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }

    return ListView.separated(
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return Text(
            _suggestions[index],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: _suggestions.length);
  }
}
