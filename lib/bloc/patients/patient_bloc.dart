import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_compliance_assistant/database_providers/patient_provider.dart';
import 'package:medication_compliance_assistant/models/patient.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PatientProvider patientProvider;

  PatientBloc({required this.patientProvider}) : super(PatientInitial()) {
    on<PatientShown>((event, emit) async {
      final patients = await patientProvider.getAll();
      emit(PatientLoadSuccess(patients: patients));
    });
    on<PatientAddPressed>((event, emit) {
      final currentState = state as PatientLoadSuccess;
      final patients = currentState.patients;
      patients.add(event.patient);
      emit(PatientLoadSuccess(patients: patients));
    });
    on<PatientDeletePressed>((event, emit) async {
      await patientProvider.delete(event.patient.id);
      final patients = await patientProvider.getAll();
      emit(PatientLoadSuccess(patients: patients));
    });
  }
}
