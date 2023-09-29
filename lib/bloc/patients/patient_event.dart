part of 'patient_bloc.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();
}

class PatientShown extends PatientEvent {
  @override
  List<Object?> get props => [];
}

class PatientAddPressed extends PatientEvent {
  final Patient patient;

  const PatientAddPressed({required this.patient});

  @override
  List<Object?> get props => [patient];
}

class PatientDeletePressed extends PatientEvent {
  final Patient patient;

  const PatientDeletePressed({required this.patient});

  @override
  List<Object> get props => [patient];
}
