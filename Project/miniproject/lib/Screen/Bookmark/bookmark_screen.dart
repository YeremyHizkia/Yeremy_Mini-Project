import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Bookmark/bookmark.dart';
import 'package:miniproject/Screen/Home/Models/news_model.dart';
import 'package:miniproject/Screen/Component/news_view.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<NewsModel> bookmarkedNews = [];

  @override
  void initState() {
    super.initState();
    getBookmarkedNews();
  }

  Future<void> getBookmarkedNews() async {
    final bookmarkNews = BookmarkNews();
    final newsList = await bookmarkNews.getListNewsLocal();

    setState(() {
      bookmarkedNews = newsList;
    });
  }

  Future<void> refreshBookmarkedNews() async {
    final bookmarkNews = BookmarkNews();
    final newsList = await bookmarkNews.getListNewsLocal();

    setState(() {
      bookmarkedNews = newsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Bookmark',
          style: TextStyle(
            color: Colors.green,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshBookmarkedNews,
        child: ListView.builder(
          itemCount: bookmarkedNews.length,
          itemBuilder: (context, index) {
            return newsCard(bookmarkedNews[index]);
          },
        ),
      ),
    );
  }

  Widget newsCard(NewsModel news) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsView(
              newsUrl: news.url ?? '',
              news: news,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            if (news.urlToImage != null)
              Image.network(
                news.urlToImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.title ?? 'No Title',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.description ?? 'Klik untuk melanjutkan!',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
