import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Search/models/search_news_model.dart';
import 'package:miniproject/Screen/Search/helpers/api.dart';
import 'package:miniproject/Screen/Search/utils/base.dart';

class NewsViewModel with ChangeNotifier {
  bool isLoading = false;
  SearchNewsModel? searchNews;

  void clearData() {
    searchNews = null;
    notifyListeners();
  }

  Future<void> search(String search) async {
    try {
      final res = await api(
          '${baseUrl}everything?q=$search&sortBy=popularity&apiKey=$apiKey');
      if (res.statusCode == 200) {
        searchNews = SearchNewsModel.fromJson(res.data);
      } else {
        searchNews = SearchNewsModel();
      }
    } catch (e) {
      searchNews = SearchNewsModel();
    }

    isLoading = false;
    notifyListeners();
  }
}
