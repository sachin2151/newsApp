import 'package:flutter/material.dart';

import 'package:news_app_mvvm/screens/news_article_detail_screen.dart';
import 'package:news_app_mvvm/viewmodels/news_article_list_view_model.dart';

import 'package:news_app_mvvm/viewmodels/news_article_view_model.dart';
import 'package:news_app_mvvm/widgets/circle_image.dart';
import 'package:provider/provider.dart';

// class NewsGrid extends StatelessWidget {
//   final List<NewsArticleViewModel> articles;

//   const NewsGrid({Key? key, required this.articles}) : super(key: key);

//   void _showNewsArticlesDetails(
//       BuildContext context, NewsArticleViewModel article) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) {
//           return NewsArticleDetailScreen(
//             article: article,
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate:
//           const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//       itemBuilder: (BuildContext _, int index) {
//         final article = articles[index];
//         return InkWell(
//           onTap: () {
//             _showNewsArticlesDetails(context, article);
//           },
//           child: GridTile(
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//               child: CircleImage(
//                 imageUrl: article.imageUrl,
//               ),
//             ),
//             footer: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 article.title!,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//         );
//       },
//       itemCount: articles.length,
//     );
//   }
// }
void _showNewsArticlesDetails(
    BuildContext context, NewsArticleViewModel article) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) {
        return NewsArticleDetailScreen(
          article: article,
        );
      },
    ),
  );
}

// ignore: must_be_immutable
class FetchingThroughStreamBuilder extends StatefulWidget {
  List<NewsArticleViewModel> article;
  FetchingThroughStreamBuilder({Key? key, required this.article})
      : super(key: key);
  @override
  _FetchingThroughStreamBuilderState createState() =>
      _FetchingThroughStreamBuilderState();
}

class _FetchingThroughStreamBuilderState
    extends State<FetchingThroughStreamBuilder> {
  Stream<List<NewsArticleViewModel>> getNewsArticleStream(
      Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield widget.article;
    }
  }

  Future _refresh() async {
    print('refresh');
    return await Provider.of<NewsArticleListViewModel>(context, listen: false)
        .topHeadLines();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: StreamBuilder<List<NewsArticleViewModel>>(
          stream: getNewsArticleStream(
            const Duration(seconds: 10),
          ),
          builder: (BuildContext context,
              AsyncSnapshot<List<NewsArticleViewModel>> snapshot) {
            // if (!snapshot.hasData) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            // print('data');
            // print(snapshot.data);
            if (snapshot.hasData) {
              List<NewsArticleViewModel>? articles = snapshot.data;
              return GridView.builder(
                  itemCount: articles!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? 2
                          : 3),
                  itemBuilder: (BuildContext _, int index) {
                    final article = articles[index];
                    return InkWell(
                      onTap: () {
                        _showNewsArticlesDetails(context, article);
                      },
                      child: GridTile(
                        key: ValueKey(
                          article.url,
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: CircleImage(
                            imageUrl: article.imageUrl,
                          ),
                        ),
                        footer: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            article.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  });
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Transform.scale(
                    scale: 2.5,
                    child: CircularProgressIndicator.adaptive()),
                  const Padding(
                    padding:  EdgeInsets.only(top: 25),
                    child: Text(
                      "Fetching Top News Headlines",
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  
                ],
              ),
            );
          }),
    );
  }
}
