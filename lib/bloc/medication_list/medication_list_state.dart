part of 'medication_list_bloc.dart';

abstract class MedicationListState extends Equatable {
  const MedicationListState();
}

class MedicationListInitial extends MedicationListState {
  @override
  List<Object> get props => [];
}

class MedicationListLoadSuccess extends MedicationListState {
  final List<Medication> medicationList;

  const MedicationListLoadSuccess({required this.medicationList});

  @override
  List<Object?> get props => [medicationList];
}
