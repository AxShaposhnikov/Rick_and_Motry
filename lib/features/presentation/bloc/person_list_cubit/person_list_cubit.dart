import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/features/domain/entities/person_entity.dart';
import 'package:rick_and_morty/features/domain/usecases/get_all_persons.dart';
import 'package:rick_and_morty/features/presentation/bloc/person_list_cubit/person_list_state.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHE_FAILURE_MESSAGE = 'Cache Failure';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(const PersonEmpty());

  int page = 1;

  void loadPerson() async {
    if (state is PersonLoading) return;

    final currentState = state;

    var oldPersons = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPersons = currentState.personList;
    }

    emit(PersonLoading(oldPersons, isFirstFetch: page == 1));

    final failureOrPersons = await getAllPersons(PagePersonParams(page: page));

    failureOrPersons.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonList;
      persons.addAll(character);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unknown error";
    }
  }
}
