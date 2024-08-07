import 'package:all_languages_voice_dictionary/database/db_helper.dart';
import 'package:all_languages_voice_dictionary/model/history_model.dart';

class HistoryRepository {

  final dbHelper = DbHelper.dbInstance;

  Future<HistoryModel> insertData(HistoryModel word) async {
    return dbHelper.insertHistory(word);
    //return dbHelper.insertHistory(word);
  }
  Future<List<HistoryModel>> getHistory()async{
    final maps= await dbHelper.readHistory();
    return List.generate(maps.length, (i){
      return HistoryModel(text: maps[i]['text'],id: maps[i]['id']);
    });
  }
Future<int> deleteData(int id)async{
    return dbHelper.deleteHistory(id);
}


}
