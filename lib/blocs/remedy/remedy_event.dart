part of 'remedy_bloc.dart';

@immutable
abstract class RemedyEvent {}

class LoadRemedies extends RemedyEvent {}

class AddRemedy extends RemedyEvent {
  final Remedy remedy;

  AddRemedy(this.remedy);
}

class UpdateRemedy extends RemedyEvent {
  final Remedy remedy;

  UpdateRemedy(this.remedy);
}

class DeleteRemedy extends RemedyEvent {
  final int remedyId;

  DeleteRemedy(this.remedyId);
}
