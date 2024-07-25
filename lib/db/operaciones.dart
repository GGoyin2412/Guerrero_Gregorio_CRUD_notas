import 'package:crud_flutter_goyo/modelos/notas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Operaciones {
  static Future<Database> _openDB() async {
  try {
    return await openDatabase(
      join(await getDatabasesPath(), 'notas.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS notas(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  } catch (e) {
    print('Error al abrir la base de datos: $e');
    throw Exception('Error al abrir la base de datos');
  }
}

  // Callback para notificar cambios
  static void Function()? _onDatabaseChange;

  // Método para establecer el callback de cambio
  static void setOnDatabaseChange(void Function()? onChanged) {
    _onDatabaseChange = onChanged;
  }

  // Método para notificar cambios
  static void notifyListeners() {
    if (_onDatabaseChange != null) {
      _onDatabaseChange!();
    }
  }

  static Future<void> insertarOperacion(Nota nota) async {
    Database db = await _openDB();
    await db.insert('notas', nota.toMap());
    notifyListeners(); // Asegúrate de notificar cambios
  }

  static Future<void> actualizarOperacion(Nota nota) async {
    Database db = await _openDB();
    await db.update(
      'notas',
      nota.toMap(),
      where: 'id = ?',
      whereArgs: [nota.id],
    );
    notifyListeners(); // Asegúrate de notificar cambios
  }

  static Future<void> eliminarOperacion(Nota nota) async {
    Database db = await _openDB();
    await db.delete('notas', where: 'id = ?', whereArgs: [nota.id]);
    notifyListeners(); // Asegúrate de notificar cambios
  }

  static Future<List<Nota>> obtenerNotas() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> notasMap = await db.query('notas');

    return List.generate(notasMap.length, (i) {
      return Nota(
        id: notasMap[i]['id'],
        titulo: notasMap[i]['titulo'],
        descripcion: notasMap[i]['descripcion'],
      );
    });
  }
}
