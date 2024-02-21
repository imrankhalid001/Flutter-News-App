
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_news_app/models/categories_news_model.dart';
import 'package:flutter_news_app/models/news_channel_headlines_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository{

Future<NewsChannelsHeadlinesModel> fetchNewsChannelsApi(String newsChannel) async {

String newsUrl = "https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=67914281130e4b1cb1e8999bc13dd099";

  print(newsUrl);
final response = await http.get(Uri.parse(newsUrl));
if(kDebugMode)
{
  print(response.body);
}


if(response.statusCode == 200)
{
  final body = jsonDecode(response.body);
return NewsChannelsHeadlinesModel.fromJson(body);
}
else{
  throw Exception("error");
}

}




Future<CategoriesNewsModel> fetchCategorirsNewsApi(String category) async {

String newsUrl = "https://newsapi.org/v2/everything?q=${category}&apiKey=67914281130e4b1cb1e8999bc13dd099";

  print(newsUrl);
final response = await http.get(Uri.parse(newsUrl));
if(kDebugMode)
{
  print(response.body);
}


if(response.statusCode == 200)
{
  final body = jsonDecode(response.body);
return CategoriesNewsModel.fromJson(body);
}
else{
  throw Exception("error");
}

}





}