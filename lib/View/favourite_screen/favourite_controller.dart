import 'package:all_languages_voice_dictionary/database/favorites_repository.dart';
import 'package:all_languages_voice_dictionary/model/favorites_model.dart';
import 'package:get/get.dart';

import '../../database/db_helper.dart';
import '../home_screen/homescreen_controller.dart';

class FavouriteController extends GetxController {
  //HomeScreenController homeScreenController = Get.put(HomeScreenController());
  var favouritesList = <FavoritesModel>[].obs;
  var historyList = [].obs;
  FavoritesRepository favoritesRepository = FavoritesRepository();

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  void addToFavourites(String word) async {
    // if(!favouritesList.contains(word)){
    //   favouritesList.add(word);

    FavoritesModel newItem = FavoritesModel(text: word);
    await DbHelper.dbInstance.insertFavorites(newItem);
    favouritesList.add(newItem);
  }


  Future<void> deleteFromFavourite(String word) async {
    // if(favouritesList.contains(word)){
    //   favouritesList.remove(word);
    //
    // }
    // await DbHelper.dbInstance.deleteFavorites(word);
    // favouritesList.removeWhere((item) {
    //   return item.id == id;
    // });

    var itemToRemove = favouritesList.firstWhere((item) => item.text == word,
        //orElse: () => null
    );

    if (itemToRemove != null) {
      await favoritesRepository.deleteFavorites(itemToRemove);
      favouritesList.remove(itemToRemove);
    }
    print('data deleted');
  }

  Future<void> loadFavorites()async{
    final fetchedFavoritesList = await favoritesRepository.getFavorites();
    favouritesList.assignAll(fetchedFavoritesList);

  }


}