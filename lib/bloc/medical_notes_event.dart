import 'package:equatable/equatable.dart';

abstract class MedicalNotesEvent extends Equatable {
  @override
  bool? get stringify => true;
}

class MedicalNotesAppStarted extends MedicalNotesEvent {
  @override
  List<Object?> get props => const [];
}

class MedicalNotesSaveRequested extends MedicalNotesEvent {
  final String? id;
  final String? firstName;
  final String? secondName;
  final String? diagnosis;
  final String? drugName;
  final String? drugDose;
  final DateTime? drugTime;
  final bool? isRemind;

  MedicalNotesSaveRequested({
    this.id,
    this.firstName,
    this.secondName,
    this.diagnosis,
    this.drugName,
    this.drugDose,
    this.drugTime,
    this.isRemind,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        secondName,
        diagnosis,
        drugName,
        drugDose,
        drugTime,
        isRemind
      ];
}

class MedicalNotesDeleteRequested extends MedicalNotesEvent {
  final String id;

  MedicalNotesDeleteRequested(this.id);

  @override
  List<Object?> get props => [id];
}
