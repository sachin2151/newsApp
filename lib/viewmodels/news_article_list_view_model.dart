import 'package:flutter/material.dart';
import 'package:news_app_mvvm/models/news_article.dart';
import 'package:news_app_mvvm/services/web_services.dart';
import 'package:news_app_mvvm/viewmodels/news_article_view_model.dart';

enum LoadingStatus{
  completed,
  searching,
  empty
}

class NewsArticleListViewModel with ChangeNotifier{
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<NewsArticleViewModel> articles = <NewsArticleViewModel>[]; 
  
   void topHeadlinesByCountry(String country) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<NewsArticle> newsArticles =
        await WebServices().fetchHeadlinesByCountry(country);

    articles = newsArticles
        .map((article) => NewsArticleViewModel(article: article))
        .toList();

    if (articles.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }
  
  
  
  
  Future topHeadLines() async{

    List<NewsArticle> newsArtciles = await WebServices().fetchTopHeadLines();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();
    articles = newsArtciles.map((article) => NewsArticleViewModel(article: article)).toList();
    if(articles.isEmpty){
      loadingStatus = LoadingStatus.empty;
    }else{
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}