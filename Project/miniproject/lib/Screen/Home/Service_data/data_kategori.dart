import 'package:miniproject/Screen/Home/Models/kategori_model.dart';

List<KategoriModel> getKategori() {
  List<KategoriModel> category = [];
  KategoriModel kategoriModel = KategoriModel();

  kategoriModel.categoriesName = "Business";
  kategoriModel.image = 'assets/images/business.jpg';
  category.add(kategoriModel);
  kategoriModel = KategoriModel();

  kategoriModel.categoriesName = "Entertainment";
  kategoriModel.image = 'assets/images/entertainment.jpg';
  category.add(kategoriModel);
  kategoriModel = KategoriModel();

  kategoriModel.categoriesName = "General";
  kategoriModel.image = 'assets/images/general.jpg';
  category.add(kategoriModel);
  kategoriModel = KategoriModel();

  kategoriModel.categoriesName = "Health";
  kategoriModel.image = 'assets/images/health.jpg';
  category.add(kategoriModel);
  kategoriModel = KategoriModel();

  kategoriModel.categoriesName = "Science";
  kategoriModel.image = 'assets/images/science.jpg';
  category.add(kategoriModel);
  kategoriModel = KategoriModel();

  kategoriModel.categoriesName = "Sports";
  kategoriModel.image = 'assets/images/sports.jpg';
  category.add(kategoriModel);
  kategoriModel = KategoriModel();

  return category;
}
