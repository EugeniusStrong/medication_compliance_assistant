import 'package:medication_compliance_assistant/models/patient.dart';
import 'package:sqflite/sqflite.dart';

class PatientProvider {
  static const _tableName = 'patients';

  final Database db;

  PatientProvider(this.db);

  Future<List<Patient>> getAll() async {
    final mapList = await db.query(_tableName);
    final List<Patient> list = [];
    for (final item in mapList) {
      list.add(Patient.fromMap(item));
    }
    return list;
  }

  Future<Patient?> getById(String id) async {
    final list = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return list.isNotEmpty ? Patient.fromMap(list.first) : null;
  }

  Future<int> delete(String id) async {
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> save(Patient patient) async {
    await db.insert(
      _tableName,
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
