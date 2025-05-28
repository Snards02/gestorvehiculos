import '../models/document_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DocumentService {
  static Future<Database> _db() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'app.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE documents(id INTEGER PRIMARY KEY, type TEXT, expiration_date TEXT, file_path TEXT, vehicle_id INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<List<DocumentModel>> getDocuments(int vehicleId) async {
    final db = await _db();
    final maps = await db.query(
      'documents',
      where: 'vehicle_id = ?',
      whereArgs: [vehicleId],
    );
    return List.generate(
        maps.length,
        (i) => DocumentModel(
              id: maps[i]['id'] as int,
              type: maps[i]['type'] as String,
              expirationDate:
                  DateTime.parse(maps[i]['expiration_date'] as String),
              filePath: maps[i]['file_path'] as String,
              vehicleId: maps[i]['vehicle_id'] as int,
            ));
  }

  static Future<void> saveDocument(DocumentModel doc) async {
    final db = await _db();
    await db.insert('documents', doc.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
