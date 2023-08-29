import 'package:equatable/equatable.dart';
import 'package:medication_compliance_assistant/models/user_medication_reminder.dart';

abstract class MedicalNotesState extends Equatable {
  const MedicalNotesState();
}

class MedicalNoteInitial extends MedicalNotesState {
  @override
  List<Object?> get props => [];
}

class MedicalNoteLoading extends MedicalNotesState {
  @override
  List<Object?> get props => [];
}

class MedicalNotesLoadSuccess extends MedicalNotesState {
  final List<UserMedicationReminder> medicalNotesList;

  const MedicalNotesLoadSuccess({required this.medicalNotesList});

  @override
  List<Object?> get props => [medicalNotesList];
}

class MedicalNoteError extends MedicalNotesState {
  final String message;

  const MedicalNoteError({required this.message});

  @override
  List<Object?> get props => [message];
}
