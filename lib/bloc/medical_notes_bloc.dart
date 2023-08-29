import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_compliance_assistant/bloc/medical_notes_event.dart';
import 'package:medication_compliance_assistant/bloc/medical_notes_state.dart';
import 'package:uuid/uuid.dart';
import '../sql_directory/database.dart';

class MedicalNotesBloc extends Bloc<MedicalNotesEvent, MedicalNotesState> {
  final DBProvider db;

  MedicalNotesBloc(this.db) : super(MedicalNoteInitial()) {
    on<MedicalNotesDeleteRequested>((event, emit) async {
      await _deleteMedicalNote(event.id, emit);
    });
    on<MedicalNotesSaveRequested>((event, emit) async {
      const uuid = Uuid();
      final id = uuid.v4();
      await _saveMedicalNote(
          id,
          event.firstName,
          event.secondName,
          event.diagnosis,
          event.drugName,
          event.drugDose,
          event.drugTime,
          event.isRemind,
          emit);
    });
    on<MedicalNotesAppStarted>((event, emit) async {
      await _loadData(emit);
    });
  }

  Future<void> _deleteMedicalNote(
      String id, Emitter<MedicalNotesState> emit) async {
    await db.deleteNote(id);
    final notesList = await db.getNotes();
    emit(MedicalNotesLoadSuccess(medicalNotesList: notesList));
  }

  Future<void> _saveMedicalNote(
      String? id,
      String? firstName,
      String? secondName,
      String? diagnosis,
      String? drugName,
      String? drugDose,
      DateTime? drugTime,
      bool? isRemind,
      Emitter<MedicalNotesState> emit) async {
    try {
      await db.insertOrUpdate(id, firstName, secondName, diagnosis, drugName,
          drugDose, drugTime, isRemind);

      final notesList = await db.getNotes();

      emit(MedicalNotesLoadSuccess(medicalNotesList: notesList));
    } catch (e) {
      emit(MedicalNoteError(message: ' Failed to save medical note: $e'));
    }
  }

  Future<void> _loadData(Emitter<MedicalNotesState> emit) async {
    final notesList = await db.getNotes();
    emit(MedicalNotesLoadSuccess(medicalNotesList: notesList));
  }
}
