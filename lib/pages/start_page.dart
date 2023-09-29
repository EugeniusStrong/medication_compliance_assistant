import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medication_compliance_assistant/bloc/patients/patient_bloc.dart';
import 'package:medication_compliance_assistant/models/patient.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientBloc(patientProvider: GetIt.instance.get())
        ..add(PatientShown()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'MEDICAL ASSISTANT',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.deepPurple),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<PatientBloc, PatientState>(
          builder: (context, state) {
            if (state is PatientInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PatientLoadSuccess) {
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
                        'To add a note press +',
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
                          title: const Text('Пациент'),
                          subtitle: Text(
                              '${itemData.firstName} ${itemData.lastName}'),
                        ),
                      ),
                      onTap: () {},
                    ),
                    onDismissed: (direction) {
                      _onDelete(context, itemData);
                    },
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }

  void _onDelete(BuildContext context, Patient patient) {
    BlocProvider.of<PatientBloc>(context)
        .add(PatientDeletePressed(patient: patient));
  }
}
