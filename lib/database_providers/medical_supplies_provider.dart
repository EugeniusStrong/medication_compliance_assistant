import 'package:sqflite/sqflite.dart';

class MedicalSuppliesProvider {
  static const _tableName = 'medicalSupplies';
  final Database db;

  MedicalSuppliesProvider(this.db);

  Future<List<MedicalSupplies>> getAll() async {
    final mapList = await db.query(_tableName);
    final List<MedicalSupplies> list = [];
    for (final item in mapList) {
      list.add(MedicalSupplies.fromMap(item));
    }
    return list;
  }

  Future<List<MedicalSupplies>> getByMedicationId(String medicationId) async {
    final mapList = await db.query(
      _tableName,
      where: 'medicationId = ?',
      whereArgs: [medicationId],
    );
    final List<MedicalSupplies> list = [];
    for (final item in mapList) {
      list.add(MedicalSupplies.fromMap(item));
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

  Future<void> save(MedicalSupplies medicalSupplies) async {
    await db.insert(
      _tableName,
      medicalSupplies.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class MedicalSupplies {
  final String medicationId;
  final String drugId;

  MedicalSupplies({
    required this.medicationId,
    required this.drugId,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicationId': medicationId,
      'drugId': drugId,
    };
  }

  factory MedicalSupplies.fromMap(Map<String, dynamic> map) {
    return MedicalSupplies(
      medicationId: map['medicationId'] as String,
      drugId: map['drugId'] as String,
    );
  }

  MedicalSupplies copyWith({
    String? medicationId,
    String? drugId,
  }) {
    return MedicalSupplies(
      medicationId: medicationId ?? this.medicationId,
      drugId: drugId ?? this.drugId,
    );
  }
}
