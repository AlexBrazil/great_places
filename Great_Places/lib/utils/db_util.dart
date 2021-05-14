import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    // Armazena o caminho onde está o database
    final dbPath = await sql.getDatabasesPath();
    // Será criado um database no path com o nome places.db
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      // Este método é chamado apenas quando o banco é criado
      onCreate: (db, version) {
        // Aqui se usa o DDL - data definitio language
        db.execute(
            'CREATE TABLE places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  // Insere um registro
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      // Caso exista alguma duplicidade será subistituído
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}
