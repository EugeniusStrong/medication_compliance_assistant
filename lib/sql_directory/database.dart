import 'dart:io';
import 'package:medication_compliance_assistant/models/user_medication_reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  static const medicalNoteTable = 'medicalNote';
  static const columnId = 'id';
  static const columnFirstName = 'firstName';
  static const columnSecondName = 'secondName';
  static const columnDiagnosis = 'diagnosis';
  static const columnDrugName = 'drugName';
  static const columnDrugDose = 'drugDose';
  static const columnDrugTime = 'drugTime';
  static const columnIsRemind = 'isRemind';

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/MedicalNote.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $medicalNoteTable'
      '($columnId TEXT PRIMARY KEY AUTOINCREMENT,'
      ' $columnFirstName TEXT,'
      ' $columnSecondName TEXT,'
      ' $columnDiagnosis TEXT,'
      ' $columnDrugName TEXT,'
      ' $columnDrugDose TEXT,'
      ' $columnDrugTime TEXT,'
      ' $columnIsRemind INTEGER)',
    );
  }

  Future<List<UserMedicationReminder>> getNotes() async {
    Database? db = await database;
    final List<Map<String, Object?>>? notesMapList =
        await db?.query(medicalNoteTable);
    final List<UserMedicationReminder> notesList = [];
    for (var noteMap in notesMapList!) {
      notesList.add(UserMedicationReminder.fromMap(noteMap));
    }
    return notesList;
  }

  Future<int?> deleteNote(String? id) async {
    Database? db = await database;
    return await db?.delete(
      medicalNoteTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertOrUpdate(
    String? id,
    String? firstName,
    String? secondName,
    String? diagnosis,
    String? drugName,
    String? drugDose,
    DateTime? drugTime,
    bool? isRemind,
  ) async {
    final model = UserMedicationReminder(
      id: id,
      firstName: firstName,
      secondName: secondName,
      diagnosis: diagnosis,
      drugDose: drugDose,
      drugName: drugName,
      drugTime: drugTime,
      isRemind: isRemind,
    );

    int isRemindValue = isRemind != null && isRemind ? 1 : 0;

    Database? db = await database;
    await db!.insert(
        medicalNoteTable,
        {
          columnFirstName: model.firstName,
          columnSecondName: model.secondName,
          columnDiagnosis: model.diagnosis,
          columnDrugName: model.drugName,
          columnDrugDose: model.drugDose,
          columnDrugTime: model.drugTime?.toIso8601String(),
          columnIsRemind: isRemindValue,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
