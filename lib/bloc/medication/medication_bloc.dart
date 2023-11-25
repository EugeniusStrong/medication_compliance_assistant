import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_compliance_assistant/database_providers/drugs_provider.dart';
import 'package:medication_compliance_assistant/database_providers/medication_provider.dart';
import 'package:medication_compliance_assistant/models/drug.dart';
import 'package:medication_compliance_assistant/models/medication.dart';
import 'package:medication_compliance_assistant/models/patient.dart';
import 'package:uuid/uuid.dart';

part 'medication_event.dart';

part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final DrugsProvider drugsProvider;
  final MedicationProvider medicationProvider;
  final Medication? input;

  MedicationBloc({
    required this.drugsProvider,
    required this.medicationProvider,
    required this.input,
  }) : super(MedicationInitial()) {
    on<DrugPageShown>((event, emit) async {
      final list = await drugsProvider.getAll();
      emit(MedicationDrugLoadSuccess(drugList: list));
    });

    on<DrugChangePressed>((event, emit) async {
      final currentState = state as MedicationDrugLoadSuccess;
      final drugs = List<Drug>.from(currentState.drugList);
      final updatedDrugs = event.drug;
      final index = drugs.indexWhere((el) => el.id == updatedDrugs.id);
      drugs[index] = updatedDrugs;
      emit(MedicationDrugLoadSuccess(drugList: drugs));
    });
    on<DrugAddPressed>((event, emit) async {
      final currentState = state as MedicationDrugLoadSuccess;
      final drugs = List<Drug>.from(currentState.drugList);
      drugs.add(event.drug);
      emit(MedicationDrugLoadSuccess(drugList: drugs));
    });
    on<DrugRefresh>((event, emit) async {
      final list = await drugsProvider.getAll();
      emit(MedicationDrugLoadSuccess(drugList: list));
    });
    on<MedicationSavePressed>((event, emit) async {
      var uuid = const Uuid();
      final medication = Medication(
        id: input?.id ?? uuid.v4(),
        diagnosis: event.diagnosis,
        patient: event.patient,
        medicalSupplies: event.medicalSupplies,
        therapy: event.therapy,
        recommendations: event.recommendations,
      );
      await medicationProvider.save(medication);
      final List<Medication> medicationList = [];
      medicationList.add(medication);
      emit(MedicationSaveSuccess(medication: medication));
    });
  }
}
