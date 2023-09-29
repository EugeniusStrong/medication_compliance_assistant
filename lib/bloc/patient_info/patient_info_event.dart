part of 'patient_info_bloc.dart';

abstract class PatientInfoEvent extends Equatable {
  const PatientInfoEvent();
}

class PatientSavePressed extends PatientInfoEvent {
  final String firstName;
  final String lastName;
  final String? middleName;
  final DateTime birthDate;
  final Gender gender;
  final String? address;

  const PatientSavePressed({
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.birthDate,
    required this.gender,
    this.address,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        middleName,
        birthDate,
        gender,
        address,
      ];
}
