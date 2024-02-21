


import 'package:flutter_news_app/models/categories_news_model.dart';
import 'package:flutter_news_app/models/news_channel_headlines_model.dart';
import 'package:flutter_news_app/repository/news_repository.dart';

class NewsViewModel{

final _rep = NewsRepository();

Future<NewsChannelsHeadlinesModel> fetchNewsChannelsApi(String newsChannel) async {

final response = await _rep.fetchNewsChannelsApi(newsChannel);

return response ;

}



Future<CategoriesNewsModel> fetchCategorirsNewsApi(String category) async {

final response = await _rep.fetchCategorirsNewsApi(category);

return response ;

}


}