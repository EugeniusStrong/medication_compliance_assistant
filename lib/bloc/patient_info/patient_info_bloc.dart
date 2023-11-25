import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_compliance_assistant/database_providers/patient_provider.dart';
import 'package:medication_compliance_assistant/models/patient.dart';
import 'package:uuid/uuid.dart';

part 'patient_info_event.dart';

part 'patient_info_state.dart';

class PatientInfoBloc extends Bloc<PatientInfoEvent, PatientInfoState> {
  final PatientProvider patientProvider;
  final Patient? input;

  PatientInfoBloc(this.patientProvider, this.input)
      : super(PatientInfoInitial()) {
    on<PatientSavePressed>(
      (event, emit) async {
        var uuid = const Uuid();

        final newPatient = Patient(
            id: input?.id ?? uuid.v4(),
            firstName: event.firstName,
            lastName: event.lastName,
            middleName: event.middleName,
            address: event.address,
            birthDate: event.birthDate,
            gender: event.gender);
        await patientProvider.save(newPatient);
        emit(
          PatientSaveSuccess(patient: newPatient),
        );
      },
    );
  }
}
