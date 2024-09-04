import 'dart:math';

import 'package:all_languages_voice_dictionary/View/home_screen/homescreen_controller.dart';
import 'package:all_languages_voice_dictionary/ads/adshelper.dart';
import 'package:all_languages_voice_dictionary/database/history_respository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/db_helper.dart';
import '../../model/history_model.dart';

class HistoryScreenController extends GetxController{

  AdsHelper adsHelper = AdsHelper();
  final HistoryRepository historyRepository = HistoryRepository();

  List<HistoryModel> historyList = <HistoryModel>[].obs;

  @override
  void onReady(){
    //adsHelper.loadNativeAd();
    loadHistory();
    print('Native Add loaded');
    super.onReady();
  }
  @override
  void onInit() {
    super.onInit();
    loadAd();

  }

  @override
  void onClose(){
    adsHelper.nativeAd?.dispose();
    debugPrint('HistoryScreenController onClose called,Native Ad disposed');
    super.onClose();
  }

  void loadAd(){
    adsHelper.loadBannerAd();
  }


  // @override
  // void onReady() {
  //  adsHelper.loadNativeAd();
  //   super.onReady();
  // }



  void addToHistory(String word) async {

    // if(!historyList.contains(word)){
    //   historyList.add(word);
    // }

    HistoryModel newItem = HistoryModel(text: word,);
    //await DbHelper.dbInstance.insertHistory(newItem);
    HistoryModel insertedItem = await historyRepository.insertData(newItem);
    if (!historyList.any((item) => item.text == word)) {
      historyList.add(insertedItem);
    }
    update();
  }

  Future<void> loadHistory() async {
    final fetchedHistoryList = await historyRepository.getHistory();
    historyList.assignAll(fetchedHistoryList);
    print('HIstorydarta $historyList');
  }

  Future<void> deleteFromHistory(int item) async {
    // if(historyList.contains(item)){
    //   historyList.remove(item);
    // }
    try{
      await historyRepository.deleteData(item);
     // await DbHelper.dbInstance.deleteHistory(item);
      historyList.remove(item);
      //historyList.removeWhere((historyItem) => historyItem.id == item);
    }catch(e){
      debugPrint('Error deleting item : $e');
    }
    debugPrint('history deleted');

    //historyList.remove(item);

  }



}