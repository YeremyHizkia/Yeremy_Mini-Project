import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Home/Models/news_model.dart';
import 'package:miniproject/Screen/Search/models/search_news_model.dart';
import 'package:miniproject/Screen/Search/view_model/search_provider.dart';
import 'package:miniproject/Screen/Home/Widget/widget_tile.dart';
import 'package:miniproject/Screen/Component/news_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  NewsModel searchNews(Articles article) {
    return NewsModel(
      title: article.title ?? '',
      author: article.author ?? '',
      description: article.description ?? '',
      url: article.url ?? '',
      urlToImage: article.urlToImage ?? '',
      content: article.content ?? '',
      newsUrl: article.url ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsViewModel>(
      builder: (BuildContext context, news, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search News'),
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'What news?',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchController.clear();
                        Provider.of<NewsViewModel>(context, listen: false)
                            .clearData();
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      onPressed: () {
                        final searchText = searchController.text;
                        if (searchText.isNotEmpty) {
                          Provider.of<NewsViewModel>(context, listen: false)
                              .search(searchText);
                        }
                      },
                      child: const Text('Search'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (news.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else if (news.searchNews != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: news.searchNews!.articles?.length ?? 0,
                    itemBuilder: (context, index) {
                      final article = news.searchNews!.articles![index];
                      final newsModel = searchNews(article);
                      return BlogTile(
                        imageUrl: article.urlToImage ?? '',
                        desc: article.description ?? '',
                        title: article.title ?? '',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsView(
                                newsUrl: article.url ?? '',
                                news: newsModel,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
