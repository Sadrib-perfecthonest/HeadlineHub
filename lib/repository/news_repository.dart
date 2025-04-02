import 'dart:convert';
import 'package:headlinehub/model/categories_news_model.dart';
import 'package:headlinehub/model/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewschannelHeadlinesApi(
      String source) async {
    String url = '';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Failed to load news channel headlines');
  }

  Future<CategoryNewsModel> fetchCategoriesNewsApi(
      String category, String source) async {
    String url = '';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoryNewsModel.fromJson(body);
    }
    throw Exception('Failed to load news channel headlines');
  }
}
