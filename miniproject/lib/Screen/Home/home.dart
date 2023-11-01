import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Home/Models/kategori_model.dart';
import 'package:miniproject/Screen/Home/Models/news_model.dart';
import 'package:miniproject/Screen/Home/Service_data/data.dart';
import 'package:miniproject/Screen/Home/Service_data/news.dart';
import 'package:miniproject/Screen/Home/Widget/widget_kategoris.dart';
import 'package:miniproject/Screen/Home/Widget/widget_tile.dart';
import 'package:miniproject/Screen/Login/utils/login_setting.dart';
import 'package:miniproject/Screen/Component/news_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int slideIndex = 0;

  List<KategoriModel> categories = [];
  List<NewsModel> news = [];
  bool _loading = true;
  bool isLoggedIn = false;
  String _username = "";

  @override
  void initState() {
    categories = getKategori();
    getNews();
    checkLoginStatus();
    super.initState();
    getUserEmail();
  }

  void getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('user_email');

    if (userEmail != null) {
      setState(() {
        _username = userEmail;
      });
    }
  }

  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  void showRegistrationAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Silahkan Daftar dahulu'),
          actions: <Widget>[
            TextButton(
              child: const Text('Daftar'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/daftar');
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Apakah Anda ingin logout?'),
          actions: [
            TextButton(
              onPressed: () async {
                UserManager userManager = UserManager();
                await userManager.hapusEmail();

                setState(() {
                  isLoggedIn = false;
                });
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                if (!context.mounted)
                  return; // code nya menghindari error do not use BuildContext across async gaps.
                Navigator.of(context).pop();
                showRegistrationAlert(context);
              },
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  void _showProfileMenu(BuildContext context) {
    if (isLoggedIn) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text(
                  'Halo, $_username',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      showRegistrationAlert(context);
    }
  }

  void getNews() async {
    News newsarticle = News();
    await newsarticle.getNews();
    newsarticle.news.forEach((element) {
      if (element.urlToImage != null && element.description != null) {
        NewsModel newsModel = NewsModel(
          title: element.title,
          author: element.author,
          description: element.description,
          url: element.url,
          urlToImage: element.urlToImage,
          content: element.content,
        );
        newsModel.newsUrl = element.url;
        if (mounted) {
          setState(() {
            news.add(newsModel);
          });
        }
      }
    });

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "E-",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "News",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (isLoggedIn) {
                _showProfileMenu(context);
              } else {
                showRegistrationAlert(context);
              }
            },
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return KategorisWidget(
                          image: categories[index].image,
                          categoriesName:
                              categories[index].categoriesName ?? '',
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Text(
                      'News Update!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: news[index].urlToImage!,
                        desc: news[index].description!,
                        title: news[index].title!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsView(
                                newsUrl: news[index].newsUrl ?? '',
                                news: news[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
