part of 'medication_bloc.dart';

abstract class MedicationState extends Equatable {
  const MedicationState();
}

class MedicationInitial extends MedicationState {
  @override
  List<Object> get props => [];
}

class MedicationDrugLoadSuccess extends MedicationState {
  final List<Drug> drugList;

  const MedicationDrugLoadSuccess({required this.drugList});

  @override
  List<Object?> get props => [drugList];
}

class MedicationSaveSuccess extends MedicationState {
  final Medication medication;

  const MedicationSaveSuccess({required this.medication});

  @override
  List<Object?> get props => [medication];
}
