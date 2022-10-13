import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SearchPersons extends PersonSearchEvent {
  String queryPerson;

  SearchPersons(this.queryPerson);
}
