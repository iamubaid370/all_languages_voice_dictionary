
import 'package:all_languages_voice_dictionary/model/favorites_model.dart';
import 'package:all_languages_voice_dictionary/model/history_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DbHelper{
  static final DbHelper dbInstance = DbHelper._internal();

  static Database? _database;
  DbHelper._internal();

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }else{
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async{
    final path = join(await getDatabasesPath(), 'history.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }
  Future _createDb(Database db, int version) async {

    await db.execute('''
  CREATE TABLE history_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text TEXT NOT NULL
  )
  ''');

    await db.execute('''
  CREATE TABLE favorites_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text TEXT NOT NULL
  )
  ''');

  }

  Future<HistoryModel> insertHistory(HistoryModel item)async{
    Database db = await dbInstance.database;

    try {
      final id = await db.insert('history_table', item.toMap());
      print('Inserted item with ID: $id');
      return HistoryModel(text: item.text);
    } catch (e) {
      print('Error inserting history: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> readHistory() async{
    Database db = await dbInstance.database;
    //final List<Map<String, Object?>> queryResult = db.query('history_tale');
    //return queryResult;
    return db.query('history_table');
  }

  Future<int> deleteHistory(int id)async{
    Database db = await dbInstance.database;
    return db.delete('history_table',where: 'id = ?',whereArgs: [id]);
  }






  Future<FavoritesModel> insertFavorites(FavoritesModel item)async{
    Database db = await dbInstance.database;
    await db.insert('favorites_table', item.toMap());
    return item;

  }

  Future<List<Map<String, dynamic>>> readFavorites() async{
    Database db = await dbInstance.database;
    return db.query('favorites_table');
  }

  Future<int> deleteFavorites(int id)async{
    Database db = await dbInstance.database;
    return db.delete('favorites_table',where: 'id = ?',whereArgs: [id]);

    //return db.delete('favorites_table',where: 'word = ?',whereArgs: [word]);
  }



}

///imported data

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../model/history_model.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//
//   static Database? _database;
//
//   DatabaseHelper._init();
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//
//     _database = await _initDB('history.db');
//     return _database!;
//   }
//
//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//   Future _createDB(Database db, int version) async {
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT NOT NULL';
//
//     await db.execute('''
//     CREATE TABLE $tableHistory (
//       ${HistoryFields.id} $idType,
//       ${HistoryFields.text} $textType
//       )
//     ''');
//   }
//
//   Future<HistoryItem> create(HistoryItem item) async {
//     final db = await instance.database;
//
//     final id = await db.insert(tableHistory, item.toMap());
//     return item.copy(id: id);
//   }
//
//   Future<HistoryItem?> readHistoryItem(int id) async {
//     final db = await instance.database;
//
//     final maps = await db.query(
//       tableHistory,
//       columns: HistoryFields.values,
//       where: '${HistoryFields.id} = ?',
//       whereArgs: [id],
//     );
//
//     if (maps.isNotEmpty) {
//       return HistoryItem.fromMap(maps.first);
//     } else {
//       return null;
//     }
//   }
//
//   Future<List<HistoryItem>> readAllHistoryItems() async {
//     final db = await instance.database;
//
//     const orderBy = '${HistoryFields.id} ASC';
//     final result = await db.query(tableHistory, orderBy: orderBy);
//
//     return result.map((json) => HistoryItem.fromMap(json)).toList();
//   }
//
//   Future<int> update(HistoryItem item) async {
//     final db = await instance.database;
//
//     return db.update(
//       tableHistory,
//       item.toMap(),
//       where: '${HistoryFields.id} = ?',
//       whereArgs: [item.id],
//     );
//   }
//
//   Future<int> delete(int id) async {
//     final db = await instance.database;
//
//     return await db.delete(
//       tableHistory,
//       where: '${HistoryFields.id} = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future close() async {
//     final db = await instance.database;
//
//     db.close();
//   }
// }
//
// const String tableHistory = 'history';
