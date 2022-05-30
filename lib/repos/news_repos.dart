

import 'dart:convert';

import '../models/newsModel.dart';
import 'package:http/http.dart' as http;

class NewsRepos{
  Future<ArticlesModel> getNews(String category) async{
    final result = await http.Client().get(Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=315e2c5c75164bfeb0e20f97e1efdb75"));

    if(result.statusCode != 200){
      throw Exception();
    }else{
      return parsedJson(result.body);
    }
  }
  ArticlesModel parsedJson(final response){
    final jsonDecoded = json.decode(response);

    final jsonNews = jsonDecoded["articles"];

    return ArticlesModel.fromJson(jsonNews);

  }
}