

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/newsModel.dart';
import 'repos/news_repos.dart';

class NewsEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class NewsState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class FetchNews extends NewsEvent{
  final _catagory;

   FetchNews(this._catagory);

  @override
  List<Object> get props => [_catagory];

}

class NotFetched extends NewsState{

}

class Fetching extends NewsState{

}

class Fetched extends NewsState{
   late var _news;

   Fetched(this._news);

   ArticlesModel get getNews => _news;
   @override
  List<Object> get props => [_news];
}

class NotLoaded extends NewsState{

}

class NewsBloc extends Bloc<NewsEvent,NewsState>{

  NewsRepos newsRepos;
  NewsBloc(this.newsRepos): super(NotFetched()){
   on<NewsEvent>((event, emit){});
  }
  // NewsBloc(this.newsRepos) : super(NotFetched()){newsRepos = NewsRepos();}
  NewsState get initialState => NotFetched();

  Stream<NewsState> mapEventToState(NewsEvent event) async*{

    if(event is FetchNews) {
      yield Fetching();
      try{
        ArticlesModel article =await newsRepos.getNews(event._catagory);
        yield Fetched(article);
      }catch(_){
        yield NotFetched();
      }
    }
  }

}
