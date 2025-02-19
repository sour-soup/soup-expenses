import 'category_dao.dart';
import '../../domain/category/category.dart';

class CategoryRepository {
  final CategoryDao dao;

  CategoryRepository(this.dao);

  Future<List<Category>> getCategories() => dao.fetchCategories();

  Future<void> addCategory(String name, String description) async {
    await dao.insertCategory(Category(name: name, description: description));
  }

  Future<void> removeCategory(int id) async {
    await dao.deleteCategory(id);
  }
}
