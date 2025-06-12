import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player_app/Constant/url_const.dart';
import 'package:music_player_app/Models/search_model.dart';
import 'package:music_player_app/Services/dio_connection.dart';

class MySearchControllers extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SearchModel> musicListSearch =
      RxList(); // لیست نتایج جستجو به صورت مدل
  RxString type = "".obs;

  // متد برای جستجوی موسیقی
  void searchMusic(String query) async {
    musicListSearch.clear(); // پاک کردن لیست قبل از جستجو جدید
    isLoading.value = true;
    try {
      var response = await DioServices().getMethod(
        UrlConst.apisearch + query, // آدرس API جستجو
      );
      if (response.statusCode == 200) {
        var results = response.data;
        if (results is List && results.isNotEmpty) {
          final firstType = results[0]['type']?.toString().toLowerCase();

          if (firstType == "music") {
            type.value = "Music";
          } else if (firstType == "singer") {
            type.value = "Singer";
          } else {
            type.value = "Unknown";
          }
        }
        musicListSearch.value = (results as List)
            .map((e) => SearchModel.fromJson(e as Map<String, dynamic>))
            .toList();
        debugPrint("ResultsSearch:$results");
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      debugPrint('Error during search: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
