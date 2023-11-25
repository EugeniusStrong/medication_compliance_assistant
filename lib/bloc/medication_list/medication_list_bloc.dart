import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_compliance_assistant/database_providers/medication_provider.dart';
import 'package:medication_compliance_assistant/models/medication.dart';
import 'package:medication_compliance_assistant/models/patient.dart';

part 'medication_list_event.dart';

part 'medication_list_state.dart';

class MedicationListBloc
    extends Bloc<MedicationListEvent, MedicationListState> {
  final MedicationProvider medicationProvider;
  final Patient input;

  MedicationListBloc(this.medicationProvider, this.input)
      : super(MedicationListInitial()) {
    on<MedicationListPageShown>((event, emit) async {
      final list = await medicationProvider.getByPatientId(input.id);
      emit(MedicationListLoadSuccess(medicationList: list));
    });
    on<MedicationRefresh>((event, emit) async {
      final list = await medicationProvider.getByPatientId(input.id);

      emit(MedicationListLoadSuccess(medicationList: list));
    });
    on<MedicationDeletePressed>((event, emit) async {
      await medicationProvider.delete(event.medicationId);
      final list = await medicationProvider.getByPatientId(input.id);
      emit(MedicationListLoadSuccess(medicationList: list));
    });
  }
}
