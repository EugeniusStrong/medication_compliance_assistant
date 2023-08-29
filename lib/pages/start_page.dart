import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medication_compliance_assistant/bloc/medical_notes_bloc.dart';
import 'package:medication_compliance_assistant/bloc/medical_notes_state.dart';
import 'package:medication_compliance_assistant/pages/user_input_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MEDICAL ASSISTANT',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.deepPurple),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MedicalNotesBloc, MedicalNotesState>(
        builder: (context, state) {
          if (state is MedicalNoteInitial || state is MedicalNoteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MedicalNotesLoadSuccess) {
            if (state.medicalNotesList.isEmpty) {
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
              itemCount: state.medicalNotesList.length,
              itemBuilder: (context, index) {
                final itemData = state.medicalNotesList[index];
                return GestureDetector(
                  child: Card(
                    child: ListTile(
                      title: const Text('Пациент'),
                      subtitle:
                          Text('${itemData.firstName} ${itemData.secondName}'),
                    ),
                  ),
                  onTap: () {},
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserInputPage()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
