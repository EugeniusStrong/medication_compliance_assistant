part of 'medication_list_bloc.dart';

abstract class MedicationListEvent extends Equatable {
  const MedicationListEvent();
}

class MedicationListPageShown extends MedicationListEvent {
  const MedicationListPageShown();

  @override
  List<Object?> get props => [];
}

class MedicationRefresh extends MedicationListEvent {
  const MedicationRefresh();

  @override
  List<Object?> get props => [];
}

class MedicationDeletePressed extends MedicationListEvent {
  final String medicationId;

  const MedicationDeletePressed({required this.medicationId});
  @override
  List<Object?> get props => [medicationId];
}
