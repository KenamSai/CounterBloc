import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  // Database name and version
  static const String _dbName = 'my_encrypted_db.db';
  static const int _dbVersion = 1;
  static const String _password = 'your_secure_password';

  // Table and columns
  static const String tableUser = 'users';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnEmail = 'email';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      password: _password,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableUser (
     $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL
      )
    ''');
  }

  // CRUD Operations

  // Insert
  Future<void> insertUsersBatch(List<Map<String, dynamic>> users) async {
    final db = await database;
    final batch = db.batch();

    for (Map<String, dynamic> user in users) {
      print(
          "[BATCH] Adding insert: ${user['$columnId']}, ${user["$columnName"]}, ${user["$columnEmail"]}");

      batch.insert(
        tableUser,
        user,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    print("[BATCH] Commit started...");
    await batch.commit(noResult: true);
    print("[BATCH] Commit completed");
  }

  // Query All
  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await database;
    return await db.query(tableUser);
  }

  // Query by ID
  Future<Map<String, dynamic>?> queryUser(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(tableUser, where: '$columnId = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // Update
  Future<int> updateUser(int id, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      tableUser,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete(
      tableUser,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Close database
  Future close() async {
    Database db = await database;
    db.close();
  }

  Future<void> debugPrintUsers() async {
    final db = await database; // your DB instance
    final result = await db.query('users');
    print("Users Table: $result");
  }
}
