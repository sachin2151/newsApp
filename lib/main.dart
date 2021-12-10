import 'package:flutter/material.dart';
import 'package:news_app_mvvm/screens/news_screen.dart';
import 'package:news_app_mvvm/screens/spalsh_screen.dart';
import 'package:news_app_mvvm/viewmodels/news_article_list_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> NewsArticleListViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
         scaffoldBackgroundColor: const Color(0xfffefdfd),
         appBarTheme: const AppBarTheme(
           color: Color(0xfffefdfd),
           elevation: 0,
           iconTheme: IconThemeData(
             color: Colors.black
           ),
           actionsIconTheme: IconThemeData(
             color: Colors.black
           )
         )
        ),
        home: const SplashScreen(),
          
      ),
    );
  }
}

