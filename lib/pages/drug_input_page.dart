// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medication_compliance_assistant/bloc/patiens/patient_bloc.dart';
// import 'package:medication_compliance_assistant/bloc/patient_event.dart';
// import 'package:medication_compliance_assistant/bloc/patiens/patient_state.dart';
// import 'package:medication_compliance_assistant/models/user_medication_reminder.dart';
//
// class DrugInputPage extends StatefulWidget {
//   final UserMedicationReminder userMedicationReminder;
//
//   const DrugInputPage({Key? key, required this.userMedicationReminder})
//       : super(key: key);
//
//   @override
//   State<DrugInputPage> createState() => _DrugInputPageState();
// }
//
// class _DrugInputPageState extends State<DrugInputPage> {
//   final _drugNameController = TextEditingController();
//   final _drugDoseController = TextEditingController();
//   late UserMedicationReminder _userMedicationReminder;
//
//   @override
//   void initState() {
//     super.initState();
//     _userMedicationReminder = widget.userMedicationReminder;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenBloc = BlocProvider.of<MedicalNotesBloc>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           '${_userMedicationReminder.firstName} ${_userMedicationReminder.secondName}',
//         ),
//       ),
//       body: BlocBuilder<MedicalNotesBloc, MedicalNotesState>(
//         builder: (context, state) {
//           if (state is MedicalNoteInitial || state is MedicalNoteLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is MedicalNotesLoadSuccess) {
//             if (state.medicalNotesList.isEmpty) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.userMedicationReminder.diagnosis.toString(),
//                       style: const TextStyle(fontSize: 30),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           _showInputForm(
//                               context,
//                               () => screenBloc.add(
//                                     MedicalNotesSaveRequested(
//                                       firstName:
//                                           _userMedicationReminder.firstName,
//                                       secondName:
//                                           _userMedicationReminder.secondName,
//                                       diagnosis:
//                                           _userMedicationReminder.diagnosis,
//                                       drugName: _drugNameController.text,
//                                       drugDose: _drugDoseController.text,
//                                       drugTime: DateTime.now(),
//                                     ),
//                                   ),
//                               titleInput: 'ADD NOTE',
//                               buttonText: 'ADD');
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.black12,
//                               borderRadius: BorderRadius.circular(30)),
//                           child: const ListTile(
//                             title: Text(
//                               '+ Добавьте препарат',
//                               style: TextStyle(
//                                   fontStyle: FontStyle.italic, fontSize: 20),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.userMedicationReminder.diagnosis.toString(),
//                       style: const TextStyle(fontSize: 30),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: state.medicalNotesList.length,
//                         itemBuilder: (context, index) {
//                           final medicalNote = state.medicalNotesList[index];
//                           return ListTile(
//                             leading: Text(
//                               medicalNote.drugTime.toString(),
//                             ),
//                             title: Text(
//                               medicalNote.drugName.toString(),
//                             ),
//                             subtitle: Text(
//                               medicalNote.drugDose.toString(),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           _showInputForm(
//                               context,
//                               () => screenBloc.add(
//                                     MedicalNotesSaveRequested(
//                                       firstName:
//                                           _userMedicationReminder.firstName,
//                                       secondName:
//                                           _userMedicationReminder.secondName,
//                                       diagnosis:
//                                           _userMedicationReminder.diagnosis,
//                                       drugName: _drugNameController.text,
//                                       drugDose: _drugDoseController.text,
//                                       drugTime: DateTime.now(),
//                                     ),
//                                   ),
//                               titleInput: 'ADD NOTE',
//                               buttonText: 'ADD');
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.black12,
//                               borderRadius: BorderRadius.circular(30)),
//                           child: const ListTile(
//                             title: Text(
//                               '+ Добавьте препарат',
//                               style: TextStyle(
//                                   fontStyle: FontStyle.italic, fontSize: 20),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
//
//   void _showInputForm(BuildContext context, VoidCallback onButtonPressed,
//       {String? firstName,
//       String? secondName,
//       String? diagnosis,
//       String? drugName,
//       String? drugDose,
//       DateTime? drugTime,
//       required String titleInput,
//       required String buttonText}) {
//     _drugNameController.text = drugName ?? '';
//     _drugDoseController.text = drugDose ?? '';
//
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return Dialog(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     titleInput,
//                     style: const TextStyle(
//                         color: Colors.purple,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 25),
//                   TextField(
//                     controller: _drugNameController,
//                     cursorColor: Colors.white,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: const InputDecoration(
//                       hintText: 'Enter TITLE',
//                       hintStyle: TextStyle(
//                           color: Colors.white38, fontStyle: FontStyle.italic),
//                       filled: true,
//                       fillColor: Colors.black54,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(30.0),
//                           ),
//                           borderSide: BorderSide.none),
//                       icon: Icon(
//                         Icons.create,
//                         color: Colors.black87,
//                         size: 50.0,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   TextField(
//                     cursorColor: Colors.black54,
//                     style: const TextStyle(color: Colors.white),
//                     decoration: const InputDecoration(
//                       hintText: 'Enter NOTE',
//                       hintStyle: TextStyle(
//                           color: Colors.white38, fontStyle: FontStyle.italic),
//                       filled: true,
//                       fillColor: Colors.black54,
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(30.0),
//                           ),
//                           borderSide: BorderSide.none),
//                       icon: Icon(
//                         Icons.edit_note_outlined,
//                         color: Colors.black87,
//                         size: 50.0,
//                       ),
//                     ),
//                     controller: _drugDoseController,
//                   ),
//                   const SizedBox(height: 30),
//                   const SizedBox(height: 50),
//                   TextButton(
//                     onPressed: () {
//                       onButtonPressed();
//                       Navigator.pop(context);
//                     },
//                     style: ButtonStyle(
//                       foregroundColor: MaterialStateProperty.all(Colors.purple),
//                       backgroundColor: MaterialStateProperty.all(Colors.white),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             side: const BorderSide(color: Colors.purple)),
//                       ),
//                     ),
//                     child: Text(
//                       buttonText,
//                       style: const TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
