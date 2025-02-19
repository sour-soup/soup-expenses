import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/category/category_provider.dart';
import 'add_category_widget.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Категории')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return ListTile(
            title: Text(category.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(categoryProvider.notifier).removeCategory(category.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => AddCategoryWidget(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
