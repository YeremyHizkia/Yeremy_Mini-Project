import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Home/Models/news_model.dart';
import 'package:miniproject/Screen/Bookmark/bookmark.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  final String newsUrl;
  final NewsModel news;
  const NewsView({super.key, required this.newsUrl, required this.news});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  WebViewController? _controller;
  bool isBookmark = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.parse(widget.newsUrl));
    checkIsBookmarked();
  }

  void checkIsBookmarked() async {
    final bookmarkNews = BookmarkNews();
    final int newsId = widget.news.id ?? 0;
    final newsModel = await bookmarkNews.getNewsById(newsId);

    setState(() {
      isBookmark = newsModel.id != null;
    });
  }

  Future<void> toggleBookmark() async {
    final bookmarkNews = BookmarkNews();
    print('berfungsi nih');
    final newsModel = NewsModel(
      id: widget.news.id,
      title: widget.news.title,
      url: widget.news.url,
    );

    if (isBookmark) {
      await bookmarkNews.deleteNews(newsModel.id!);
      print('Terhapus nih');
    } else {
      await bookmarkNews.insertNews(newsModel);
    }

    setState(() {
      isBookmark = newsModel.id != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await _controller!.canGoBack()) {
            _controller!.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Container(
              width: 100,
              height: 40,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  toggleBookmark();
                },
                icon: Icon(
                  isBookmark ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmark ? Colors.red : null,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: WebViewWidget(
              controller: _controller!,
            ),
          ),
        ));
  }
}
