import 'package:medication_compliance_assistant/models/drug.dart';
import 'package:sqflite/sqflite.dart';

class DrugsProvider {
  static const _tableName = 'drugs';
  final Database db;

  DrugsProvider(this.db);

  Future<List<Drug>> getAll() async {
    final mapList = await db.query(_tableName);
    final List<Drug> list = [];
    for (final item in mapList) {
      list.add(Drug.fromMap(item));
    }
    return list;
  }

  Future<Drug?> getById(String id) async {
    final list = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return list.isNotEmpty ? Drug.fromMap(list.first) : null;
  }

  Future<int> delete(String id) async {
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> save(Drug drug) async {
    await db.insert(
      _tableName,
      drug.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
