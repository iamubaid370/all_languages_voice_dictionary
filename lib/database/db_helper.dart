
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

    await db.execute('''
  CREATE TABLE settings_table (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key TEXT NOT NULL,
    value TEXT NOT NULL
  )
  ''');

  }

  Future<HistoryModel> insertHistory(HistoryModel item)async{
    Database db = await dbInstance.database;

    try {
      final id = await db.insert('history_table', item.toMap());
      print('Inserted item with ID: $id');
      return HistoryModel(text: item.text,id: id);
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
    final id = await db.insert('favorites_table', item.toMap());
    return FavoritesModel(text: item.text,id: id);

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



  /// Insert or update the notification setting
  Future<void> insertOrUpdateNotificationSetting(bool value) async {
    Database db = await dbInstance.database;
    await db.insert(
      'settings_table',
      {'key': 'notificationValue', 'value': value ? 'true' : 'false'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('data added to the db:$value');
  }

 /// Get the notification setting
  Future<bool> getNotificationSetting() async {
    Database db = await dbInstance.database;
    final result = await db.query(
      'settings_table',
      where: 'key = ?',
      whereArgs: ['notificationValue'],
    );

    if (result.isNotEmpty) {
      return result.first['value'] == 'true';
    } else {
      return false;
    }
  }




}


