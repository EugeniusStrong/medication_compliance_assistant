import 'package:medication_compliance_assistant/database_providers/drugs_provider.dart';
import 'package:medication_compliance_assistant/database_providers/medical_supplies_provider.dart';
import 'package:medication_compliance_assistant/database_providers/patient_provider.dart';
import 'package:medication_compliance_assistant/models/drug.dart';
import 'package:medication_compliance_assistant/models/medication.dart';
import 'package:sqflite/sqflite.dart';

class MedicationProvider {
  static const _tableName = 'medication';
  final Database db;
  final DrugsProvider drugsProvider;
  final MedicalSuppliesProvider medicalSuppliesProvider;
  final PatientProvider patientProvider;

  MedicationProvider(
    this.db,
    this.drugsProvider,
    this.medicalSuppliesProvider,
    this.patientProvider,
  );

  Future<List<Medication>> getAll() async {
    final mapList = await db.query(_tableName);
    final List<Medication> list = [];
    for (final item in mapList) {
      list.add(await _fromMap(item));
    }
    return list;
  }

  Future<int> delete(String id) async {
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Medication>> getByPatientId(String id) async {
    final res = await db.query(
      _tableName,
      where: 'patientId = ?',
      whereArgs: [id],
    );
    final List<Medication> list = [];
    for (final item in res) {
      list.add(await _fromMap(item));
    }
    return list;
  }

  Future<void> save(Medication medication) async {
    await patientProvider.save(medication.patient);
    for (final drug in medication.medicalSupplies) {
      await drugsProvider.save(drug);
      final MedicalSupplies medicalSupplies =
          MedicalSupplies(medicationId: medication.id, drugId: drug.id);
      await medicalSuppliesProvider.save(medicalSupplies);
    }
    await db.insert(
      _tableName,
      medication.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Medication> _fromMap(Map<String, dynamic> map) async {
    final id = map['id'] as String;

    final patientId = map['patientId'] as String;
    final patient = await patientProvider.getById(patientId);
    final supplies = await medicalSuppliesProvider.getByMedicationId(id);
    final drugs = <Drug>[];
    for (final item in supplies) {
      final drug = await drugsProvider.getById(item.drugId);
      if (drug != null) {
        drugs.add(drug);
      }
    }
    return Medication(
      id: map['id'] as String,
      diagnosis: map['diagnosis'] as String,
      patient: patient!,
      medicalSupplies: drugs,
      therapy: map['therapy'] as String?,
      recommendations: map['recommendations'] as String?,
    );
  }
}
