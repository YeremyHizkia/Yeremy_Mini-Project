class NewsModel {
  int? id;
  String? title;
  String? author;
  String? description;
  String? url;
  String? urlToImage;
  String? content;
  String? newsUrl;

  NewsModel({
    this.id,
    this.title,
    this.author,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
    this.newsUrl,
  });

  NewsModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    author = map['author'];
    description = map['description'];
    url = map['url'];
    urlToImage = map['urlToImage'];
    content = map['content'];
    newsUrl = map['newsUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
      'newsUrl': newsUrl,
    };
  }
}
