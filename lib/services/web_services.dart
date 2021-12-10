import 'dart:convert';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:dio/dio.dart';
import 'package:news_app_mvvm/models/news_article.dart';
import 'package:news_app_mvvm/utils/constants.dart';
// import 'package:http/http.dart' as http;

class WebServices {
  var dio = Dio();

  Future<List<NewsArticle>> fetchHeadlinesByCountry(String country) async {
    final response = await dio.get(Constants.headlinesFor(country));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception("Failled to get top news");
    }
  }

//   Future<List<NewsArticle>> fetchTopHeadLines() async {
//     var isCacheExixts =
//         await APICacheManager().isAPICacheKeyExist('Api_Country');
//     if (!isCacheExixts) {
//       var url = Constants.topHeadLines;
//       print("url_hit");

//       try {
//         final response = await dio.get(url);
//         if (response.statusCode == 200) {
//           APICacheDBModel cacheDBModel = APICacheDBModel(
//             key: 'Api_Country', syncData: response.data);
//             await APICacheManager().addCacheData(cacheDBModel); 
//           final result = response.data;
//           Iterable list = result['articles'];
//           return list.map((article) => NewsArticle.fromJson(article)).toList();
//         }
//       } on DioError catch (e) {
//         if (e.type == DioErrorType.response) {
//           print('catched');
//         }
//         if (e.type == DioErrorType.connectTimeout) {
//           print('check your connection');
//         }

//         if (e.type == DioErrorType.receiveTimeout) {
//           print('unable to connect to the server');
//         }

//         if (e.type == DioErrorType.other) {
//           print('Something went wrong');
//         }
//       }
//       throw Exception('Failed to get top headlines');
//     }else{
//       print('Cache_hit');
//     var cacheData= await APICacheManager().getCacheData('Api_Country');
//     return jsonDecode(cacheData.syncData);
//     }
//   }
// }

  Future<List<NewsArticle>> fetchTopHeadLines() async {
    var url = Constants.topHeadLines;

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final result = response.data;
        Iterable list = result['articles'];
        return list.map((article) => NewsArticle.fromJson(article)).toList();
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('catched');
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
      }
    }
    throw Exception('Failed to get top headlines');

    
  }
}
