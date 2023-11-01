import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:miniproject/Screen/Home/Models/news_model.dart';
import 'package:miniproject/Screen/Component/news_view.dart';
import 'package:miniproject/Screen/Home/Service_data/jenis_berita.dart';
import 'package:miniproject/Screen/Home/Models/pilihan_model.dart';

class PilihanBerita extends StatefulWidget {
  final String name;

  const PilihanBerita({required this.name, Key? key}) : super(key: key);

  @override
  _PilihanBeritaState createState() => _PilihanBeritaState();
}

class _PilihanBeritaState extends State<PilihanBerita> {
  List<PilihanModel> jenis = [];

  @override
  void initState() {
    super.initState();
    getJenisBerita();
  }

  getJenisBerita() async {
    JenisBerita jenisBerita = JenisBerita();
    await jenisBerita.getJenis(widget.name.toLowerCase());
    if (mounted) {
      setState(() {
        jenis = jenisBerita.jenis;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: jenis.length,
          itemBuilder: (context, index) {
            return JenisKategori(
              jenis: jenis[index],
            );
          },
        ),
      ),
    );
  }
}

class JenisKategori extends StatelessWidget {
  final PilihanModel jenis;

  const JenisKategori({
    Key? key,
    required this.jenis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsView(
              newsUrl: jenis.url ?? '',
              news: NewsModel(
                title: jenis.title,
                urlToImage: jenis.urlToImage,
                description: jenis.description,
                url: jenis.url,
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: jenis.urlToImage ?? '',
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            jenis.title ?? '',
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(
            child: Text(
              jenis.description ?? '',
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
