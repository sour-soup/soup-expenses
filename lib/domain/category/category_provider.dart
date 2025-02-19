import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'category.dart';
import '../../data/category/category_repository.dart';
import '../../data/category/category_dao.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository(CategoryDao.instance));

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier(ref.watch(categoryRepositoryProvider));
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  final CategoryRepository repository;

  CategoryNotifier(this.repository) : super([]) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    state = await repository.getCategories();
  }

  Future<void> addCategory(String name, String description) async {
    await repository.addCategory(name, description);
    loadCategories();
  }

  Future<void> removeCategory(int? id) async {
    if(id == null) return;
    await repository.removeCategory(id);
    loadCategories();
  }
}
