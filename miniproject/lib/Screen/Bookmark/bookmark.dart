import 'package:miniproject/Screen/Home/Models/news_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkNews {
  static BookmarkNews? _databaseHelper;
  static late Database _database;

  BookmarkNews._internal() {
    _databaseHelper = this;
  }

  factory BookmarkNews() => _databaseHelper ?? BookmarkNews._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  String newsTable = 'newsTable';

  Future<Database> _initializeDb() async {
    var db = await openDatabase(
      join(
        await getDatabasesPath(),
        'news_db.db',
      ),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $newsTable(
        id INTEGER PRIMARY KEY,
        title TEXT,
        author TEXT,  
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        content TEXT,  
        newsUrl TEXT
      )''');
      },
      version: 1,
    );

    return db;
  }

  // INSERT NEWS
  Future<void> insertNews(NewsModel newsModel) async {
    final db = await database;
    await db.insert(newsTable, newsModel.toMap());
  }

  // DELETE NEWS
  Future<void> deleteNews(int id) async {
    final db = await database;
    await db.delete(newsTable, where: "id = ?", whereArgs: [id]);
  }

  // GET NEWS BY ID
  Future<NewsModel> getNewsById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      newsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.map((e) => NewsModel.fromMap(e)).toList().first;
    } else {
      return NewsModel();
    }
  }

  // Get List News from Local DB
  Future<List<NewsModel>> getListNewsLocal() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      newsTable,
    );

    return result.map((e) => NewsModel.fromMap(e)).toList();
  }
}
