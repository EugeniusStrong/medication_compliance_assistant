import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/MedicalNoteNewBase.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE patients'
      '(id TEXT PRIMARY KEY,'
      'firstName TEXT NOT NULL,'
      'lastName TEXT NOT NULL,'
      'birthDate TEXT NOT NULL,'
      'gender TEXT NOT NULL,'
      'middleName TEXT,'
      'address TEXT)',
    );
    await db.execute(
      'CREATE TABLE drugs'
      '(id TEXT PRIMARY KEY,'
      'name TEXT NOT NULL,'
      'description TEXT NOT NULL,'
      'dose TEXT NOT NULL,'
      'cost INTEGER NOT NULL)',
    );
    await db.execute(
      'CREATE TABLE medication'
      '(id TEXT PRIMARY KEY,'
      'diagnosis TEXT NOT NULL,'
      'patientId TEXT NOT NULL,'
      'therapy TEXT,'
      'recommendations TEXT,'
      'FOREIGN KEY (patientId) REFERENCES patients (id)'
      ')',
    );
    await db.execute(
      'CREATE TABLE medicalSupplies'
      '(medicationId TEXT NOT NULL,'
      'drugId TEXT NOT NULL,'
      'FOREIGN KEY (medicationId) REFERENCES medication (id),'
      'FOREIGN KEY (drugId) REFERENCES drugs (id),'
      'UNIQUE (medicationId,drugId)'
      ')',
    );
  }
}
