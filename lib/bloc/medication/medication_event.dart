part of 'medication_bloc.dart';

abstract class MedicationEvent extends Equatable {
  const MedicationEvent();
}

class DrugAddPressed extends MedicationEvent {
  final Drug drug;

  const DrugAddPressed({required this.drug});

  @override
  List<Object?> get props => [drug];
}

class DrugPageShown extends MedicationEvent {
  @override
  List<Object?> get props => [];
}

class DrugRefresh extends MedicationEvent {
  @override
  List<Object?> get props => [];
}

class DrugChangePressed extends MedicationEvent {
  final Drug drug;

  const DrugChangePressed(this.drug);

  @override
  List<Object?> get props => [drug];
}

class MedicationSavePressed extends MedicationEvent {
  final String diagnosis;
  final Patient patient;
  final List<Drug> medicalSupplies;
  final String? therapy;
  final String? recommendations;

  const MedicationSavePressed({
    required this.diagnosis,
    required this.patient,
    required this.medicalSupplies,
    this.therapy,
    this.recommendations,
  });

  @override
  List<Object?> get props => [
        diagnosis,
        patient,
        medicalSupplies,
        therapy,
        recommendations,
      ];
}
