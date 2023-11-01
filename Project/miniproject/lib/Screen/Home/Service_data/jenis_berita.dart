import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miniproject/Screen/Home/Models/pilihan_model.dart';

class JenisBerita {
  List<PilihanModel> jenis = [];

  Future<void> getJenis(String pilihanBerita) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$pilihanBerita&apiKey=7250dd6088ff47b7a0790e32e2e506e3';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          PilihanModel pilihanModel = PilihanModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          jenis.add(pilihanModel);
        }
      });
    }
  }
}
