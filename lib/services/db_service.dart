import 'package:gestorvh/models/document.dart';
import 'package:gestorvh/models/fuel_log.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/vehicle.dart';

class DBService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'vehiculos.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE vehicles (
            id INTEGER PRIMARY KEY,
            nombre TEXT,
            placa TEXT,
            tipo TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE documents (
            id INTEGER PRIMARY KEY,
            vehicleId INTEGER,
            tipo TEXT,
            vencimiento TEXT,
            archivo TEXT
          )
        ''');

        await db.execute('''
        CREATE TABLE fuel_logs (
          id INTEGER PRIMARY KEY,
          vehicleId INTEGER,
          fecha TEXT,
          monto REAL,
          imagen TEXT
        )
      ''');
      },
    );
  }

  Future<void> insertVehicles(List<Vehicle> vehicles) async {
    final database = await db;
    final batch = database.batch();

    for (var v in vehicles) {
      batch.insert(
        'vehicles',
        v.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Vehicle>> getVehicles() async {
    final database = await db;
    final maps = await database.query('vehicles');
    return maps.map((e) => Vehicle.fromMap(e)).toList();
  }

  Future<void> clearVehicles() async {
    final database = await db;
    await database.delete('vehicles');
  }

  Future<List<Document>> getDocuments(int vehicleId) async {
    final dbClient = await db;
    final maps = await dbClient
        .query('documents', where: 'vehicleId = ?', whereArgs: [vehicleId]);
    return maps.map((e) => Document.fromMap(e)).toList();
  }

  Future<void> insertDocuments(List<Document> docs) async {
    final dbClient = await db;
    final batch = dbClient.batch();
    for (var d in docs) {
      batch.insert('documents', d.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<FuelLog>> getFuelLogs(int vehicleId) async {
    final dbClient = await db;
    final maps = await dbClient
        .query('fuel_logs', where: 'vehicleId = ?', whereArgs: [vehicleId]);
    return maps.map((e) => FuelLog.fromMap(e)).toList();
  }

  Future<void> insertFuelLogs(List<FuelLog> logs) async {
    final dbClient = await db;
    final batch = dbClient.batch();
    for (var l in logs) {
      batch.insert('fuel_logs', l.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }
}
