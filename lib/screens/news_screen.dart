import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_mvvm/utils/constants.dart';
import 'package:news_app_mvvm/viewmodels/news_article_list_view_model.dart';
import 'package:news_app_mvvm/widgets/news_grid.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .topHeadLines();
  }

  void _selectCountry(NewsArticleListViewModel listViewModel, String country) {
    listViewModel.topHeadlinesByCountry(Constants.countries[country] ?? "");
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<NewsArticleListViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              tooltip: 'Select Region',
              elevation: 2,
              color: Colors.grey[300],
              onSelected: (value) {
                _selectCountry(listViewModel, value);
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) {
                return Constants.countries.keys
                    .map((v) => PopupMenuItem(
                          value: v,
                          child: Text(
                            v,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "News",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              const Divider(
                color: Colors.deepOrange,
                height: 40,
                thickness: 8,
                indent: 30,
                endIndent: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 20),
                child: Text(
                  "Today's Headlines",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // Expanded(
              //     child: NewsGrid(
              //   articles: listViewModel.articles,
              // )),
              Expanded(
                  child: FetchingThroughStreamBuilder(
                article: listViewModel.articles,
              )),
            ],
          ),
        ));
  }
// class NewsScreen extends StatelessWidget {
//   const NewsScreen({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         child: Text('Heelo'),
//       ),
//     );
//   }
}

