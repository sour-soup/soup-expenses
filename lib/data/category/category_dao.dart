import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/category/category.dart';

class CategoryDao {
  static final CategoryDao instance = CategoryDao._init();
  static Database? _database;

  CategoryDao._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'expenses.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          description TEXT NOT NULL
        )
      ''');
    });
  }

  Future<int> insertCategory(Category category) async {
    final db = await database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<Category>> fetchCategories() async {
    final db = await database;
    final result = await db.query('categories');
    return result.map((e) => Category.fromMap(e)).toList();
  }

  Future<int> deleteCategory(int id) async {
    final db = await database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
