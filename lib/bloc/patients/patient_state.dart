part of 'patient_bloc.dart';

abstract class PatientState extends Equatable {
  const PatientState();
}

class PatientLoadSuccess extends PatientState {
  final List<Patient> patients;

  const PatientLoadSuccess({required this.patients});

  @override
  List<Object> get props => [patients];
}

class PatientInitial extends PatientState {
  @override
  List<Object> get props => [];
}
