
import 'package:all_languages_voice_dictionary/database/db_helper.dart';
import 'package:all_languages_voice_dictionary/model/favorites_model.dart';

class FavoritesRepository{

  final  dbHelper = DbHelper.dbInstance;

  Future<FavoritesModel> insertFavorites(FavoritesModel word) async{
    return dbHelper.insertFavorites(FavoritesModel(text: 'word'));
  }
  Future<List<FavoritesModel>> getFavorites() async{
    final maps = await dbHelper.readFavorites();
    return List.generate(maps.length, (i){
      return FavoritesModel(text: maps[i]['text'],id: maps[i]['id']);
    });
  }

  Future<int> deleteFavorites(FavoritesModel favoritesModel) async{
    if(favoritesModel.id == null){
      throw ArgumentError('Id Cant be null');
    }
    return dbHelper.deleteFavorites(favoritesModel.id!);

  }


}