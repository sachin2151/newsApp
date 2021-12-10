import 'package:flutter/material.dart';
import 'package:news_app_mvvm/viewmodels/news_article_view_model.dart';
import 'package:news_app_mvvm/widgets/circle_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticleDetailScreen extends StatelessWidget {
  final NewsArticleViewModel article;

  const NewsArticleDetailScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpeg'),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Author',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    article.author ?? 'Author name not fetched',
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: const [
                  Divider(
                    color: Colors.deepOrange,
                    height: 80,
                    thickness: 20,
                  ),
                  Text(
                    'Headlines',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
              Text(
                article.title ?? "title",
                style: const TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, wordSpacing: 3),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                article.publishedAt,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 220,
                  child: CircleImage(
                    imageUrl: article.imageUrl,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  article.content ?? "description not fetched",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      launch(article.url ?? 'Url unavailable');
                    },
                    child: const Text(
                      'Read more...',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
