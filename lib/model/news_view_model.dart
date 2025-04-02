import 'package:headlinehub/model/categories_news_model.dart';
import 'package:headlinehub/model/news_channel_headlines_model.dart';
import 'package:headlinehub/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewschannelHeadlinesApi(
      String source) async {
    return await _rep.fetchNewschannelHeadlinesApi(source);
  }

  Future<CategoryNewsModel> fetchCategoriesNewsApi(
      String category, String source) async {
    return await _rep.fetchCategoriesNewsApi(category, source);
  }
}
