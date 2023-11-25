import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medication_compliance_assistant/database_providers/drugs_provider.dart';
import 'package:medication_compliance_assistant/database_providers/medical_supplies_provider.dart';
import 'package:medication_compliance_assistant/database_providers/medication_provider.dart';
import 'package:medication_compliance_assistant/database_providers/patient_provider.dart';
import 'package:medication_compliance_assistant/pages/start_page.dart';
import 'package:medication_compliance_assistant/sql_directory/database.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt getIt = GetIt.instance;
  final database = await DBProvider.db.database;
  getIt.registerSingleton<Database>(database, signalsReady: true);
  final drugsProvider = DrugsProvider(database);
  getIt.registerSingleton<DrugsProvider>(drugsProvider, signalsReady: true);
  final patientProvider = PatientProvider(database);
  getIt.registerSingleton<PatientProvider>(patientProvider, signalsReady: true);
  final medicalSuppliesProvider = MedicalSuppliesProvider(database);
  getIt.registerSingleton<MedicalSuppliesProvider>(medicalSuppliesProvider,
      signalsReady: true);
  final medicationProvider = MedicationProvider(
      database, drugsProvider, medicalSuppliesProvider, patientProvider);
  getIt.registerSingleton<MedicationProvider>(medicationProvider,
      signalsReady: true);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MDC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StartPage());
  }
}
