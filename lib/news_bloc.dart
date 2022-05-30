// import 'dart:async';
// import 'dart:convert';
//
// import 'package:assignment_l1/model/article_model.dart';
// import 'package:assignment_l1/repos/news_repos.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
//
// enum NewsAction { fetch, science, sports }
//
// class NewsBloc {
//   final _stateStreamController = StreamController<List<Articles>>.broadcast();
//
//   StreamSink<List<Articles>> get _newsSink => _stateStreamController.sink;
//
//   Stream<List<Articles>> get newsStream => _stateStreamController.stream;
//
//   final _eventStreamController = StreamController<NewsAction>.broadcast();
//
//   StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
//
//   Stream<NewsAction> get _eventStream => _eventStreamController.stream;
//
//   NewsBloc(NewsRepos newsRepos) {
//     _eventStream.listen((event) async {
//       if (event == NewsAction.fetch) {
//         _newsSink.add(articleList);
//       }
//     });
//   }
//
//   void dispose() {
//     _stateStreamController.close();
//     _eventStreamController.close();
//   }
// }
//
// List<Articles> articleList = [];
//
// Future<List<Articles>> api() async {
//   // var newsModel;
//
//   String url =
//       "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=315e2c5c75164bfeb0e20f97e1efdb75";
//   Response res = await get(Uri.parse(url));
//   print(res.statusCode);
//
//   // var response = await get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=315e2c5c75164bfeb0e20f97e1efdb75'));
//   // if(response.statusCode ==200){
//   //   var jsonString = response.body;
//   //   var jsonMap = json.decode(jsonString);
//   //   try {
//   //     newsModel = Articles.fromJson(jsonMap);
//   //   }catch(e){
//   //     return newsModel;
//   //   }
//   //   return newsModel;
//   //
//   // }
//
//   var data = jsonDecode(res.body);
//
//   var articleData = data['articles'];
//   for (var i in articleData) {
//     Articles aData = Articles(
//         // source: i['source'],
//         author: i['author'],
//         title: i['title'],
//         url: i['url'],
//         urlToImage: i['urlToImage'],
//         publishedAt: i['publishedAt'],
//         description: i['description'],
//         content: i['content']);
//     articleList.add(aData);
//   }
//   print(articleList[0]);
//   return articleList;
// }
