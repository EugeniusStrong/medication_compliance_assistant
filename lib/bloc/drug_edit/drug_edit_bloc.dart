import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_compliance_assistant/database_providers/drugs_provider.dart';
import 'package:medication_compliance_assistant/models/drug.dart';
import 'package:uuid/uuid.dart';

part 'drug_edit_event.dart';

part 'drug_edit_state.dart';

class DrugEditBloc extends Bloc<DrugEditEvent, DrugEditState> {
  final DrugsProvider drugProvider;
  final Drug? input;

  DrugEditBloc(this.drugProvider, this.input) : super(DrugEditInitial()) {
    on<DrugSavePressed>((event, emit) async {
      var uuid = const Uuid();

      final newDrug = Drug(
        id: input?.id ?? uuid.v4(),
        name: event.name,
        description: event.description,
        dose: event.dose,
        cost: event.cost,
      );
      await drugProvider.save(newDrug);
      print(newDrug);

      emit(DrugSaveSuccess(drug: newDrug));
    });
    on<DrugDeleteRequested>((event, emit) async {
      await drugProvider.delete((event.id));
      emit(DrugDeleteSuccess(drugId: event.id));
    });
  }
}
