import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medication_compliance_assistant/bloc/patients/patient_bloc.dart';
import 'package:medication_compliance_assistant/models/patient.dart';
import 'package:medication_compliance_assistant/pages/medication_input_page.dart';
import 'package:medication_compliance_assistant/pages/medication_list_page.dart';
import 'package:medication_compliance_assistant/pages/patient_input_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientBloc(patientProvider: GetIt.instance.get())
        ..add(PatientShown()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'MEDICAL ASSISTANT',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.deepPurple),
            ),
            centerTitle: true,
          ),
          body:
              BlocBuilder<PatientBloc, PatientState>(builder: (context, state) {
            if (state is PatientLoadSuccess) {
              print('State: $state');
              if (state.patients.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.create,
                        size: 100,
                        color: Colors.black54,
                      ),
                      Text(
                        'To add a patient press +',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.patients.length,
                itemBuilder: (context, index) {
                  final itemData = state.patients[index];
                  return Dismissible(
                    key: Key(itemData.id.toString()),
                    child: GestureDetector(
                      child: Card(
                        child: ListTile(
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _navigateToPatient(context, itemData);
                              },
                            ),
                          ),
                          title: const Text('Пациент:'),
                          subtitle: Text(
                            '${itemData.firstName} ${itemData.lastName}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MedicationListPage(
                              patient: itemData,
                            ),
                          ),
                        );
                      },
                    ),
                    onDismissed: (direction) {
                      _onDelete(context, itemData);
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _navigateToPatient(context);
            },
            child: const Icon(
              Icons.add,
              color: Colors.deepPurple,
            ),
          ),
        );
      }),
    );
  }

  void _navigateToPatient(BuildContext context, [Patient? patient]) async {
    final res = await Navigator.push<Patient?>(
      context,
      MaterialPageRoute(
        builder: (context) => PatientInputPage(
          patient: patient,
        ),
      ),
    );

    if (res != null) {
      final bloc = BlocProvider.of<PatientBloc>(context);
      bloc.add(
        patient != null
            ? PatientChangePressed(patient: res)
            : PatientAddPressed(patient: res),
      );
    }
  }

  void _onDelete(BuildContext context, Patient patient) {
    BlocProvider.of<PatientBloc>(context)
        .add(PatientDeletePressed(patient: patient));
  }
}
