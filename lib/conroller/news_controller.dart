import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class NewsController extends GetxController {
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=54145bc9681c42de9a6cc831aa90502b';
  // Define an observable list to store news data
  var newsList = <ArticleModel>[].obs;

  // Function to fetch news data
  Future<void> fetchNews() async {
    log(newsList.toString());
    try {
      ///final response = await http.get(Uri.parse(apiUrl));
      var response = await http.get(Uri.parse(apiUrl));

      var jsonData = jsonDecode(response.body);
      log(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData["articles"].forEach((element) {
          if (element["urlToImage"] != null && element['description'] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
              author: element["author"],
            );
            newsList.add(articleModel);
          }
        });
      }
    } catch (e) {
      log('Error fetching news: $e');
    }
  }
}
