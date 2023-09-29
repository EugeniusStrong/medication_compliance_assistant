part of 'patient_info_bloc.dart';

abstract class PatientInfoState extends Equatable {
  const PatientInfoState();
}

class PatientInfoInitial extends PatientInfoState {
  @override
  List<Object> get props => [];
}

class PatientSaveSuccess extends PatientInfoState {
  final Patient patient;

  const PatientSaveSuccess({required this.patient});
  @override
  List<Object?> get props => [patient];
}
