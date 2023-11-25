import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medication_compliance_assistant/bloc/medication_list/medication_list_bloc.dart';
import 'package:medication_compliance_assistant/models/medication.dart';
import 'package:medication_compliance_assistant/models/patient.dart';
import 'package:medication_compliance_assistant/pages/medication_input_page.dart';

class MedicationListPage extends StatefulWidget {
  final Patient patient;

  const MedicationListPage({super.key, required this.patient});

  @override
  State<MedicationListPage> createState() => _MedicationListPageState();
}

class _MedicationListPageState extends State<MedicationListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicationListBloc(
        GetIt.instance.get(),
        widget.patient,
      )..add(const MedicationListPageShown()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('${widget.patient}'),
              centerTitle: true,
            ),
            body: BlocBuilder<MedicationListBloc, MedicationListState>(
              builder: (context, state) {
                if (state is MedicationListLoadSuccess) {
                  if (state.medicationList.isEmpty) {
                    return const Center(
                      child: Text('Нет планов лечения'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.medicationList.length,
                    itemBuilder: (context, index) {
                      final itemData = state.medicationList[index];
                      return Dismissible(
                        key: Key(itemData.id.toString()),
                        child: GestureDetector(
                          child: Card(
                            child: ListTile(
                              subtitle: Text(itemData.diagnosis),
                              title: Text(
                                  "${itemData.patient.firstName} ${itemData.patient.lastName}"),
                            ),
                          ),
                          onTap: () async {
                            final data = await Navigator.of(context)
                                .push<Medication?>(MaterialPageRoute(
                                    builder: (context) => MedicationInputPage(
                                          patient: itemData.patient,
                                          medication: itemData,
                                        )));
                            if (data != null) {
                              BlocProvider.of<MedicationListBloc>(context)
                                  .add(const MedicationRefresh());
                            }
                          },
                        ),
                        onDismissed: (direction) {
                          BlocProvider.of<MedicationListBloc>(context).add(
                              MedicationDeletePressed(
                                  medicationId: itemData.id));
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final data = await Navigator.of(context).push<Medication?>(
                  MaterialPageRoute(
                    builder: (context) => MedicationInputPage(
                      patient: widget.patient,
                    ),
                  ),
                );
                if (data != null) {
                  BlocProvider.of<MedicationListBloc>(context)
                      .add(const MedicationRefresh());
                }
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
