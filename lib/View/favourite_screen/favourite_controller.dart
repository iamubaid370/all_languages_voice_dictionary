import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/database/favorites_repository.dart';
import 'package:all_languages_voice_dictionary/model/favorites_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../database/db_helper.dart';
import '../home_screen/homescreen_controller.dart';

class FavouriteController extends GetxController {
  //HomeScreenController homeScreenController = Get.put(HomeScreenController());
  AdsHelper adsHelper = AdsHelper();
  var favouritesList = <FavoritesModel>[].obs;
  var historyList = [].obs;
  bool isFavourite(String text){
    return favouritesList.any((item)=>item.text==text);
  }

  FavoritesRepository favoritesRepository = FavoritesRepository();

  @override
  void onInit() {
    loadFavorites();
    loadAd();
    super.onInit();
  }

  void loadAd(){
    adsHelper.loadBannerAd();
  }

  Future<void> addToFavourites(String word) async {
    // if(!favouritesList.contains(word)){
    //   favouritesList.add(word);

    FavoritesModel newItem = FavoritesModel(text: word);
    FavoritesModel insertedItem = await DbHelper.dbInstance.insertFavorites(newItem);
    favouritesList.add(insertedItem);
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

    var itemToRemove = await favouritesList.firstWhere((item) => item.text == word,
        //orElse: () => null
    );

    if (itemToRemove != null) {
      await favoritesRepository.deleteFavorites(itemToRemove);
   await   favouritesList.remove(itemToRemove);
    }
    print('data deleted');
  }

  Future<void> loadFavorites()async{
    final fetchedFavoritesList = await favoritesRepository.getFavorites();
    favouritesList.assignAll(fetchedFavoritesList);

  }


}